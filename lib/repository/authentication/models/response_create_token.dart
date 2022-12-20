// To parse this JSON data, do
//
//     final createTokenResponse = createTokenResponseFromMap(jsonString);

import 'dart:convert';

class CreateTokenResponse {
  CreateTokenResponse({
    required this.estado,
    required this.excepcion,
    required this.mensaje,
    required this.datos,
  });

  int estado;
  dynamic excepcion;
  String mensaje;
  CreateTokenResponsePayload datos;

  factory CreateTokenResponse.fromJson(String str) {
    return CreateTokenResponse.fromMap(json.decode(str));
  }

  factory CreateTokenResponse.fromMap(Map<String, dynamic> json) {
    return CreateTokenResponse(
      estado: json["estado"],
      excepcion: json["excepcion"],
      mensaje: json["mensaje"],
      datos: CreateTokenResponsePayload.fromMap(json["datos"]),
    );
  }
}

class CreateTokenResponsePayload {
  CreateTokenResponsePayload({
    required this.pagTotal,
    required this.pagActual,
    required this.pagTotalItems,
    required this.datos,
  });

  int pagTotal;
  int pagActual;
  int pagTotalItems;
  PayloadDatos datos;

  factory CreateTokenResponsePayload.fromJson(String str) =>
      CreateTokenResponsePayload.fromMap(json.decode(str));

  factory CreateTokenResponsePayload.fromMap(Map<String, dynamic> json) =>
      CreateTokenResponsePayload(
        pagTotal: json["pagTotal"],
        pagActual: json["pagActual"],
        pagTotalItems: json["pagTotalItems"],
        datos: PayloadDatos.fromMap(json["datos"]),
      );
}

class PayloadDatos {
  PayloadDatos({
    required this.tokenType,
    required this.accessToken,
  });

  String tokenType;
  String accessToken;

  factory PayloadDatos.fromJson(String str) =>
      PayloadDatos.fromMap(json.decode(str));

  factory PayloadDatos.fromMap(Map<String, dynamic> json) => PayloadDatos(
        tokenType: json["token_type"],
        accessToken: json["access_token"],
      );
}
