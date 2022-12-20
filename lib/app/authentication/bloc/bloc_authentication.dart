import 'dart:async';

import 'package:app_base_v0/app/authentication/bloc/state_authentication.dart';
import 'package:app_base_v0/repository/authentication/authentication_repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/user/models/model_user.dart';
import 'event_authentication.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
      {required AuthenticationRepository authenticationRepository,
      String? state})
      : super(state != null ? Authenticated(token: state) : Unknown()) {
    on<StatusChanged>(_onStatusChange);
    on<LogoutRequest>(_logoutRequest, transformer: droppable());

    statusSubscription =
        authenticationRepository.status().asBroadcastStream().listen((event) {
      return add(StatusChanged(status: event));
    });
  }

  late final StreamSubscription statusSubscription;

  _onStatusChange(StatusChanged event, Emitter<dynamic> emit) async {
    switch (event.status) {
      case "Unauthenticated":
        {
          emit(Unauthenticated());
          break;
        }
      case "Authenticated":
        {
          emit(Authenticated(token: event.status));
          break;
        }
      case "Unknown":
        {
          emit(Unknown());
          break;
        }
      default:
        emit(Unknown());
    }
  }

  _logoutRequest(LogoutRequest event, Emitter<dynamic> emitter) async {}

  @override
  void onChange(Change<AuthenticationState> change) {
    super.onChange(change);

    if (change.nextState is Authenticated) {
      final algo = change.nextState as Authenticated;
    }
  }

  @override
  Future<void> close() {
    statusSubscription.cancel();
    return super.close();
  }
}
