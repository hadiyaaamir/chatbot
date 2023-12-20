part of 'api.dart';

abstract class PaymentApi {
  Future<void> markPaymentCompleted({required String ticketId});
}
