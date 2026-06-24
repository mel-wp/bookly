import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const background = Color(0xFFF8F5F0);
    const primary = Color(0xFF5B3E31);
    const accent = Color(0xFFD4A373);

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
                name: "Ana Clara",
                book: "O Alquimista",
                status: "Pendente",
                statusColor: Colors.orange,
              ),

              const SizedBox(height: 12),

              _loanCard(
                name: "Bruno Santos",
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

                  children: const [
                    BookCover(
                      image:
                          "https://m.media-amazon.com/images/I/71aFt4+OTOL.jpg",
                    ),

                    SizedBox(width: 12),

                    BookCover(
                      image:
                          "https://m.media-amazon.com/images/I/81h4CdNxdJL.jpg",
                    ),

                    SizedBox(width: 12),

                    BookCover(
                      image:
                          "https://m.media-amazon.com/images/I/91dSMhdIzTL.jpg",
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

  const BookCover({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
