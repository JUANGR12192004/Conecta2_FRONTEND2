import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

class ApiService {
  // ==========================
  // BASE URL
  // ==========================
  static String host =
      kIsWeb ? "http://localhost:8080" : "http://10.0.2.2:8080";

  static String get _apiPrefix => "/api/v1";
  static Uri _u(String path, {Map<String, String>? query}) =>
      Uri.parse("$host$_apiPrefix$path").replace(queryParameters: query);

  // ==========================
  // JWT EN MEMORIA
  // ==========================
  static String? _jwt;
  static String? get token => _jwt;
  static void setToken(String? t) => _jwt = t;
  static void clearToken() => _jwt = null;

  // ==========================
  // HEADERS
  // ==========================
  static Map<String, String> _jsonHeaders({bool auth = false}) {
    final h = <String, String>{"Content-Type": "application/json"};
    if (auth && _jwt != null) h["Authorization"] = "Bearer $_jwt";
    return h;
  }

  // ==========================
  // TRABAJADORES
  // ==========================
  static Future<Map<String, dynamic>> registerWorker({
    required String nombreCompleto,
    required String correo,
    required String celular,
    required String areaServicio,
    required String contrasena,
    required String confirmarContrasena,
  }) async {
    final res = await http
        .post(
          _u("/auth/workers/register"),
          headers: _jsonHeaders(),
          body: jsonEncode({
            "nombreCompleto": nombreCompleto,
            "correo": correo,
            "celular": celular,
            "areaServicio": areaServicio,
            "contrasena": contrasena,
            "confirmarContrasena": confirmarContrasena,
          }),
        )
        .timeout(const Duration(seconds: 15));
    return _processResponse(res, "registro de trabajador");
  }

  static Future<Map<String, dynamic>> loginWorker({
    required String correo,
    required String contrasena,
  }) async {
    final res = await http
        .post(
          _u("/auth/login"),
          headers: _jsonHeaders(),
          body: jsonEncode({"email": correo, "password": contrasena}),
        )
        .timeout(const Duration(seconds: 15));

    final data = _processResponse(res, "login de trabajador");
    if (data["token"] is String) setToken(data["token"]);
    return data;
  }

  static Future<Map<String, dynamic>> verifyAccount(String activationToken) async {
    final res = await http
        .get(
          _u("/auth/verify", query: {"token": activationToken}),
          headers: _jsonHeaders(),
        )
        .timeout(const Duration(seconds: 15));
    return _processResponse(res, "verificación de cuenta");
  }

  static Future<Map<String, dynamic>> resendActivation(String email) async {
    final res = await http
        .post(
          _u("/auth/resend-activation"),
          headers: _jsonHeaders(),
          body: jsonEncode({"email": email}),
        )
        .timeout(const Duration(seconds: 15));
    return _processResponse(res, "reenviar activación");
  }

  // ==========================
  // CLIENTES
  // ==========================
  static Future<Map<String, dynamic>> registerClient({
    required String nombreCompleto,
    required String correo,
    required String celular,
    required String contrasena,
    required String confirmarContrasena,
  }) async {
    final res = await http
        .post(
          _u("/auth/clients/register"),
          headers: _jsonHeaders(),
          body: jsonEncode({
            "nombreCompleto": nombreCompleto,
            "correo": correo,
            "celular": celular,
            "contrasena": contrasena,
            "confirmarContrasena": confirmarContrasena,
          }),
        )
        .timeout(const Duration(seconds: 15));
    return _processResponse(res, "registro de cliente");
  }

  static Future<Map<String, dynamic>> loginClient({
    required String correo,
    required String contrasena,
  }) async {
    final res = await http
        .post(
          _u("/auth/clients/login"),
          headers: _jsonHeaders(),
          body: jsonEncode({"email": correo, "password": contrasena}),
        )
        .timeout(const Duration(seconds: 15));

    final data = _processResponse(res, "login de cliente");
    if (data["token"] is String) setToken(data["token"]);
    return data;
  }
   static Future<Map<String, dynamic>> verifyClientAccount(String activationToken) async {
    final res = await http
        .get(
          _u("/auth/clients/verify", query: {"token": activationToken}),
          headers: _jsonHeaders(),
        )
        .timeout(const Duration(seconds: 15));
    return _processResponse(res, "verificación de cuenta");
  }

  // ==========================
  // EJEMPLO PROTEGIDO
  // ==========================
  static Future<Map<String, dynamic>> getWorkerProfile() async {
    final res = await http
        .get(
          _u("/workers/me"),
          headers: _jsonHeaders(auth: true),
        )
        .timeout(const Duration(seconds: 15));
    return _processResponse(res, "obtener perfil");
  }

  // ==========================
  // Helper de respuestas
  // ==========================
  static Map<String, dynamic> _processResponse(http.Response response, String proceso) {
    final status = response.statusCode;
    final body = response.body;

    dynamic decoded;
    try {
      decoded = body.isNotEmpty ? jsonDecode(body) : null;
    } catch (_) {
      decoded = null;
    }

    if (status == 200 || status == 201) {
      return (decoded is Map<String, dynamic>) ? decoded : {"ok": true, "raw": body};
    }

    if (status == 400) throw Exception(_msg(decoded, fallback: "Petición inválida ($proceso)"));
    if (status == 401) throw Exception(_msg(decoded, fallback: "No autorizado. Revisa tus credenciales."));
    if (status == 403) throw Exception(_msg(decoded, fallback: "Acceso prohibido (¿Cuenta no verificada?)."));
    if (status >= 500) throw Exception("Error del servidor ($status): $body");

    throw Exception(_msg(decoded, fallback: "Error en $proceso: $body"));
  }

  static String _msg(dynamic decoded, {required String fallback}) {
    if (decoded is Map && decoded["mensaje"] is String) return decoded["mensaje"];
    if (decoded is Map && decoded["message"] is String) return decoded["message"];
    return fallback;
  }
}
