import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_applicatiomconecta2/l10n/app_localizations.dart';

import '../services/api_service.dart';
import '../services/api_service_payment.dart';
import '../widgets/account_management_sheet.dart';
import '../widgets/profile_popover.dart';
import '../utils/categories.dart';
import '../widgets/current_location_map.dart';
import '../widgets/payment_checkout_sheet.dart';

const _primary = Color(0xFF2E7D32);

class ClientHome extends StatefulWidget {
  static const String routeName = '/clientHome';
  const ClientHome({super.key});
  @override
  State<ClientHome> createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome>
    with SingleTickerProviderStateMixin {
  late TabController _tab;

  Map<String, dynamic>? _profile;
  int? _clientId;
  AppLocalizations get _l10n => AppLocalizations.of(context)!;
  bool _didLoadArgs = false;
  Map<String, dynamic>? _initialArgs;

  List<Map<String, dynamic>> _services = [];
  List<Map<String, dynamic>> _expiredServices = [];
  bool _loading = false;
  final Set<int> _expiryWarningIds = {};
  final Set<int> _autoDeletedServiceIds = {};

  // Ofertas in-app
  List<Map<String, dynamic>> _offers = [];
  bool _offersLoading = false;
  String? _offersError;
  final Duration _offersPollEvery = const Duration(seconds: 15);
  Timer? _offersPollTimer;
  final Map<int, Map<String, dynamic>> _pendingPaymentsByService = {};
  StateSetter? _notificationsSetState;

  final List<String> _categorias = kServiceCategoryLabels.keys.toList();

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
    _reload();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didLoadArgs) return;
    _didLoadArgs = true;
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map) {
      _initialArgs = Map<String, dynamic>.from(
        args.map((k, v) => MapEntry(k.toString(), v)),
      );
      _clientId = _asInt(args['userId'] ?? args['id']);
      final profileArg = args['profile'];
      if (profileArg is Map<String, dynamic>) {
        _profile = Map<String, dynamic>.from(profileArg);
      } else if (profileArg is Map) {
        _profile = profileArg.map((k, v) => MapEntry(k.toString(), v));
      }
    }

    if (_clientId != null) {
      _refreshProfile();
      _startOffersPolling();
    }
  }

  @override
  void dispose() {
    _tab.dispose();
    _stopOffersPolling();
    super.dispose();
  }

  int? _asInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  double? _asDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      final normalized = value.replaceAll(',', '.');
      return double.tryParse(normalized);
    }
    return null;
  }

  String _formatCurrency(double? value) {
    if (value == null) return '';
    final bool isInt = value % 1 == 0;
    final amount = isInt ? value.toStringAsFixed(0) : value.toStringAsFixed(2);
    return '\$$amount';
  }

  String _participantLabel(dynamic raw) {
    final value = raw?.toString().trim();
    if (value == null || value.isEmpty) return '';
    final upper = value.toUpperCase();
    switch (upper) {
      case 'CLIENTE':
      case 'CUSTOMER':
        return _l10n.clientLabel;
      case 'TRABAJADOR':
      case 'WORKER':
        return _l10n.workerLabel;
      default:
        return value[0].toUpperCase() + value.substring(1).toLowerCase();
    }
  }

  String _negotiationStateLabel(dynamic raw) {
    final value = raw?.toString().trim();
    if (value == null || value.isEmpty) return '';
    final upper = value.toUpperCase();
    switch (upper) {
      case 'EN_NEGOCIACION':
        return _l10n.negotiationInNegotiation;
      case 'EN_CURSO':
      case 'EN_PROCESO':
        return _l10n.negotiationInProgress;
      case 'ACEPTADA':
        return _l10n.negotiationAccepted;
      case 'RECHAZADA':
        return _l10n.negotiationRejected;
      case 'CERRADA':
        return _l10n.negotiationClosed;
      case 'PENDIENTE':
        return _l10n.negotiationPending;
      default:
        return value[0].toUpperCase() + value.substring(1).toLowerCase();
    }
  }

  String _serviceStateLabel(dynamic raw) {
    final value = raw?.toString().trim() ?? '';
    if (value.isEmpty) return _l10n.serviceStatePending;
    switch (value.toUpperCase()) {
      case 'PENDIENTE':
        return _l10n.serviceStatePending;
      case 'PENDIENTE_PAGO':
        return _l10n.serviceStatePaymentPending;
      case 'ASIGNADO':
      case 'EN_PROCESO':
      case 'EN_CURSO':
        return _l10n.serviceStateInProgress;
      case 'FINALIZADO':
        return _l10n.serviceStateFinished;
      case 'CANCELADO':
        return _l10n.serviceStateExpired;
      default:
        return value[0].toUpperCase() + value.substring(1).toLowerCase();
    }
  }

  bool _isClientTurn(dynamic raw) {
    final value = raw?.toString().trim();
    if (value == null || value.isEmpty) return true;
    final upper = value.toUpperCase();
    return upper == 'CLIENTE' || upper == 'CUSTOMER';
  }

  int? _serviceIdFromOffer(Map<String, dynamic> offer) {
    final direct = _asInt(
      offer['serviceId'] ??
          offer['servicioId'] ??
          offer['servicio_id'] ??
          offer['servicioID'],
    );
    if (direct != null) return direct;
    final nested = offer['service'] ?? offer['servicio'];
    if (nested is Map) return _asInt(nested['id']);
    return null;
  }

  int? _serviceIdFromService(Map<String, dynamic> service) {
    final v = service['id'];
    if (v is int) return v;
    if (v == null) return null;
    final asString = v.toString();
    return int.tryParse(asString);
  }

  DateTime? _serviceDateFromService(Map<String, dynamic> service) {
    final raw = (service['fechaEstimada'] ??
            service['fecha'] ??
            service['fechaServicio'] ??
            '')
        .toString();
    if (raw.isEmpty) return null;
    final parsed = DateTime.tryParse(raw);
    if (parsed != null) return parsed;
    final milliseconds = int.tryParse(raw);
    if (milliseconds != null)
      return DateTime.fromMillisecondsSinceEpoch(milliseconds);
    final asDouble = double.tryParse(raw);
    if (asDouble != null)
      return DateTime.fromMillisecondsSinceEpoch(asDouble.toInt());
    return null;
  }

  String? _serviceTitleById(int? serviceId) {
    if (serviceId == null) return null;
    for (final service in _services) {
      final id = _serviceIdFromService(service);
      if (id != null && id == serviceId) {
        final title = (service['titulo'] ??
                service['nombre'] ??
                service['tituloServicio'] ??
                '')
            .toString();
        if (title.isNotEmpty) return title;
      }
    }
    return null;
  }

  Map<String, dynamic>? _pendingPaymentForService(int? serviceId) {
    if (serviceId == null) return null;
    return _pendingPaymentsByService[serviceId];
  }

  int? _offerIdForService(int? serviceId) {
    if (serviceId == null) return null;
    final pending = _pendingPaymentsByService[serviceId];
    final candidate = _asInt(
      pending?['offerId'] ??
          pending?['ofertaId'] ??
          pending?['offer_id'],
    );
    if (candidate != null) return candidate;
    for (final offer in _offers) {
      final sid = _serviceIdFromOffer(offer);
      if (sid != null && sid == serviceId) {
        final negotiation = (offer['estadoNegociacion'] ?? offer['estado'] ?? '')
            .toString()
            .toUpperCase();
        if (negotiation == 'PENDIENTE_DE_PAGO' || negotiation == 'ACEPTADA') {
          final id = _asInt(offer['id']);
          if (id != null) return id;
        }
      }
    }
    return null;
  }

  Future<int?> _resolveOfferIdForService(int serviceId) async {
    final direct = _offerIdForService(serviceId);
    if (direct != null) return direct;
    await _fetchOffers();
    return _offerIdForService(serviceId);
  }

  Future<void> _startPaymentFlow(int? serviceId, {String? serviceTitle}) async {
    if (serviceId == null) {
      _showClientNotification(
        'No fue posible determinar el servicio para el pago.',
        background: Colors.red,
      );
      return;
    }
    final offerId = await _resolveOfferIdForService(serviceId);
    if (offerId == null) {
      _showClientNotification(
        'No fue posible encontrar la oferta asociada al servicio.',
        background: Colors.red,
      );
      return;
    }
    final normalized = await _createIntentAndQueuePendingPayment(
      offerId: offerId,
      serviceId: serviceId,
      serviceTitle: serviceTitle ?? _serviceTitleById(serviceId),
    );
    if (normalized != null) {
      await _openPaymentCheckout(
        offerId: offerId,
        serviceId: serviceId,
        initialInfo: normalized,
      );
    }
  }

  Map<String, dynamic>? _stringKeyedMap(dynamic raw) {
    if (raw is Map<String, dynamic>) return raw;
    if (raw is Map) {
      return raw.map((key, value) => MapEntry(key.toString(), value));
    }
    return null;
  }

  Map<String, dynamic>? _normalizePaymentInfo(
    dynamic raw, {
    int? fallbackServiceId,
    int? fallbackOfferId,
    String? fallbackServiceTitle,
  }) {
    final base = _stringKeyedMap(raw);
    if (base == null) return null;
    Map<String, dynamic> map = Map<String, dynamic>.from(base);
    if (map['paymentInfo'] is Map) {
      final nested = _stringKeyedMap(map['paymentInfo']);
      if (nested != null) {
        map = {
          ...map,
          ...nested,
        };
      }
    }

    final serviceId = _asInt(
      map['serviceId'] ??
          map['servicioId'] ??
          map['service_id'] ??
          fallbackServiceId,
    );
    final offerId = _asInt(
      map['offerId'] ?? map['ofertaId'] ?? map['oferta_id'] ?? fallbackOfferId,
    );

    final paymentIntentId =
        map['paymentIntentId'] ?? map['paymentIntent'] ?? map['intentId'];
    final clientSecret = map['paymentClientSecret'] ??
        map['clientSecret'] ??
        map['client_secret'];
    final status =
        (map['paymentStatus'] ?? map['payment_state'] ?? map['status'] ?? '')
            .toString();
    final amount = _asDouble(map['amount'] ?? map['monto'] ?? map['precio']);
    final currency = map['currency'] ?? map['moneda'];
    final serviceTitle = (map['serviceTitle'] ??
            map['tituloServicio'] ??
            fallbackServiceTitle ??
            '')
        .toString();

    return {
      ...map,
      if (serviceId != null) 'serviceId': serviceId,
      if (offerId != null) 'offerId': offerId,
      if (paymentIntentId != null) 'paymentIntentId': paymentIntentId,
      if (clientSecret != null) 'paymentClientSecret': clientSecret,
      if (status.isNotEmpty) 'paymentStatus': status,
      if (amount != null) 'amount': amount,
      if (currency != null) 'currency': currency,
      if (serviceTitle.isNotEmpty) 'serviceTitle': serviceTitle,
    };
  }

  Future<void> _refreshPaymentStatus({
    required Map<String, dynamic> current,
    int? fallbackOfferId,
    int? fallbackServiceId,
    String? fallbackServiceTitle,
  }) async {
    final intentId = current['paymentIntentId']?.toString() ??
        current['payment_intent_id']?.toString() ??
        current['id']?.toString();
    if (intentId == null || intentId.isEmpty) return;
    final response =
        await ApiServicePayment.getPaymentStatus(paymentIntentId: intentId);
    final combined = <String, dynamic>{
      ...current,
      ...response,
      if (fallbackOfferId != null) 'offerId': fallbackOfferId,
      if (fallbackServiceId != null) 'serviceId': fallbackServiceId,
      if (fallbackServiceTitle != null && fallbackServiceTitle.isNotEmpty)
        'serviceTitle': fallbackServiceTitle,
    };
    final normalized = _normalizePaymentInfo(
      combined,
      fallbackOfferId: fallbackOfferId,
      fallbackServiceId: fallbackServiceId,
      fallbackServiceTitle: fallbackServiceTitle,
    );
    final infoForQueue = normalized ?? combined;
    final serviceIdToUpdate =
        _asInt(infoForQueue['serviceId'] ?? fallbackServiceId);
    final statusUpper =
        _paymentStatusUpper(infoForQueue['paymentStatus'] ?? infoForQueue['status']);
    if (infoForQueue.isNotEmpty) {
      _queuePaymentInfoUpdate(infoForQueue);
    }
    if (serviceIdToUpdate != null) {
      final serviceState =
          _serviceStateFromPayload(response) ?? _serviceStateFromPayload(combined);
      String? nextState = serviceState;
      if (nextState == null || nextState.isEmpty) {
        if (statusUpper == 'SUCCEEDED') {
          nextState = 'ASIGNADO';
        } else if (statusUpper == 'FAILED' || statusUpper == 'REQUIRES_PAYMENT_METHOD') {
          nextState = 'PENDIENTE';
        } else if (statusUpper.isNotEmpty) {
          nextState = 'PENDIENTE_PAGO';
        }
      }
      if (nextState != null && nextState.isNotEmpty) {
        _updateLocalServiceState(serviceIdToUpdate, nextState);
      }
    }
  }

  String _paymentStatusUpper(dynamic raw) {
    if (raw == null) return '';
    final text = raw.toString().trim();
    if (text.isEmpty) return '';
    return text.toUpperCase();
  }

  String _paymentStatusLabel(dynamic raw) {
    final upper = _paymentStatusUpper(raw);
    switch (upper) {
      case 'PENDING':
        return _l10n.paymentStatusPending;
      case 'REQUIRES_PAYMENT_METHOD':
        return _l10n.paymentStatusRequiresPaymentMethod;
      case 'REQUIRES_ACTION':
        return _l10n.paymentStatusRequiresAction;
      case 'SUCCEEDED':
        return _l10n.paymentStatusSucceeded;
      case 'FAILED':
        return _l10n.paymentStatusFailed;
      case 'NOT_REQUIRED':
        return _l10n.paymentStatusNotRequired;
      default:
        return upper.isEmpty
            ? _l10n.paymentStatusDefault
            : upper[0].toUpperCase() + upper.substring(1).toLowerCase();
    }
  }

  Color _paymentStatusColor(dynamic raw) {
    final upper = _paymentStatusUpper(raw);
    switch (upper) {
      case 'SUCCEEDED':
        return Colors.green;
      case 'FAILED':
      case 'REQUIRES_PAYMENT_METHOD':
        return Colors.red;
      case 'REQUIRES_ACTION':
        return Colors.deepOrange;
      case 'PENDING':
        return Colors.orange;
      default:
        return Colors.blueGrey;
    }
  }

  String _serviceStateUpper(Map<String, dynamic> service) {
    final raw = (service['estado'] ??
            service['estadoServicio'] ??
            service['status'] ??
            '')
        .toString();
    return raw.toUpperCase();
  }

  bool _isPendingState(String stateUpper) {
    return stateUpper.isEmpty || stateUpper == 'PENDIENTE';
  }

  String _serviceTitle(Map<String, dynamic> service) {
    final raw = (service['titulo'] ??
            service['nombre'] ??
            service['tituloServicio'] ??
            '')
        .toString();
    if (raw.isNotEmpty) return raw;
    return _l10n.serviceDefaultTitle;
  }

  void _showClientNotification(String message, {Color background = _primary}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: background,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _evaluateServiceExpiration(Map<String, dynamic> service) async {
    final serviceId = _serviceIdFromService(service);
    if (serviceId == null) return;
    final stateUpper = _serviceStateUpper(service);
    if (!_isPendingState(stateUpper)) return;
    final serviceDate = _serviceDateFromService(service);
    if (serviceDate == null) return;
    final today = DateTime.now();
    final todayDay = DateTime(today.year, today.month, today.day);
    final targetDay =
        DateTime(serviceDate.year, serviceDate.month, serviceDate.day);

    if (targetDay == todayDay) {
      if (!_expiryWarningIds.add(serviceId)) return;
      final title = _serviceTitle(service);
      _showClientNotification(
        _l10n.serviceExpirationWarning(title),
        background: Colors.orange,
      );
      return;
    }

    if (targetDay.isBefore(todayDay)) {
      if (_autoDeletedServiceIds.contains(serviceId)) return;
      _autoDeletedServiceIds.add(serviceId);
      final title = _serviceTitle(service);
      try {
        final result = await ApiService.deleteService(serviceId);
        if (!mounted) return;
        setState(() {
          _services.removeWhere((s) {
            final id = _serviceIdFromService(s);
            return id != null && id == serviceId;
          });
        });
        final message = (result['mensaje'] ?? result['message'])?.toString() ??
            'El servicio "$title" fue eliminado automáticamente tras superar la fecha (${_fmtDate(targetDay)}).';
        _showClientNotification(message, background: Colors.red);
      } catch (e) {
        if (!mounted) return;
        _autoDeletedServiceIds.remove(serviceId);
        _showClientNotification('No fue posible eliminar "$title": $e',
            background: Colors.red);
      }
    }
  }

  void _updateLocalServiceState(int? serviceId, String newState) {
    if (serviceId == null) return;
    setState(() {
      _services = _services.map((svc) {
        final id = _asInt(svc['id']);
        if (id != null && id == serviceId) {
          final updated = Map<String, dynamic>.from(svc);
          updated['estado'] = newState;
          updated['estadoServicio'] = newState;
          return updated;
        }
        return svc;
      }).toList();
    });
  }

  String? _serviceStateFromPayload(Map<String, dynamic> payload) {
    final direct = (payload['estadoServicio'] ?? payload['estado'] ?? payload['serviceStatus'] ?? payload['serviceState'])
        ?.toString()
        .trim();
    if (direct != null && direct.isNotEmpty) return direct.toUpperCase();
    final nested = payload['servicio'] ?? payload['service'];
    if (nested is Map) {
      final nestedRaw = (nested['estado'] ?? nested['estadoServicio'] ?? nested['status'])?.toString().trim();
      if (nestedRaw != null && nestedRaw.isNotEmpty) return nestedRaw.toUpperCase();
    }
    return null;
  }

  String _stringFromSources(List<String> keys) {
    final Map<String, dynamic> combined = {};
    if (_initialArgs != null) combined.addAll(_initialArgs!);
    if (_profile != null) combined.addAll(_profile!);
    for (final key in keys) {
      final value = combined[key];
      if (value == null) continue;
      final text = value.toString().trim();
      if (text.isNotEmpty) return text;
    }
    return '';
  }

  String _currentName() =>
      _stringFromSources(['nombreCompleto', 'nombre', 'fullName']);
  String _currentEmail() =>
      _stringFromSources(['correo', 'email', 'correoElectronico']);

  DateTime? _parseServiceDate(dynamic raw) {
    if (raw == null) return null;
    final text = raw.toString().trim();
    if (text.isEmpty) return null;
    try {
      final parsed = DateTime.parse(text);
      return parsed.isUtc ? parsed.toLocal() : parsed;
    } catch (_) {
      return null;
    }
  }

  bool _isDateExpired(DateTime? date) {
    if (date == null) return false;
    final cutoff = DateTime(date.year, date.month, date.day, 23, 59, 59);
    return DateTime.now().isAfter(cutoff);
  }

  bool _isServiceExpired(Map<String, dynamic> service) {
    final estadoRaw = (service['estado'] ??
            service['estadoServicio'] ??
            service['status'] ??
            '')
        .toString();
    if (estadoRaw.toUpperCase() == 'CANCELADO') return true;
    final date =
        _parseServiceDate(service['fechaEstimada'] ?? service['fecha']);
    return _isDateExpired(date);
  }

  Future<void> _reload() async {
    // Refresca perfil y servicios en un solo gesto
    await _refreshProfile();
    await _loadServices();
  }

  Future<void> _loadServices() async {
    setState(() {
      _loading = true;
    });
    try {
      final list = await ApiService.getServices();
      if (!mounted) return;
      final active = <Map<String, dynamic>>[];
      final expired = <Map<String, dynamic>>[];
      for (final service in list) {
        if (_isServiceExpired(service)) {
          expired.add(service);
        } else {
          active.add(service);
        }
      }
      setState(() {
        _services = active;
        _expiredServices = expired;
        _loading = false;
      });
      for (final service in _services) {
        _evaluateServiceExpiration(service);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _expiredServices = [];
      });
      _showClientNotification(
        'No fue posible cargar tus servicios: ${e.toString().replaceFirst("Exception: ", '')}',
        background: Colors.red,
      );
    }
  }

  Future<void> _refreshProfile() async {
    final id = _clientId;
    if (id == null) return;
    try {
      final data = await ApiService.fetchClientById(id);
      if (!mounted) return;
      setState(() {
        _profile = data;
      });
    } catch (e) {
      if (!mounted) return;
      _showClientNotification(
        'No pudimos actualizar tu perfil: ${e.toString().replaceFirst("Exception: ", '')}',
        background: Colors.red,
      );
    }
  }

  // Ofertas
  void _startOffersPolling() {
    _offersPollTimer?.cancel();
    _offersPollTimer = Timer(_offersPollEvery, () async {
      if (!mounted) return;
      await _fetchOffers();
      if (!mounted) return;
      _startOffersPolling();
    });
  }

  void _stopOffersPolling() {
    _offersPollTimer?.cancel();
    _offersPollTimer = null;
  }

  Future<void> _fetchOffers() async {
    final id = _clientId;
    if (id == null) return;
    setState(() {
      _offersLoading = true;
      _offersError = null;
    });
    try {
      final list = await ApiService.getClientPendingOffers(id);
      if (!mounted) return;
      setState(() {
        _offers = list;
        _offersLoading = false;
      });
      _processAcceptedOffers(list);
      _syncPendingPaymentsFromOffers(list);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _offersError = e.toString().replaceFirst('Exception: ', '');
        _offersLoading = false;
      });
    }
  }

  void _processAcceptedOffers(List<Map<String, dynamic>> offers) {
    for (final offer in offers) {
      final estadoRaw = (offer['estadoNegociacion'] ?? offer['estado'] ?? '')
          .toString()
          .toUpperCase();
      if (estadoRaw == 'ACEPTADA') {
        final serviceId = _serviceIdFromOffer(offer);
        if (serviceId != null) {
          final nextStateFromOffer = _serviceStateFromPayload(offer);
          final paymentInfo = _normalizePaymentInfo(
            offer,
            fallbackServiceId: serviceId,
            fallbackOfferId: _asInt(offer['id']),
            fallbackServiceTitle: _serviceTitleById(serviceId),
          );
          final statusUpper = _paymentStatusUpper(paymentInfo?['paymentStatus']);
          String? nextState = nextStateFromOffer;
          if (nextState == null || nextState.isEmpty) {
            if (statusUpper == 'SUCCEEDED') {
              nextState = 'ASIGNADO';
            } else if (statusUpper == 'FAILED' || statusUpper == 'REQUIRES_PAYMENT_METHOD') {
              nextState = 'PENDIENTE';
            } else {
              nextState = 'PENDIENTE_PAGO';
            }
          }
          _updateLocalServiceState(serviceId, nextState);
          if (paymentInfo != null) {
            _queuePaymentInfoUpdate(paymentInfo);
          }
        }
      }
    }
  }

  void _queuePaymentInfoUpdate(Map<String, dynamic> info) {
    final serviceId = _asInt(info['serviceId'] ?? info['servicioId']);
    if (serviceId == null) return;
    setState(() {
      final statusUpper =
          _paymentStatusUpper(info['paymentStatus'] ?? info['status']);
      if (statusUpper == 'SUCCEEDED' || statusUpper == 'NOT_REQUIRED') {
        _pendingPaymentsByService.remove(serviceId);
      } else {
        final existing = _pendingPaymentsByService[serviceId] ?? {};
        _pendingPaymentsByService[serviceId] = {
          ...existing,
          ...info,
          'serviceId': serviceId,
          'serviceTitle': info['serviceTitle'] ??
              existing['serviceTitle'] ??
              _serviceTitleById(serviceId),
        };
      }
    });
    _notificationsSetState?.call(() {});
  }

  Future<Map<String, dynamic>?> _createIntentAndQueuePendingPayment({
    required int offerId,
    int? serviceId,
    String? serviceTitle,
  }) async {
    try {
      final response = await ApiServicePayment.createIntent(
        offerId: offerId,
      );
      final intentCandidate = {
        'paymentIntentId': response.intentId,
        'clientSecret': response.clientSecret,
        'paymentStatus': response.status,
        'paymentMetadata': response.paymentMetadata,
        'offerId': offerId,
        if (serviceId != null) 'serviceId': serviceId,
        if (serviceTitle != null) 'serviceTitle': serviceTitle,
      };
      final normalized = _normalizePaymentInfo(
        intentCandidate,
        fallbackOfferId: offerId,
        fallbackServiceTitle: serviceTitle,
        fallbackServiceId: serviceId,
      );
      if (normalized != null) {
        _queuePaymentInfoUpdate(normalized);
        return normalized;
      }
      _queuePaymentInfoUpdate(intentCandidate);
      return intentCandidate;
    } on PaymentGatewayException catch (e) {
      _showPaymentError(_extractPaymentGatewayMessage(e, fallback: 'No se pudo preparar el pago.'));
    } catch (e) {
      _showPaymentError('Error preparando el pago: $e');
    }
    return null;
  }

  String _extractPaymentGatewayMessage(PaymentGatewayException error, {required String fallback}) {
    try {
      final decoded = jsonDecode(error.body);
      if (decoded is Map<String, dynamic>) {
        if (decoded['error'] is String) return decoded['error'];
        if (decoded['mensaje'] is String) return decoded['mensaje'];
        if (decoded['message'] is String) return decoded['message'];
      }
    } catch (_) {}
    return fallback;
  }

  void _showPaymentError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
      ),
    );
  }

  void _syncPendingPaymentsFromOffers(List<Map<String, dynamic>> offers) {
    final updates = <Map<String, dynamic>>[];
    for (final offer in offers) {
      final normalized = _normalizePaymentInfo(
        offer,
        fallbackOfferId: _asInt(offer['id']),
        fallbackServiceId: _serviceIdFromOffer(offer),
        fallbackServiceTitle:
            (offer['serviceTitle'] ?? offer['tituloServicio'] ?? '').toString(),
      );
      if (normalized != null) {
        updates.add(normalized);
      }
    }
    if (updates.isEmpty) return;
    setState(() {
      for (final info in updates) {
        final serviceId = _asInt(info['serviceId']);
        if (serviceId == null) continue;
        final statusUpper = _paymentStatusUpper(info['paymentStatus']);
        if (statusUpper == 'SUCCEEDED' || statusUpper == 'NOT_REQUIRED') {
          _pendingPaymentsByService.remove(serviceId);
        } else {
          final existing = _pendingPaymentsByService[serviceId] ?? {};
          _pendingPaymentsByService[serviceId] = {
            ...existing,
            ...info,
            'serviceId': serviceId,
            'serviceTitle': info['serviceTitle'] ??
                existing['serviceTitle'] ??
                _serviceTitleById(serviceId),
          };
        }
      }
    });
    _notificationsSetState?.call(() {});
  }

  Future<void> _openPaymentCheckout({
    required int offerId,
    int? serviceId,
    Map<String, dynamic>? initialInfo,
  }) async {
    final existing = initialInfo ?? _pendingPaymentForService(serviceId);
    final title =
        (existing?['serviceTitle'] ?? _serviceTitleById(serviceId) ?? '')
            .toString();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      useSafeArea: true,
      builder: (_) => PaymentCheckoutSheet(
        offerId: offerId,
        serviceId: serviceId,
        serviceTitle: title.isEmpty ? null : title,
        initialPaymentInfo: existing,
        onPaymentInfo: (info) {
          _queuePaymentInfoUpdate(info);
        },
        onPaymentFailed: (info) {
          _queuePaymentInfoUpdate(info);
        },
        onPaymentSucceeded: () async {
          await _loadServices();
        },
      ),
    );
  }

  Future<void> _openNotifications() async {
    await _fetchOffers();
    if (!mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      useSafeArea: true,
      builder: (ctx) {
        return StatefulBuilder(builder: (ctx, setM) {
          _notificationsSetState = setM;
          void removeLocal(int id) {
            setM(() => _offers.removeWhere((o) {
                  final raw = o['id'];
                  if (raw is int) return raw == id;
                  return int.tryParse(raw.toString()) == id;
                }));
          }

          Future<void> doAccept(int id, int? serviceId) async {
            try {
              final response = await ApiServicePayment.acceptOffer(offerId: id);
              final servicio = response['servicio'] as Map<String, dynamic>?;
              final serviceStatus = _paymentStatusUpper(
                servicio?['estado'] ?? servicio?['estadoServicio'],
              );
              final bool requiresPayment = serviceStatus == 'PENDIENTE_PAGO';

              removeLocal(id);
              final fallbackServiceTitle =
                  (servicio?['titulo'] ?? _serviceTitleById(serviceId))
                      ?.toString();

              if (mounted && serviceId != null) {
                _updateLocalServiceState(
                  serviceId,
                  requiresPayment ? 'PENDIENTE_PAGO' : 'ASIGNADO',
                );
              }

              await _loadServices();

              if (requiresPayment) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(_l10n.offerAcceptedMessage),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: _primary,
                    ),
                  );
                }
                final paymentInfo = await _createIntentAndQueuePendingPayment(
                  offerId: id,
                  serviceId: serviceId,
                  serviceTitle: fallbackServiceTitle,
                );
                if (paymentInfo != null) {
                  await _openPaymentCheckout(
                    offerId: id,
                    serviceId: serviceId,
                    initialInfo: paymentInfo,
                  );
                }
              } else {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(_l10n.serviceAssignedMessage),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: _primary,
                    ),
                  );
                }
              }
            } catch (e) {
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(_l10n.errorMessage(e)),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.red),
              );
            }
          }

          Future<void> doReject(int id, int? serviceId) async {
            try {
              await ApiService.clientRespondOffer(
                  offerId: id, action: 'REJECT');
              removeLocal(id);
              if (mounted && serviceId != null) {
                _updateLocalServiceState(serviceId, 'PENDIENTE');
              }
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(_l10n.offerRejectedMessage),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red),
                );
              }
            } catch (e) {
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(_l10n.errorMessage(e)),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.red),
              );
            }
          }

          Future<void> doCounter(int id) async {
            final priceCtrl = TextEditingController();
            final noteCtrl = TextEditingController();
            String? errorText;
            final payload = await showDialog<Map<String, dynamic>?>(
              context: context,
              builder: (_) => StatefulBuilder(
                builder: (dialogCtx, setDialogState) {
                  return AlertDialog(
                    title: Text(_l10n.counterofferTitle),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: priceCtrl,
                          autofocus: true,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: InputDecoration(
                            labelText: _l10n.counterofferPriceLabel,
                            prefixIcon: const Icon(Icons.attach_money),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: noteCtrl,
                          maxLines: 2,
                          decoration: InputDecoration(
                            labelText: _l10n.counterofferNoteLabel,
                            prefixIcon: const Icon(Icons.message_outlined),
                          ),
                        ),
                        if (errorText != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(errorText!,
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 12)),
                            ),
                          ),
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(dialogCtx),
                          child: Text(_l10n.cancelButton)),
                      TextButton(
                        onPressed: () {
                          final raw =
                              priceCtrl.text.trim().replaceAll(',', '.');
                          final value = double.tryParse(raw);
                          if (value == null || value <= 0) {
                            setDialogState(
                                () => errorText = _l10n.enterValidAmount);
                            return;
                          }
                          final note = noteCtrl.text.trim();
                          Navigator.pop(dialogCtx, {
                            "monto": value,
                            if (note.isNotEmpty) "mensaje": note,
                          });
                        },
                        child: Text(_l10n.sendButton),
                      ),
                    ],
                  );
                },
              ),
            );
            final monto = payload?['monto'] as double?;
            if (monto == null || monto <= 0) return;
            final mensaje = payload?['mensaje'] as String?;
            try {
              await ApiService.clientCounterOffer(
                  offerId: id, monto: monto, mensaje: mensaje);
              removeLocal(id);
               if (mounted) {
                 ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                       content: Text(_l10n.counterofferSent),
                       behavior: SnackBarBehavior.floating,
                       backgroundColor: _primary),
                 );
               }
             } catch (e) {
               if (!mounted) return;
               ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(
                     content: Text(_l10n.errorMessage(e)),
                     behavior: SnackBarBehavior.floating,
                     backgroundColor: Colors.red),
               );
             }
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(8))),
                const SizedBox(height: 12),
                Text(_l10n.notificationsTitle,
                    style:
                        const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                if (_pendingPaymentsByService.isNotEmpty) ...[
                  Text(_l10n.pendingPaymentsSection,
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  ..._pendingPaymentsByService.values
                      .map(_buildPaymentReminderCard),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 12),
                  Text(_l10n.offersInNegotiationSection,
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                ],
                if (_offersLoading && _offers.isEmpty)
                  const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()))
                else if (_offersError != null)
                  Material(
                    color: Colors.red.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                    child: ListTile(
                      leading:
                          const Icon(Icons.error_outline, color: Colors.red),
                      title: Text('$_offersError',
                          style: const TextStyle(color: Colors.red)),
                      trailing: IconButton(
                          icon: const Icon(Icons.refresh, color: Colors.red),
                          onPressed: _fetchOffers),
                    ),
                  )
                else if (_offers.isEmpty)
                  Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(_l10n.noNewOffers,
                          style: const TextStyle(color: Colors.black54)))
                else
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: _offers.length,
                      separatorBuilder: (_, __) => const Divider(height: 16),
                      itemBuilder: (context, i) {
                        final o = _offers[i];
                        final workerName =
                            (o['workerName'] ?? o['trabajador'] ?? 'Trabajador')
                                .toString();
                        final workerLabel =
                            workerName.isEmpty ? 'Trabajador' : workerName;
                        final estadoRaw =
                            (o['estadoNegociacion'] ?? o['estado'] ?? '')
                                .toString();
                        final estado = _negotiationStateLabel(estadoRaw);
                        final turnoRaw = o['requiereRespuestaDe'] ??
                            o['turno'] ??
                            o['pendingFor'];
                        final turno = _participantLabel(turnoRaw);
                        final ultimo = _participantLabel(
                            o['ultimoEmisor'] ?? o['lastActor']);
                        final serviceTitle =
                            (o['serviceTitle'] ?? o['tituloServicio'] ?? '')
                                .toString();
                        final montoActual = _asDouble(o['monto'] ??
                            o['precio'] ??
                            o['montoActual'] ??
                            o['montoFinal']);
                        final montoTrab = _asDouble(o['montoTrabajador'] ??
                            o['precioTrabajador'] ??
                            o['precio']);
                        final montoCliente =
                            _asDouble(o['montoCliente'] ?? o['precioCliente']);
                        final offerId = () {
                          final v = o['id'];
                          if (v is int) return v;
                          return int.tryParse(v.toString()) ?? 0;
                        }();
                        final serviceId = _serviceIdFromOffer(o);
                        final subtitleLines = <String>[
                          if (serviceTitle.isNotEmpty)
                            _l10n.serviceLabel(serviceTitle),
                          if (estado.isNotEmpty) _l10n.serviceStateLabel(estado),
                          if (turno.isNotEmpty) _l10n.serviceTurnLabel(turno),
                          if (ultimo.isNotEmpty) _l10n.lastOfferLabel(ultimo),
                          if (montoActual != null)
                            _l10n.currentAmountLabel(_formatCurrency(montoActual)),
                          if (montoTrab != null)
                            _l10n.workerProposalLabel(_formatCurrency(montoTrab)),
                          if (montoCliente != null)
                            _l10n.clientOfferLabel(_formatCurrency(montoCliente)),
                        ];
                        final paymentInfo = _normalizePaymentInfo(
                          o,
                          fallbackOfferId: offerId,
                          fallbackServiceId: serviceId,
                          fallbackServiceTitle: serviceTitle,
                        );
                        final paymentStatusUpper = _paymentStatusUpper(
                          paymentInfo?['paymentStatus'] ??
                              o['paymentStatus'] ??
                              o['estadoPago'],
                        );
                        if (paymentStatusUpper.isNotEmpty &&
                            paymentStatusUpper != 'NOT_REQUIRED') {
                          subtitleLines.add(_l10n.paymentStatusLabel(
                              _paymentStatusLabel(paymentStatusUpper)));
                        }
                        final subtitleWidget = subtitleLines.isEmpty
                            ? null
                            : Text(subtitleLines.join('\n'));
                        final estadoNormalized = estadoRaw.toUpperCase();
                        final canRespond = offerId > 0 &&
                            (estadoNormalized.isEmpty ||
                                estadoNormalized == 'EN_NEGOCIACION') &&
                            _isClientTurn(turnoRaw);
                        final waitingPayment = estadoNormalized == 'ACEPTADA' &&
                            paymentStatusUpper.isNotEmpty &&
                            paymentStatusUpper != 'SUCCEEDED' &&
                            paymentStatusUpper != 'NOT_REQUIRED';
                        final trailing = waitingPayment
                            ? FilledButton.tonalIcon(
                                icon: Icon((paymentStatusUpper == 'FAILED' ||
                                        paymentStatusUpper ==
                                            'REQUIRES_PAYMENT_METHOD')
                                    ? Icons.refresh
                                    : Icons.lock_open),
                                label: Text(
                                    (paymentStatusUpper == 'FAILED' ||
                                            paymentStatusUpper ==
                                                'REQUIRES_PAYMENT_METHOD')
                                        ? 'Reintentar pago'
                                        : 'Ir al checkout'),
                                onPressed: () => _openPaymentCheckout(
                                  offerId: offerId,
                                  serviceId: serviceId,
                                  initialInfo: paymentInfo,
                                ),
                              )
                            : Wrap(
                                spacing: 8,
                                children: [
                                  IconButton(
                                      tooltip: _l10n.acceptTooltip,
                                      icon: const Icon(Icons.check_circle,
                                          color: Colors.green),
                                      onPressed: canRespond
                                          ? () => doAccept(offerId, serviceId)
                                          : null),
                                  IconButton(
                                      tooltip: _l10n.rejectTooltip,
                                      icon: const Icon(Icons.cancel,
                                          color: Colors.red),
                                      onPressed: canRespond
                                          ? () => doReject(offerId, serviceId)
                                          : null),
                                  IconButton(
                                      tooltip: _l10n.counterofferTooltip,
                                      icon: const Icon(Icons.swap_horiz,
                                          color: Colors.orange),
                                      onPressed: canRespond
                                          ? () => doCounter(offerId)
                                          : null),
                                ],
                              );
                        return ListTile(
                          leading: const CircleAvatar(
                              child: Icon(Icons.campaign_outlined)),
                          title: Text(_l10n.workerOfferLabel(workerLabel)),
                          subtitle: subtitleWidget,
                          trailing: trailing,
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        });
      },
    );
    _notificationsSetState = null;
  }

  Future<void> _openEditForm(
      int serviceId, Map<String, dynamic> initial) async {
    final updated = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      useSafeArea: true,
      builder: (_) => _EditServiceForm(
        serviceId: serviceId,
        categorias: _categorias,
        initial: initial,
      ),
    );
    if (updated != null) {
      await _loadServices();
      if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(_l10n.serviceUpdatedMessage),
              behavior: SnackBarBehavior.floating,
              backgroundColor: _primary),
        );
    }
  }

  Future<void> _confirmDelete(int serviceId) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(_l10n.deleteServiceTitle),
        content: Text(_l10n.deleteServiceConfirmation),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(_l10n.cancelButton)),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(_l10n.deleteButton,
                  style: const TextStyle(color: Colors.red))),
        ],
      ),
    );
    if (ok != true) return;
    try {
      final result = await ApiService.deleteService(serviceId);
      final bool success = result['exitoso'] == true;
      final String message = (result['mensaje'] ??
              (success
                  ? _l10n.serviceDeletedMessage
                  : _l10n.serviceDeleteBlockedMessage))
          .toString();
      if (success) {
        await _loadServices();
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: success ? Colors.black87 : Colors.orange,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Error: $e'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _openAccountManager() async {
    final id = _clientId;
    if (id == null) return;
    final updated = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      useSafeArea: true,
      builder: (_) => AccountManagementSheet(
          userId: id, role: 'client', initialData: _profile),
    );
    if (updated != null && mounted) {
      setState(() => _profile = updated);
      await _refreshProfile();
    }
  }

  Future<void> _openPublishForm() async {
    final created = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      useSafeArea: true,
      builder: (_) => _PublishServiceForm(categorias: _categorias),
    );
    if (created != null) {
      await _loadServices();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(_l10n.servicePublishedMessage),
          behavior: SnackBarBehavior.floating,
          backgroundColor: _primary));
    }
  }

  Future<void> _logout() async {
    ApiService.clearToken();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
  }

  Future<void> _showProfileMenu() async {
    final l10n = AppLocalizations.of(context)!;
    final email = _currentEmail();
    final name = _currentName();
    final result = await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (_) => ProfilePopover(
          name: name,
          email: email.isNotEmpty ? email : l10n.myAccount,
          initialLetter: name.isNotEmpty ? name[0].toUpperCase() : '?',
          accentColor: _primary,
          manageLabel: l10n.manageAccountLabel,
          logoutLabel: l10n.logoutLabel),
    );
    if (result == 'manage') {
      await _openAccountManager();
    } else if (result == 'logout') {
      await _logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.add_circle_outline, color: _primary),
          tooltip: _l10n.publishServiceTooltip,
          onPressed: _openPublishForm,
        ),
        title: Text(_l10n.appTitle,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w800)),
        actions: [
          IconButton(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.notifications_outlined, color: Colors.black87),
                if (_offers.isNotEmpty)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(_offers.length.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10)),
                    ),
                  ),
              ],
            ),
            tooltip: _l10n.notificationsTooltip,
            onPressed: _openNotifications,
          ),
          IconButton(
            icon: const Icon(Icons.refresh_outlined, color: Colors.black87),
            tooltip: _l10n.refreshTooltip,
            onPressed: _reload,
          ),
          Padding(
              padding: const EdgeInsets.only(right: 14),
              child: GestureDetector(
                  onTap: _showProfileMenu,
                  child: CircleAvatar(
                      backgroundColor: _primary,
                      child: Text(
                          (_currentName().isNotEmpty ? _currentName()[0] : '?')
                              .toUpperCase(),
                          style: const TextStyle(color: Colors.white))))),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadServices,
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (_expiredServices.isNotEmpty)
                    _buildExpiredServicesBanner(),
                  ...List.generate(_services.length, (i) {
                    final s = _services[i];
                    final titulo = (s['titulo'] ?? '').toString();
                    final categoria =
                        categoryDisplayLabel((s['categoria'] ?? '').toString());
                    final ubicacion = (s['ubicacion'] ?? '').toString();
                    final estadoRaw = (s['estado'] ??
                            s['estadoServicio'] ??
                            s['status'] ??
                            'PENDIENTE')
                        .toString();
                    final estadoUpper = estadoRaw.toUpperCase();
                    final estadoLabel = _serviceStateLabel(estadoRaw);
                    final fechaRaw = s['fechaEstimada'] ?? s['fecha'];
                    final fecha = _parseServiceDate(fechaRaw);
                    final fechaTxt = fecha != null
                        ? '${fecha.day.toString().padLeft(2, '0')}/${fecha.month.toString().padLeft(2, '0')}/${fecha.year}'
                        : '';
                    final int? serviceId = () {
                      final v = s['id'];
                      if (v == null) return null;
                      if (v is int) return v;
                      return int.tryParse(v.toString());
                    }();
                    final editableServiceId = serviceId;
                    final pendingPayment = _pendingPaymentForService(serviceId);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Card(
                        color: const Color(0xFFF6F1FF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(16, 12, 16, 12),
                              leading: CircleAvatar(
                                backgroundColor:
                                    const Color(0xFF7E57C2).withOpacity(0.12),
                                child: const Icon(Icons.work_outline,
                                    color: Color(0xFF7E57C2)),
                              ),
                              title: Text(
                                titulo.isEmpty ? 'Servicio' : titulo,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700),
                              ),
                              subtitle: () {
                                final parts = <String>[
                                  if (ubicacion.isNotEmpty) ubicacion,
                                  if (categoria.isNotEmpty) categoria,
                                  if (fechaTxt.isNotEmpty) 'Fecha: $fechaTxt',
                                  if (estadoLabel.isNotEmpty)
                                    'Estado: $estadoLabel',
                                ];
                                if (parts.isEmpty) return null;
                                return Text(parts.join(' - '));
                              }(),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  () {
                                    Color statusColor = Colors.orange;
                                    switch (estadoUpper) {
                                      case 'ASIGNADO':
                                      case 'EN_PROCESO':
                                      case 'EN_CURSO':
                                        statusColor = Colors.blue;
                                        break;
                                      case 'FINALIZADO':
                                        statusColor = Colors.green;
                                        break;
                                      case 'CANCELADO':
                                        statusColor = Colors.red;
                                        break;
                                      case 'PENDIENTE_PAGO':
                                        statusColor = Colors.amber.shade800;
                                        break;
                                      default:
                                        statusColor = Colors.orange;
                                        break;
                                    }
                                    return Chip(
                                      label: Text(estadoLabel),
                                      backgroundColor:
                                          statusColor.withOpacity(0.1),
                                      labelStyle: TextStyle(
                                          color: statusColor,
                                          fontWeight: FontWeight.w600),
                                    );
                                  }(),
                                  if (estadoUpper == 'PENDIENTE' &&
                                      editableServiceId != null) ...[
                                    const SizedBox(width: 6),
                                    PopupMenuButton<String>(
                                      tooltip: 'Opciones',
                                      onSelected: (value) {
                                        if (value == 'edit') {
                                          _openEditForm(editableServiceId, s);
                                        } else if (value == 'delete') {
                                          _confirmDelete(editableServiceId);
                                        }
                                      },
                                      itemBuilder: (context) => [
                                        const PopupMenuItem(
                                          value: 'edit',
                                          child: ListTile(
                                            leading: Icon(Icons.edit_outlined),
                                            title: Text('Editar'),
                                          ),
                                        ),
                                        const PopupMenuItem(
                                          value: 'delete',
                                          child: ListTile(
                                            leading: Icon(Icons.delete_outline,
                                                color: Colors.red),
                                            title: Text('Eliminar'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            if (estadoUpper == 'PENDIENTE_PAGO') ...[
                              if (pendingPayment != null)
                                _buildServicePaymentBanner(serviceId, pendingPayment)
                              else
                                _buildWaitingPaymentBanner(serviceId, titulo),
                            ],
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 8),
                  Text(_l10n.viewMapLabel,
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  const CurrentLocationMap(height: 260),
                ],
              ),
      ),
    );
  }

  Widget _buildExpiredServicesBanner() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.hourglass_bottom, color: Colors.orange),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _expiredServices.length == 1
                  ? _l10n.expiredServiceSingle
                  : _l10n.expiredServiceMultiple(_expiredServices.length),
              style: const TextStyle(
                  color: Colors.orange, fontWeight: FontWeight.w600),
            ),
          ),
          TextButton(
            onPressed: _showExpiredServicesSheet,
            child: Text(_l10n.viewButton),
          ),
        ],
      ),
    );
  }

  Widget _buildWaitingPaymentBanner(int? serviceId, String? serviceTitle) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_l10n.paymentPendingTitle,
              style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(_l10n.awaitingClientPayment,
              style: const TextStyle(fontSize: 13)),
          if (serviceTitle != null && serviceTitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(_l10n.serviceLabel(serviceTitle), style: const TextStyle(fontSize: 13)),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
              child: FilledButton.icon(
                icon: const Icon(Icons.payment),
                label: Text(_l10n.proceedToPayment),
              onPressed: () async {
                await _startPaymentFlow(serviceId, serviceTitle: serviceTitle);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
              child: TextButton.icon(
                icon: const Icon(Icons.refresh),
                label: Text(_l10n.updateStatus),
              onPressed: () async {
                await _loadServices();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentReminderCard(Map<String, dynamic> info) {
    final serviceId = _asInt(info['serviceId']);
    final offerId = _asInt(info['offerId']);
    final normalized = _normalizePaymentInfo(
      info,
      fallbackServiceId: serviceId,
      fallbackOfferId: offerId,
      fallbackServiceTitle: (info['serviceTitle'] ?? _serviceTitleById(serviceId) ?? 'Servicio').toString(),
    );
    final serviceTitle =
        (info['serviceTitle'] ?? _serviceTitleById(serviceId) ?? 'Servicio')
            .toString();
    final statusUpper = _paymentStatusUpper(info['paymentStatus']);
    final label = _paymentStatusLabel(statusUpper);
    final amount = _asDouble(info['amount']);
    final isFailed =
        statusUpper == 'FAILED' || statusUpper == 'REQUIRES_PAYMENT_METHOD';
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isFailed
            ? Colors.red.withOpacity(0.05)
            : Colors.orange.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: isFailed ? Colors.red.shade200 : Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(serviceTitle,
              style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text('Estado: $label',
              style: TextStyle(
                  color: _paymentStatusColor(statusUpper),
                  fontWeight: FontWeight.w600)),
          if (amount != null) Text('Monto: ${_formatCurrency(amount)}'),
          const SizedBox(height: 6),
          Text(
            isFailed
                ? 'El pago anterior fue rechazado. Puedes generar un nuevo intento desde el checkout.'
                : 'Debes completar el pago para que el trabajador comience.',
            style: const TextStyle(fontSize: 13),
          ),
          if (offerId != null && offerId > 0) ...[
            const SizedBox(height: 10),
            FilledButton.tonalIcon(
              icon: Icon(isFailed ? Icons.refresh : Icons.lock_open),
              label: Text(isFailed ? 'Reintentar pago' : 'Ir al checkout'),
              onPressed: () => _openPaymentCheckout(
                offerId: offerId,
                serviceId: serviceId,
                initialInfo: info,
              ),
            ),
                    TextButton.icon(
                      icon: const Icon(Icons.sync),
                      label: Text(_l10n.updateStatus),
                      onPressed: () async {
                  if (offerId == null || normalized == null) return;
                  try {
                    await _refreshPaymentStatus(
                      current: normalized,
                      fallbackOfferId: offerId,
                      fallbackServiceId: serviceId,
                      fallbackServiceTitle: _serviceTitleById(serviceId),
                    );
                  } catch (e) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('No se pudo actualizar: $e'),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red),
                    );
                  }
                },
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildServicePaymentBanner(
      int? serviceId, Map<String, dynamic>? info) {
    final normalized = info == null
        ? null
        : _normalizePaymentInfo(
            info,
            fallbackServiceId: serviceId,
            fallbackServiceTitle: _serviceTitleById(serviceId),
          );
    final statusUpper = _paymentStatusUpper(normalized?['paymentStatus']);
    final label = _paymentStatusLabel(statusUpper);
    final amount = _asDouble(normalized?['amount']);
    final offerId = _asInt(normalized?['offerId']);
    final isFailed =
        statusUpper == 'FAILED' || statusUpper == 'REQUIRES_PAYMENT_METHOD';
    final color = isFailed
        ? Colors.red.withOpacity(0.05)
        : Colors.orange.withOpacity(0.08);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: isFailed ? Colors.red.shade200 : Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_l10n.paymentPendingTitle,
              style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text('Estado actual: $label',
              style: TextStyle(
                  color: _paymentStatusColor(statusUpper),
                  fontWeight: FontWeight.w600)),
          if (amount != null)
            Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text('Monto: ${_formatCurrency(amount)}')),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              isFailed ? _l10n.paymentRetryInfo : _l10n.paymentContinueInfo,
              style: const TextStyle(fontSize: 13),
            ),
          ),
          if (offerId != null && offerId > 0)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Wrap(
                spacing: 12,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  FilledButton.icon(
                    icon: Icon(isFailed ? Icons.refresh : Icons.lock_open),
                    label:
                        Text(isFailed ? 'Reintentar pago' : 'Ir al checkout'),
                    onPressed: () => _openPaymentCheckout(
                      offerId: offerId,
                      serviceId: serviceId,
                      initialInfo: normalized,
                    ),
                  ),
              TextButton.icon(
                icon: const Icon(Icons.sync),
                label: Text(_l10n.updateStatus),
                    onPressed: () async {
                      if (offerId == null || offerId <= 0 || normalized == null) return;
                      try {
                        await _refreshPaymentStatus(
                          current: normalized,
                          fallbackOfferId: offerId,
                          fallbackServiceId: serviceId,
                          fallbackServiceTitle: _serviceTitleById(serviceId),
                        );
                      } catch (e) {
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('No se pudo actualizar: $e'),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          if (offerId == null || offerId <= 0)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                _l10n.paymentSyncInfo,
                style: const TextStyle(fontSize: 13),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _showExpiredServicesSheet() async {
    if (_expiredServices.isEmpty) return;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      useSafeArea: true,
      builder: (ctx) {
        final height = MediaQuery.of(ctx).size.height * 0.6;
        return SizedBox(
          height: height,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _l10n.expiredServicesTitle,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                if (_expiredServices.isEmpty)
                  Center(child: Text(_l10n.noExpiredServices)),
                if (_expiredServices.isNotEmpty)
                  Expanded(
                    child: ListView.separated(
                      itemCount: _expiredServices.length,
                      separatorBuilder: (_, __) => const Divider(height: 16),
                      itemBuilder: (context, index) {
                        final svc = _expiredServices[index];
                        final titulo = (svc['titulo'] ?? _l10n.serviceDefaultTitle)
                            .toString();
                        final fecha = _parseServiceDate(
                            svc['fechaEstimada'] ?? svc['fecha']);
                        final fechaTxt = fecha != null
                            ? '${fecha.day.toString().padLeft(2, '0')}/${fecha.month.toString().padLeft(2, '0')}/${fecha.year}'
                            : '';
                        final ubicacion = (svc['ubicacion'] ?? '').toString();
                        final categoria = categoryDisplayLabel(
                            (svc['categoria'] ?? '').toString());
                        final dateLabel = fechaTxt.isNotEmpty
                            ? _l10n.expiredServiceDateLabel(fechaTxt)
                            : _l10n.dateUnavailable;
                        return ListTile(
                          leading: const Icon(Icons.warning_amber_outlined,
                              color: Colors.orange),
                          title: Text(titulo,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700)),
                          subtitle: Text(
                            [
                              dateLabel,
                              if (ubicacion.isNotEmpty) ubicacion,
                              if (categoria.isNotEmpty) categoria,
                            ].join(' • '),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PublishServiceForm extends StatefulWidget {
  final List<String> categorias;
  const _PublishServiceForm({required this.categorias});
  @override
  State<_PublishServiceForm> createState() => _PublishServiceFormState();
}

class _PublishServiceFormState extends State<_PublishServiceForm> {
  final _formKey = GlobalKey<FormState>();
  final _tituloCtrl = TextEditingController();
  final _descripcionCtrl = TextEditingController();
  final _ubicacionCtrl = TextEditingController();
  String? _categoria;
  DateTime? _fecha;
  bool _sending = false;

  @override
  void dispose() {
    _tituloCtrl.dispose();
    _descripcionCtrl.dispose();
    _ubicacionCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _fecha ?? now.add(const Duration(days: 1)),
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year + 2),
      helpText: AppLocalizations.of(context)!.datePickerHelp,
      locale: const Locale('es', 'CO'),
    );
    if (picked != null) {
      setState(() => _fecha = DateTime(picked.year, picked.month, picked.day));
    }
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    if (_sending) return;
    if (!_formKey.currentState!.validate()) return;
    final today = DateTime.now();
    final todayAt0 = DateTime(today.year, today.month, today.day);
    if (_fecha == null || _fecha!.isBefore(todayAt0)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(l10n.dateInPastError),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red));
      return;
    }

    final categoriaValue = normalizeCategoryValue(_categoria);
    if (categoriaValue.isEmpty || !widget.categorias.contains(categoriaValue)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(l10n.invalidCategoryError),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red));
      return;
    }

    setState(() => _sending = true);
    try {
      final resp = await ApiService.createService(
        titulo: _tituloCtrl.text.trim(),
        descripcion: _descripcionCtrl.text.trim(),
        categoria: categoriaValue,
        ubicacion: _ubicacionCtrl.text.trim(),
        fechaEstimada: _fecha!,
      );
      if (!mounted) return;
      Navigator.pop(context, resp);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(l10n.errorMessage(e)),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red));
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(8))),
              const SizedBox(height: 12),
              Text(l10n.serviceFormPublishTitle,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tituloCtrl,
                decoration: InputDecoration(
                    labelText: l10n.serviceTitleLabel,
                    prefixIcon: const Icon(Icons.title)),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? l10n.titleRequiredError
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descripcionCtrl,
                minLines: 3,
                maxLines: 6,
                decoration: InputDecoration(
                    labelText: l10n.serviceDescriptionLabel,
                    prefixIcon: const Icon(Icons.description_outlined)),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? l10n.descriptionRequiredError
                    : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    labelText: l10n.serviceCategoryLabel,
                    prefixIcon: const Icon(Icons.category_outlined)),
                value: _categoria,
                items: widget.categorias
                    .map((c) => DropdownMenuItem(
                        value: c, child: Text(categoryDisplayLabel(c))))
                    .toList(),
                onChanged: (v) => setState(() => _categoria = v),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? l10n.categoryRequiredError
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _ubicacionCtrl,
                decoration: InputDecoration(
                    labelText: l10n.serviceLocationLabel,
                    prefixIcon: const Icon(Icons.location_on_outlined)),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? l10n.locationRequiredError
                    : null,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: _pickDate,
                child: InputDecorator(
                  decoration: InputDecoration(
                      labelText: l10n.serviceEstimatedDateLabel,
                      prefixIcon: const Icon(Icons.event_outlined),
                      border: const OutlineInputBorder()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_fecha == null
                          ? l10n.selectDatePrompt
                          : _fmtDate(_fecha!)),
                      const Icon(Icons.calendar_today, size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                      child: OutlinedButton(
                          onPressed:
                              _sending ? null : () => Navigator.pop(context),
                          child: Text(l10n.cancelButton))),
                  const SizedBox(width: 12),
                  Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: _primary,
                              foregroundColor: Colors.white),
                          onPressed: _sending ? null : _submit,
                          child: _sending
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2, color: Colors.white))
                              : Text(l10n.saveButton))),
                ],
              ),
              const SizedBox(height: 4),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(l10n.requiredFieldsNote,
                      style: const TextStyle(fontSize: 12, color: Colors.black54))),
            ],
          ),
        ),
      ),
    );
  }
}

