import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // static const String apiUrl = 'http://10.10.10.24:4000/'; //Daniel
  static const String apiUrl = 'http://192.168.1.118:4000/';

  // Función para registrar un usuario
  static Future<String> registerUser(
    String nombre,
    String apellido,
    String email,
    String birthdate,
    String password,
  ) async {
    final url = Uri.parse("${apiUrl}registerUser");

    // Cuerpo de la petición
    Map<String, String> body = {
      'nombre': nombre,
      'apellido': apellido,
      'email': email,
      'birthdate': birthdate,
      'password': password,
    };

    try {
      // Realizamos la petición PUT
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body), // Convertimos el body a JSON
      );

      // Verificamos si la respuesta fue exitosa
      if (response.statusCode == 201) {
        return (response.body);
      } else {
        return ('Error al registrar usuario: ${response.statusCode}');
      }
    } catch (e) {
      return ('Error: $e');
    }
  }

  // Función para hacer login
  static Future<Map<String, dynamic>> loginUser(
      String email, String password) async {
    final url = Uri.parse("${apiUrl}login");

    // Cuerpo de la petición
    Map<String, String> body = {
      'email': email,
      'password': password,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body), // Convertimos el body a JSON
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'error': 'Correo o contraseña incorrectos'};
      }
    } catch (e) {
      return {'error': 'Error de conexión: $e'}; // En caso de error
    }
  }

// Función para restablecer la contraseña
  static Future<Map<String, dynamic>> resetPassword(
      String email, String password) async {
    final url = Uri.parse("${apiUrl}resetPassword");

    // Cuerpo de la petición
    Map<String, String> body = {
      'email': email,
      'password': password,
    };

    try {
      // Realizamos la petición PUT
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body), // Convertimos el body a JSON
      );

      // Verificamos si la respuesta fue exitosa
      if (response.statusCode == 201) {
        return json.decode(
            response.body); // Decodificamos el cuerpo de la respuesta JSON
      } else {
        return {'error': 'Error al registrar usuario: ${response.statusCode}'};
      }
    } catch (e) {
      return {'error': 'Error: $e'};
    }
  }

  // Función para obtener info del perfil de usuario
  static Future<Map<String, dynamic>> profileUser(String email) async {
    final url = Uri.parse("${apiUrl}profileUser");

    // Cuerpo de la petición
    Map<String, String> body = {
      'email': email,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body), // Convertimos el body a JSON
      );

      if (response.statusCode == 200) {
        return json
            .decode(response.body); // Devolvemos el JSON en caso de éxito
      } else {
        return {'error': 'No se pudo actualizar.'};
      }
    } catch (e) {
      return {'error': 'Error de conexión.'}; // En caso de error
    }
  }

  // Función para actualizar la informacion de perfil de un usuario
  static Future<String> updateProfileInfo(
    String name,
    String lastName,
    String email,
    String birthDate,
  ) async {
    final url = Uri.parse("${apiUrl}updatePerfil");

    // Cuerpo de la petición
    Map<String, String> body = {
      'name': name,
      'lastName': lastName,
      'email': email,
      'birthdate': birthDate,
    };

    try {
      // Realizamos la petición PUT
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body), // Convertimos el body a JSON
      );

      // Verificamos si la respuesta fue exitosa
      if (response.statusCode == 201) {
        return (response.body);
      } else {
        return ('Error al actualizar la información: ${response.statusCode}');
      }
    } catch (e) {
      return ('Error: $e');
    }
  }
}
