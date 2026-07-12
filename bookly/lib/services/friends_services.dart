import 'api_service.dart';

class FriendsService {
  static Future<Map<String, dynamic>> createFriend({
    required String userId,
    required String name,
    String? email,
    String? phone,
    String? notes,
  }) async {
    final response = await ApiService.post(
      '/friends',
      body: {
        'userId': userId,
        'name': name,
        'email': email,
        'phone': phone,
        'notes': notes,
      },
    );

    return Map<String, dynamic>.from(response);
  }

  static Future<List<Map<String, dynamic>>> listFriends({
    String? userId,
  }) async {
    final response = await ApiService.get(
      '/friends',
      queryParams: userId == null ? null : {'userId': userId},
    );

    return List<Map<String, dynamic>>.from(response);
  }

  static Future<Map<String, dynamic>> getFriendById(String id) async {
    final response = await ApiService.get('/friends/$id');

    return Map<String, dynamic>.from(response);
  }

  static Future<Map<String, dynamic>> updateFriend({
    required String id,
    String? name,
    String? email,
    String? phone,
    String? notes,
  }) async {
    final Map<String, dynamic> body = {};

    if (name != null) body['name'] = name;
    if (email != null) body['email'] = email;
    if (phone != null) body['phone'] = phone;
    if (notes != null) body['notes'] = notes;

    final response = await ApiService.put(
      '/friends/$id',
      body: body,
    );

    return Map<String, dynamic>.from(response);
  }

  static Future<Map<String, dynamic>> deleteFriend(String id) async {
    final response = await ApiService.delete('/friends/$id');

    return Map<String, dynamic>.from(response);
  }
}