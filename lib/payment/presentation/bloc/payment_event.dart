part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class PaymentAttemptCompletionEvent extends PaymentEvent {
  const PaymentAttemptCompletionEvent({required this.ticketId});
  final String ticketId;

  @override
  List<Object> get props => [ticketId];
}
