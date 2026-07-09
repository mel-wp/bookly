class BookModel {
  final String title;
  final String author;
  final String image;
  final String year;
  final String category;
  final String description;
  bool available;

  BookModel({
    required this.title,
    required this.author,
    required this.image,
    required this.year,
    required this.category,
    required this.description,
    this.available = true,
  });
}
