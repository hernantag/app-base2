import 'package:shared_preferences/shared_preferences.dart';

class StorageRepository {
  StorageRepository();
  // devuelve token de storage si es que existe
  Future getToken() async {
    final instance = await SharedPreferences.getInstance();

    Future<String?> asyncToken() async {
      await Future.delayed(Duration(seconds: 1));
      return instance.getString("token");
    }

    return asyncToken();
  }

  // guarda token en storage para persistencia de sesion
  setToken(String token) async {
    try {
      final instance = await SharedPreferences.getInstance();
      await instance.setString("token", token);
    } catch (e) {
      throw e;
    }
  }

  // borra el token del storage
  removeToken() async {
    try {
      final instance = await SharedPreferences.getInstance();
      await instance.remove("token");
    } catch (e) {
      throw e;
    }
  }
}
