import 'dart:async';

import 'package:app_base_v0/repository/authentication/models/response_create_token.dart';
import 'package:app_base_v0/repository/authentication/storage/storage_repository.dart';
import 'package:app_base_v0/repository/login/login_repository.dart';
import 'package:http/http.dart' as http;

class AuthenticationRepository {
  AuthenticationRepository({required this.loginRepository});
  LoginRepository loginRepository;

  final controller = StreamController<String>.broadcast();
  final storage = StorageRepository();
  final baseUrl = "https://desarrollo.macamedia.com.ar/siprocapi/api";

  // se llama dentro de authenticationBloc para
  // poder recibir los eventos, basicamente devuelve un stream al cual nos suscribimos dentro del bloc

  Stream status() async* {
    yield* controller.stream;
  }

  logIn(body) async {
    loginRepository.setLogging();
    try {
      var response = await http.post(Uri.parse("${baseUrl}/login"),
          headers: {"Accept": "application/json"}, body: body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final parsedLoginResponse = CreateTokenResponse.fromJson(response.body);
        storage.setToken(parsedLoginResponse.datos.datos.accessToken);
        loginRepository.setSuccessLogin();
        controller.add("Authenticated");
      } else {
        loginRepository.setFailedLogin();
        controller.add("Unauthenticated");
      }
    } catch (e) {
      loginRepository.setFailedLogin();
      controller.add("Unauthenticated");
      throw e;
    }
  }

  logOut(String token) async {
    try {
      var response = await http.post(Uri.parse("${baseUrl}/logout"), headers: {
        "Authorization": "Bearer ${token}",
        "Accept": "application/json"
      });
    } catch (e) {
      throw e;
    }
    await storage.removeToken();
    controller.add("Unauthenticated");
  }
}
