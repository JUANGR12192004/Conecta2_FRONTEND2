import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_applicatiomconecta2/services/gateway_helper.dart';
import 'package:flutter_applicatiomconecta2/services/payment_intent_response.dart';

void main() {
  test('PaymentIntentResponse.fromJson extracts intent and status', () {
    final json = {
      'payment_intent_id': 'pi_ABC',
      'payment_status': 'REQUIRES_ACTION',
      'client_secret': 'secret_key',
      'payment_metadata': 'meta',
    };
    final resp = PaymentIntentResponse.fromJson(json);
    expect(resp.intentId, 'pi_ABC');
    expect(resp.status, 'REQUIRES_ACTION');
  });

  test('GatewayException exposes metadata in toString', () {
    final error = GatewayException(statusCode: 401, body: '{"message":"invalid"}');
    final str = error.toString();
    expect(str, contains('statusCode: 401'));
    expect(str, contains('invalid'));
  });
}
