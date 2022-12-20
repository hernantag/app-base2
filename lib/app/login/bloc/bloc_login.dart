import 'dart:async';

import 'package:app_base_v0/app/login/bloc/state_login.dart';
import 'package:app_base_v0/app/login/models/model_pasword.dart';
import 'package:app_base_v0/app/login/models/model_username.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../repository/login/login_repository.dart';
import 'event_login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required LoginRepository loginRepository}) : super(LoginState()) {
    on<UsernameChanged>(_onUsernameChange);
    on<PasswordChanged>(_onPasswordChange);
    on<FormSubmitted>(_onFormSubmitted);

    streamSubscription =
        loginRepository.statusLogin().asBroadcastStream().listen((status) {
      add(FormSubmitted(status: status));
    });
  }

  late StreamSubscription streamSubscription;
  _onUsernameChange(UsernameChanged event, Emitter<dynamic> emit) {
    final username = Username.dirty(value: event.username);

    emit(state.copyWith(
        username: username,
        status: Formz.validate([username, state.password])));
  }

  _onPasswordChange(PasswordChanged event, Emitter<dynamic> emit) {
    final password = Password.dirty(value: event.password);

    emit(state.copyWith(
        password: password,
        status: Formz.validate([state.username, password])));
  }

  _onFormSubmitted(FormSubmitted event, Emitter<dynamic> emit) async {
    print(event.status);
    switch (event.status) {
      case "Logging":
        {
          emit(state.copyWith(status: FormzStatus.submissionInProgress));
          break;
        }
      case "Failed":
        {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
          break;
        }
      case "Success":
        {
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
          break;
        }
      default:
        {}
    }
  }

  @override
  void onChange(Change<LoginState> change) {
    super.onChange(change);
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
