import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../widgets/app_header.dart';
import '../widgets/status_chip.dart';
import '../widgets/app_bottom_navigation.dart';
import 'new_loan_page.dart';

class BookDetailPage extends StatelessWidget {
  final String title;
  final String author;
  final String image;
  final String year;
  final String category;
  final String description;
  final String status;

  const BookDetailPage({
    super.key,
    required this.title,
    required this.author,
    required this.image,
    required this.year,
    required this.category,
    required this.description,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: "Detalhes do Livro", showBackButton: true),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            // CAPA DO LIVRO
            Container(
              height: 280,
              width: 190,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),

                child: Image.network(image, fit: BoxFit.cover),
              ),
            ),

            const SizedBox(height: 25),

            Text(
              title,

              style: TextStyle(
                color: AppTheme.title,

                fontSize: 26,

                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              author,

              style: TextStyle(color: AppTheme.subtitle, fontSize: 16),
            ),

            const SizedBox(height: 20),

            StatusChip(text: status, color: AppTheme.success),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: AppTheme.card,

                borderRadius: BorderRadius.circular(18),

                border: Border.all(color: AppTheme.border),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    "Informações",

                    style: TextStyle(
                      fontSize: 18,

                      fontWeight: FontWeight.bold,

                      color: AppTheme.title,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    "Autor: $author",
                    style: TextStyle(color: AppTheme.subtitle),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Ano: $year",
                    style: TextStyle(color: AppTheme.subtitle),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Categoria: $category",
                    style: TextStyle(color: AppTheme.subtitle),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(243, 93, 107, 229),

                  padding: const EdgeInsets.all(16),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),

                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewLoanPage(),
                    ),
                  );
                },

                child: const Text(
                  "Solicitar empréstimo",

                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const AppBottomNavigation(currentIndex: 0),
    );
  }
}