String _fmtDate(DateTime d) {
  return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}

class _EditServiceForm extends StatefulWidget {
  final int serviceId;
  final List<String> categorias;
  final Map<String, dynamic> initial;
  const _EditServiceForm(
      {required this.serviceId,
      required this.categorias,
      required this.initial});
  @override
  State<_EditServiceForm> createState() => _EditServiceFormState();
}

class _EditServiceFormState extends State<_EditServiceForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _tituloCtrl;
  late final TextEditingController _descripcionCtrl;
  late final TextEditingController _ubicacionCtrl;
  String? _categoria;
  DateTime? _fecha;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final init = widget.initial;
    _tituloCtrl =
        TextEditingController(text: (init['titulo'] ?? '').toString());
    _descripcionCtrl =
        TextEditingController(text: (init['descripcion'] ?? '').toString());
    _ubicacionCtrl =
        TextEditingController(text: (init['ubicacion'] ?? '').toString());
    final rawCat = normalizeCategoryValue((init['categoria'] ?? '').toString());
    _categoria = widget.categorias.contains(rawCat) ? rawCat : null;
    final fechaRaw = (init['fechaEstimada'] ?? init['fecha'] ?? '').toString();
    try {
      _fecha = DateTime.tryParse(fechaRaw);
    } catch (_) {}
  }

  @override
  void dispose() {
    _tituloCtrl.dispose();
    _descripcionCtrl.dispose();
    _ubicacionCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _fecha ?? now.add(const Duration(days: 1)),
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year + 2),
      helpText: AppLocalizations.of(context)!.datePickerHelp,
      locale: const Locale('es', 'CO'),
    );
    if (picked != null) {
      setState(() => _fecha = DateTime(picked.year, picked.month, picked.day));
    }
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    if (_saving) return;
    if (!_formKey.currentState!.validate()) return;
    final today = DateTime.now();
    final todayAt0 = DateTime(today.year, today.month, today.day);
    if (_fecha == null || _fecha!.isBefore(todayAt0)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(l10n.dateInPastError),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red));
      return;
    }

    final categoriaValue = normalizeCategoryValue(_categoria);
    if (categoriaValue.isEmpty || !widget.categorias.contains(categoriaValue)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(l10n.invalidCategoryError),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red));
      return;
    }

    setState(() => _saving = true);
    try {
      final resp = await ApiService.updateService(
        id: widget.serviceId,
        titulo: _tituloCtrl.text.trim(),
        descripcion: _descripcionCtrl.text.trim(),
        categoria: categoriaValue,
        ubicacion: _ubicacionCtrl.text.trim(),
        fechaEstimada: _fecha!,
      );
      if (!mounted) return;
      Navigator.pop(context, resp);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(l10n.errorMessage(e)),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(8))),
              const SizedBox(height: 12),
              Text(l10n.serviceFormEditTitle,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tituloCtrl,
                decoration: InputDecoration(
                    labelText: l10n.serviceTitleLabel,
                    prefixIcon: const Icon(Icons.title)),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? l10n.titleRequiredError
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descripcionCtrl,
                minLines: 3,
                maxLines: 6,
                decoration: InputDecoration(
                    labelText: l10n.serviceDescriptionLabel,
                    prefixIcon: const Icon(Icons.description_outlined)),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? l10n.descriptionRequiredError
                    : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    labelText: l10n.serviceCategoryLabel,
                    prefixIcon: const Icon(Icons.category_outlined)),
                value: _categoria,
                items: widget.categorias
                    .map((c) => DropdownMenuItem(
                        value: c, child: Text(categoryDisplayLabel(c))))
                    .toList(),
                onChanged: (v) => setState(() => _categoria = v),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? l10n.categoryRequiredError
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _ubicacionCtrl,
                decoration: InputDecoration(
                    labelText: l10n.serviceLocationLabel,
                    prefixIcon: const Icon(Icons.location_on_outlined)),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? l10n.locationRequiredError
                    : null,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: _pickDate,
                child: InputDecorator(
                  decoration: InputDecoration(
                      labelText: l10n.serviceEstimatedDateLabel,
                      prefixIcon: const Icon(Icons.event_outlined),
                      border: const OutlineInputBorder()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_fecha == null
                          ? l10n.selectDatePrompt
                          : _fmtDate(_fecha!)),
                      const Icon(Icons.calendar_today, size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                  child: OutlinedButton(
                      onPressed:
                          _saving ? null : () => Navigator.pop(context),
                      child: Text(l10n.cancelButton))),
                  const SizedBox(width: 12),
                  Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: _primary,
                              foregroundColor: Colors.white),
                          onPressed: _saving ? null : _submit,
                      child: _saving
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white))
                          : Text(l10n.saveButton))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
