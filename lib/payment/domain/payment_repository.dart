part of 'domain.dart';

abstract class PaymentRepository {
  const PaymentRepository({required this.paymentApi});

  final PaymentApi paymentApi;

  Future<void> markPaymentCompleted({required String ticketId});
}
