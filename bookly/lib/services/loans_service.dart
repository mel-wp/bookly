import 'api_service.dart';

class LoansService {
  static Future<Map<String, dynamic>> createLoan({
    required String userId,
    required String friendId,
    required String bookId,
    required DateTime dueDate,
    DateTime? loanDate,
    String? notes,
    String? photoUrl,
  }) async {
    final response = await ApiService.post(
      '/loans',
      body: {
        'userId': userId,
        'friendId': friendId,
        'bookId': bookId,
        'loanDate': loanDate?.toIso8601String(),
        'dueDate': dueDate.toIso8601String(),
        'notes': notes,
        'photoUrl': photoUrl,
      },
    );

    return Map<String, dynamic>.from(response);
  }

  static Future<List<Map<String, dynamic>>> listLoans({
    String? userId,
    String? status,
  }) async {
    final Map<String, String> queryParams = {};

    if (userId != null) {
      queryParams['userId'] = userId;
    }

    if (status != null) {
      queryParams['status'] = status;
    }

    final response = await ApiService.get(
      '/loans',
      queryParams: queryParams.isEmpty ? null : queryParams,
    );

    return List<Map<String, dynamic>>.from(response);
  }

  static Future<Map<String, dynamic>> getLoanById(String id) async {
    final response = await ApiService.get('/loans/$id');

    return Map<String, dynamic>.from(response);
  }

  static Future<Map<String, dynamic>> updateLoan({
    required String id,
    String? friendId,
    String? bookId,
    DateTime? loanDate,
    DateTime? dueDate,
    DateTime? returnedDate,
    String? status,
    String? notes,
    String? photoUrl,
  }) async {
    final Map<String, dynamic> body = {};

    if (friendId != null) body['friendId'] = friendId;
    if (bookId != null) body['bookId'] = bookId;
    if (loanDate != null) body['loanDate'] = loanDate.toIso8601String();
    if (dueDate != null) body['dueDate'] = dueDate.toIso8601String();
    if (returnedDate != null) {
      body['returnedDate'] = returnedDate.toIso8601String();
    }
    if (status != null) body['status'] = status;
    if (notes != null) body['notes'] = notes;
    if (photoUrl != null) body['photoUrl'] = photoUrl;

    final response = await ApiService.put(
      '/loans/$id',
      body: body,
    );

    return Map<String, dynamic>.from(response);
  }

  static Future<Map<String, dynamic>> markLoanAsReturned(String id) async {
    final response = await ApiService.patch('/loans/$id/return');

    return Map<String, dynamic>.from(response);
  }

  static Future<Map<String, dynamic>> deleteLoan(String id) async {
    final response = await ApiService.delete('/loans/$id');

    return Map<String, dynamic>.from(response);
  }
}