import 'book_model.dart';
import 'friend_model.dart';

class LoanModel {
  final BookModel book;
  final FriendModel friend;
  final DateTime loanDate;
  final DateTime returnDate;
  bool returned;

  LoanModel({
    required this.book,
    required this.friend,
    required this.loanDate,
    required this.returnDate,
    this.returned = false,
  });
}
