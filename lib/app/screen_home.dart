import 'package:app_base_v0/app/authentication/bloc/bloc_authentication.dart';
import 'package:app_base_v0/app/authentication/bloc/state_authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../repository/authentication/authentication_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<AuthenticationBloc>(context).state;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                if (state is Authenticated) {
                  await RepositoryProvider.of<AuthenticationRepository>(context)
                      .logOut(state.token);
                }
              },
              child: Text("logout")),
          ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/login');
              },
              child: Text("xd"))
        ],
      )),
    );
  }
}
