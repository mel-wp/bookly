import 'api_service.dart';

class UsersService {
  static Future<Map<String, dynamic>> createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await ApiService.post(
      '/users',
      body: {
        'name': name,
        'email': email,
        'password': password,
      },
    );

    return Map<String, dynamic>.from(response);
  }

  static Future<List<Map<String, dynamic>>> listUsers() async {
    final response = await ApiService.get('/users');

    return List<Map<String, dynamic>>.from(response);
  }

  static Future<Map<String, dynamic>> getUserById(String id) async {
    final response = await ApiService.get('/users/$id');

    return Map<String, dynamic>.from(response);
  }

  static Future<Map<String, dynamic>> updateUser({
    required String id,
    String? name,
    String? email,
    String? password,
  }) async {
    final Map<String, dynamic> body = {};

    if (name != null) body['name'] = name;
    if (email != null) body['email'] = email;
    if (password != null) body['password'] = password;

    final response = await ApiService.put(
      '/users/$id',
      body: body,
    );

    return Map<String, dynamic>.from(response);
  }

  static Future<Map<String, dynamic>> deleteUser(String id) async {
    final response = await ApiService.delete('/users/$id');

    return Map<String, dynamic>.from(response);
  }
}