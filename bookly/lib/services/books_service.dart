import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_service.dart';

class BooksService {
  static Future<String> uploadImage(File image) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${ApiService.baseUrl}/upload'),
    );

    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Erro ao enviar imagem');
    }

    final body = await response.stream.bytesToString();
    final data = jsonDecode(body);

    return data['imageUrl'];
  }

  static Future<Map<String, dynamic>> createBook({
    required String userId,
    required String title,
    required String author,
    String? publisher,
    String? category,
    String? description,
    String? coverUrl,
  }) async {
    final response = await ApiService.post(
      '/books',
      body: {
        'userId': userId,
        'title': title,
        'author': author,
        'publisher': publisher,
        'category': category,
        'description': description,
        'coverUrl': coverUrl,
      },
    );

    return Map<String, dynamic>.from(response);
  }

  static Future<List<Map<String, dynamic>>> listBooks({
    String? userId,
    bool? available,
  }) async {
    final Map<String, String> queryParams = {};

    if (userId != null) {
      queryParams['userId'] = userId;
    }

    if (available != null) {
      queryParams['available'] = available.toString();
    }

    final response = await ApiService.get(
      '/books',
      queryParams: queryParams.isEmpty ? null : queryParams,
    );

    return List<Map<String, dynamic>>.from(response);
  }

  static Future<Map<String, dynamic>> getBookById(String id) async {
    final response = await ApiService.get('/books/$id');

    return Map<String, dynamic>.from(response);
  }

  static Future<Map<String, dynamic>> updateBook({
    required String id,
    String? title,
    String? author,
    String? publisher,
    String? category,
    String? description,
    String? coverUrl,
    bool? available,
  }) async {
    final Map<String, dynamic> body = {};

    if (title != null) body['title'] = title;
    if (author != null) body['author'] = author;
    if (publisher != null) body['publisher'] = publisher;
    if (category != null) body['category'] = category;
    if (description != null) body['description'] = description;
    if (coverUrl != null) body['coverUrl'] = coverUrl;
    if (available != null) body['available'] = available;

    final response = await ApiService.put('/books/$id', body: body);

    return Map<String, dynamic>.from(response);
  }

  static Future<Map<String, dynamic>> deleteBook(String id) async {
    final response = await ApiService.delete('/books/$id');

    return Map<String, dynamic>.from(response);
  }
}
