import 'dart:async';

class LoginRepository {
  final controller = StreamController.broadcast();

  // se llama dentro de loginBloc para
  // poder recibir los eventos, basicamente devuelve un stream al cual nos suscribimos dentro del bloc

  Stream statusLogin() async* {
    yield* controller.stream;
  }

  setLogging() async {
    controller.add("Logging");
  }

  setFailedLogin() async {
    controller.add("Failed");
  }

  setSuccessLogin() async {
    controller.add("Success");
  }
}
