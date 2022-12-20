import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../repository/authentication/authentication_repository.dart';
import '../../bloc/bloc_login.dart';
import '../../bloc/event_login.dart';

class FormLogin extends StatelessWidget {
  const FormLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginBloc>().state;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          onChanged: (value) {
            context.read<LoginBloc>().add(UsernameChanged(username: value));
          },
        ),
        TextFormField(
          onChanged: (value) {
            context.read<LoginBloc>().add(PasswordChanged(password: value));
          },
        ),
        Text(
            "el usuario es :${state.username.value} ,la contraseña: ${state.password.value}, validez: ${state.status.toString()}"),
        ElevatedButton(
            onPressed: () async {
              if (state.status == FormzStatus.valid) {
                await RepositoryProvider.of<AuthenticationRepository>(context)
                    .logIn({
                  "email": state.username.value,
                  "password": state.password.value
                });
              }
            },
            child: Text("Login"))
      ],
    );
  }
}
