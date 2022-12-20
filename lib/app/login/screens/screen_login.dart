import 'package:app_base_v0/app/authentication/bloc/bloc_authentication.dart';
import 'package:app_base_v0/app/authentication/bloc/state_authentication.dart';
import 'package:app_base_v0/app/login/bloc/bloc_login.dart';
import 'package:app_base_v0/app/login/bloc/event_login.dart';
import 'package:app_base_v0/app/login/bloc/state_login.dart';
import 'package:app_base_v0/app/login/screens/widgets/form_widget.dart';
import 'package:app_base_v0/repository/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          switch (state.status) {
            case FormzStatus.submissionInProgress:
              return CircularProgressIndicator();
            default:
              return FormLogin();
          }
        },
      )),
    );
  }
}
