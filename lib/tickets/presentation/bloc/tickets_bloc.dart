import 'package:bloc/bloc.dart';
import 'package:chatbot/tickets/tickets.dart';
import 'package:equatable/equatable.dart';

part 'tickets_event.dart';
part 'tickets_state.dart';

class TicketsBloc extends Bloc<TicketsEvent, TicketsState> {
  TicketsBloc() : super(const TicketsInitial()) {
    on<TicketsSubscriptionRequestedEvent>((event, emit) {});
  }
}
