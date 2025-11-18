import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:http/http.dart' as http;

import 'api_service.dart';
import 'payment_intent_response.dart';

class ApiServicePayment {
  static String get _baseHost {
    if (kIsWeb) return "http://localhost:8080";
    if (defaultTargetPlatform == TargetPlatform.android) {
      return "http://10.0.2.2:8080";
    }
    return "http://localhost:8080";
  }

  static Uri _payments(String path, {Map<String, String>? query}) {
    return Uri.parse("$_baseHost$path").replace(queryParameters: query);
  }

  static Map<String, String> get headers => ApiService.clientAuthHeaders();

  static Future<Map<String, dynamic>> acceptOffer({
    required int offerId,
  }) async {
    final response = await http
        .put(
          _payments("/offers/$offerId/accept"),
          headers: headers,
        )
        .timeout(const Duration(seconds: 15));
    return _processResponse(response, "aceptar oferta", headers);
  }

  static Future<PaymentIntentResponse> createIntent({
    required int offerId,
    Map<String, dynamic>? overrides,
  }) async {
    final body = <String, dynamic>{
      "offerId": offerId,
      if (overrides != null) ...overrides,
    };
    final response = await http
        .post(
          _payments("/payment/intents"),
          headers: headers,
          body: jsonEncode(body),
        )
        .timeout(const Duration(seconds: 15));
    final decoded = _processResponse(response, "crear intent", headers);
    return PaymentIntentResponse.fromJson(decoded);
  }

  static Future<Map<String, dynamic>> confirmPayment({
    required String paymentIntentId,
    required String paymentMethod,
  }) async {
    final payload = {
      "paymentIntentId": paymentIntentId,
      "paymentMethod": paymentMethod,
    };
    final response = await http
        .post(
          _payments("/payment/confirm"),
          headers: headers,
          body: jsonEncode(payload),
        )
        .timeout(const Duration(seconds: 15));
    return _processResponse(response, "confirmar intent", headers);
  }

  static Future<Map<String, dynamic>> getPaymentStatus({
    required String paymentIntentId,
  }) async {
    final response = await http
        .get(
          _payments("/payment/status/$paymentIntentId"),
          headers: headers,
        )
        .timeout(const Duration(seconds: 15));
    return _processResponse(response, "consultar estado", headers);
  }

  static Map<String, dynamic> _processResponse(
    http.Response res,
    String action,
    Map<String, String> requestHeaders,
  ) {
    if (res.statusCode == 200 || res.statusCode == 201) {
      final decoded = res.body.isNotEmpty ? jsonDecode(res.body) : null;
      if (decoded is Map<String, dynamic>) return decoded;
      return {"raw": res.body};
    }
    final url = res.request?.url;
    throw PaymentGatewayException(
      statusCode: res.statusCode,
      body: res.body,
      action: action,
      requestUrl: url,
      requestHeaders: requestHeaders,
    );
  }
}

class PaymentGatewayException implements Exception {
  final int statusCode;
  final String body;
  final String action;
  final Uri? requestUrl;
  final Map<String, String> requestHeaders;

  PaymentGatewayException({
    required this.statusCode,
    required this.body,
    required this.action,
    required this.requestUrl,
    required this.requestHeaders,
  });

  bool get isUnauthorized => statusCode == 401;

  @override
  String toString() {
    final headersDesc = requestHeaders.entries.map((e) => '${e.key}=${e.value}').join(', ');
    final base = 'Gateway $action failed ($statusCode): $body';
    final urlPart = requestUrl != null ? ' URL=$requestUrl' : '';
    return '$base$urlPart Headers=[$headersDesc]';
  }
}
