part of 'payment_bloc.dart';

enum PaymentStatus { initial, loading, success, failure }

class PaymentState extends Equatable {
  const PaymentState({required this.status});

  final PaymentStatus status;

  PaymentState copyWith({PaymentStatus? status, String? error}) {
    return PaymentState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}

final class PaymentInitial extends PaymentState {
  const PaymentInitial({super.status = PaymentStatus.initial});
}
