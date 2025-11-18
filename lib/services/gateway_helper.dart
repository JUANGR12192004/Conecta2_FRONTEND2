import 'dart:convert';

import 'package:http/http.dart' as http;

import 'payment_intent_response.dart';

const _gatewayBaseUrl = 'http://10.0.2.2:8090';
const Map<String, String> _gatewayHeaders = {
  'Content-Type': 'application/json',
  'X-API-KEY': 'conecta2-test-key',
};

Future<PaymentIntentResponse?> debugCreateIntent({
  required String externalRef,
  required double amount,
  required String currency,
  String? description,
  Map<String, Object?>? metadata,
}) async {
  final uri = Uri.parse('$_gatewayBaseUrl/payments/intents');
  final body = jsonEncode({
    'externalRef': externalRef,
    'amount': amount,
    'currency': currency,
    'description': description,
    'metadata': metadata,
  });
  final response = await http.post(uri, headers: _gatewayHeaders, body: body);

  if (response.statusCode == 201) {
    return PaymentIntentResponse.fromJson(jsonDecode(response.body));
  }

  throw GatewayException(
    statusCode: response.statusCode,
    body: response.body,
  );
}

class GatewayException implements Exception {
  final int statusCode;
  final String body;

  GatewayException({required this.statusCode, required this.body});

  @override
  String toString() =>
      'GatewayException(statusCode: $statusCode, body: $body)';
}
