import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pages/book_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const background = Color(0xFFF8F5F0);
    const primary = Color.fromARGB(255, 62, 31, 87);
    const accent = Color.fromARGB(255, 187, 139, 245);

    return Scaffold(
      backgroundColor: background,

      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        selectedIndex: 0,
        indicatorColor: accent.withOpacity(.3),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Início",
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            label: "Amigos",
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            label: "Prazos",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: "Perfil",
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Minha Biblioteca",
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: primary,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        "Bem-vinda de volta 📚",
                        style: GoogleFonts.poppins(color: Colors.grey[700]),
                      ),
                    ],
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_none),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              /// PESQUISA
              TextField(
                decoration: InputDecoration(
                  hintText: "Buscar livros...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              /// ESTATÍSTICAS
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      title: "Total",
                      value: "12",
                      color: primary,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _StatCard(
                      title: "Pendentes",
                      value: "5",
                      color: Colors.orange,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _StatCard(
                      title: "Devolvidos",
                      value: "7",
                      color: Colors.green,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// EMPRÉSTIMOS
              Text(
                "Empréstimos Recentes",
                style: GoogleFonts.playfairDisplay(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              _loanCard(
                name: "Clara Paludo",
                book: "A Revolução dos Bichos",
                status: "Pendente",
                statusColor: Colors.orange,
              ),

              const SizedBox(height: 12),

              _loanCard(
                name: "Sophia Mileski",
                book: "1984",
                status: "Devolvido",
                statusColor: Colors.green,
              ),

              const SizedBox(height: 30),

              /// SUGESTÕES
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sugestões para você",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  TextButton(onPressed: () {}, child: const Text("Ver todas")),
                ],
              ),

              const SizedBox(height: 15),

              SizedBox(
                height: 200,

                child: ListView(
                  scrollDirection: Axis.horizontal,

                  children: [
                    BookCover(
                      image:
                          "https://img.br.my-best.com/product_images/78119c9e42075cdc6b7a8f2448ff0af9.jpg?ixlib=rails-4.3.1&q=70&lossless=0&w=800&h=800&fit=clip&s=6d64ae189c0d444115b29de52eac4a90",
                      title: "Amor, teoricamente",
                      author: "Ali Hazelwood",
                    ),

                    SizedBox(width: 12),

                    BookCover(
                      image:
                          "https://http2.mlstatic.com/D_NQ_NP_812454-MLA94687199899_102025-O.webp",
                      title: "Patinando no Amor",
                      author: "Lynn Painter",
                    ),

                    SizedBox(width: 12),

                    BookCover(
                      image:
                          "https://m.media-amazon.com/images/I/81LTEfXYgcL.jpg",
                      title: "A Hipótese do Amor",
                      author: "Ali Hazelwood",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loanCard({
    required String name,
    required String book,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFD4A373),
            child: Text(name[0]),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),

                Text(book),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),

            decoration: BoxDecoration(
              color: statusColor.withOpacity(.15),
              borderRadius: BorderRadius.circular(20),
            ),

            child: Text(
              status,
              style: TextStyle(color: statusColor, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),

          const SizedBox(height: 5),

          Text(title),
        ],
      ),
    );
  }
}

class BookCover extends StatelessWidget {
  final String image;
  final String title;
  final String author;

  const BookCover({
    super.key,
    required this.image,
    required this.title,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BookDetailPage()),
        );
      },

      child: Container(
        width: 120,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),

          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              offset: Offset(0, 4),
              color: Colors.black12,
            ),
          ],
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),

          child: Image.network(image, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
