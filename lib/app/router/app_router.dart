import 'dart:async';

import 'package:app_base_v0/app/login/screens/screen_login.dart';
import 'package:app_base_v0/app/screen_home.dart';
import 'package:app_base_v0/repository/login/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../authentication/bloc/bloc_authentication.dart';
import '../authentication/bloc/state_authentication.dart';
import '../login/bloc/bloc_login.dart';

class AppRouter {
  appRouter(BuildContext context, LoginRepository loginRepository) {
    return GoRouter(
      refreshListenable: GoRouterRefreshStream(
          BlocProvider.of<AuthenticationBloc>(context).stream),
      routes: [
        GoRoute(
          path: "/login",
          builder: (context, state) => BlocProvider(
            create: (context) => LoginBloc(loginRepository: loginRepository),
            child: LoginScreen(),
          ),
          name: "login",
          redirect: (context, state) {
            bool isLogged =
                context.read<AuthenticationBloc>().state is Authenticated;
            if (isLogged) {
              return "/";
            }
          },
        ),
        GoRoute(
          path: "/",
          builder: (context, state) => HomeScreen(),
          name: "home",
        ),
      ],
      redirect: (context, state) {
        bool isLogged =
            context.read<AuthenticationBloc>().state is Authenticated;

        if (!isLogged) return "/login";
      },
    );
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
