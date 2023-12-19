part of 'domain.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  PaymentRepositoryImpl({required super.paymentApi});

  @override
  Future<void> markPaymentCompleted({required String ticketId}) {
    return paymentApi.markPaymentCompleted(ticketId: ticketId);
  }
}
