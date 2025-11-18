class PaymentIntentResponse {
  final String intentId;
  final String clientSecret;
  final String status;
  final String? paymentMetadata;

  PaymentIntentResponse({
    required this.intentId,
    required this.clientSecret,
    required this.status,
    this.paymentMetadata,
  });

  factory PaymentIntentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentIntentResponse(
      intentId: json['payment_intent_id']?.toString() ??
          json['paymentIntentId']?.toString() ??
          json['intentId']?.toString() ??
          json['id']?.toString() ??
          '',
      clientSecret: json['client_secret']?.toString() ??
          json['clientSecret']?.toString() ??
          '',
      status: json['payment_status']?.toString() ??
          json['paymentStatus']?.toString() ??
          json['status']?.toString() ??
          '',
      paymentMetadata: json['payment_metadata']?.toString() ??
          json['paymentMetadata']?.toString(),
    );
  }
}
