import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatbot/payment/payment.dart';
import 'package:equatable/equatable.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc({required PaymentRepository paymentRepository})
      : _paymentRepository = paymentRepository,
        super(const PaymentInitial()) {
    on<PaymentAttemptCompletionEvent>(_onPaymentCompleted);
  }

  final PaymentRepository _paymentRepository;

  Future<void> _onPaymentCompleted(
    PaymentAttemptCompletionEvent event,
    Emitter<PaymentState> emit,
  ) async {
    try {
      emit(state.copyWith(status: PaymentStatus.loading));
      await _paymentRepository.markPaymentCompleted(ticketId: event.ticketId);
      emit(state.copyWith(status: PaymentStatus.success));
    } catch (e) {
      emit(state.copyWith(status: PaymentStatus.failure));
    }
  }
}
