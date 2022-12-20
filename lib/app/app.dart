import 'package:app_base_v0/app/authentication/bloc/bloc_authentication.dart';
import 'package:app_base_v0/app/router/app_router.dart';
import 'package:app_base_v0/repository/authentication/authentication_repository.dart';
import 'package:app_base_v0/repository/authentication/storage/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/login/login_repository.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginRepository loginRepository = LoginRepository();
    return MultiRepositoryProvider(
        child: GetUserFromStorageWidget(),
        providers: [
          RepositoryProvider<LoginRepository>(
              create: (context) => loginRepository),
          RepositoryProvider<AuthenticationRepository>(
              create: (context) =>
                  AuthenticationRepository(loginRepository: loginRepository))
        ]);
  }
}

class GetUserFromStorageWidget extends StatelessWidget {
  const GetUserFromStorageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // SE APROVECHA EL TIEMPO EN EL CUAL SE BUSCA EL USER EN EL STORAGE PARA
      // MOSTRAR EL SPLASH -- SE PUEDE CAMBIAR DENTRO DE LA FUNCION getToken
      future: StorageRepository().getToken(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            {
              if (snapshot.hasData) {
                return BlocProvider(
                    create: (context) => AuthenticationBloc(
                        authenticationRepository:
                            RepositoryProvider.of<AuthenticationRepository>(
                                context),
                        state: snapshot.data),
                    child: AppView());
              } else {
                return BlocProvider(
                    create: (context) => AuthenticationBloc(
                        authenticationRepository:
                            RepositoryProvider.of<AuthenticationRepository>(
                                context)),
                    child: AppView());
              }
            }
          case ConnectionState.waiting:
            {
              return MaterialApp(
                home: Scaffold(
                  body: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text(
                        "SPLASH",
                        style: TextStyle(fontSize: 40),
                      )
                    ],
                  )),
                ),
              );
            }
          default:
            return Container();
        }
      },
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter()
          .appRouter(context, RepositoryProvider.of<LoginRepository>(context)),
    );
  }
}
