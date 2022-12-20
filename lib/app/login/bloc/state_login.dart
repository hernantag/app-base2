import 'package:app_base_v0/app/login/models/model_pasword.dart';
import 'package:formz/formz.dart';

import '../models/model_username.dart';

class LoginState {
  LoginState(
      {this.username = const Username.pure(),
      this.password = const Password.pure(),
      this.status = FormzStatus.pure});

  Username username;
  Password password;
  FormzStatus status;

  copyWith({Username? username, Password? password, FormzStatus? status}) {
    return LoginState(
        status: status ?? this.status,
        username: username ?? this.username,
        password: password ?? this.password);
  }
}
