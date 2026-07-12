import 'users_service.dart';

class SessionService {
  static Map<String, dynamic>? _currentUser;

  static Future<Map<String, dynamic>> getCurrentUser() async {
    if (_currentUser != null) {
      return _currentUser!;
    }

    final users = await UsersService.listUsers();

    if (users.isNotEmpty) {
      _currentUser = users.first;
      return _currentUser!;
    }

    _currentUser = await UsersService.createUser(
      name: 'Usuário Bookly',
      email: 'usuario@bookly.com',
      password: '123456',
    );

    return _currentUser!;
  }

  static Future<String> getCurrentUserId() async {
    final user = await getCurrentUser();
    return user['id'].toString();
  }
}