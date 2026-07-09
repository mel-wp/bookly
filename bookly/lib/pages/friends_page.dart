import 'package:flutter/material.dart';

import '../widgets/expandable_friend_card.dart';
import '../core/app_theme.dart';
import '../widgets/app_bottom_navigation.dart';
import '../widgets/app_header.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: 'Meus Amigos',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Pesquisar amigo...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  ExpandableFriendCard(
                    initials: "AC",
                    name: "Ana Clara",
                    email: "ana@email.com",
                    book: "O Alquimista",
                    dueDate: "20/06/2026",
                  ),

                  SizedBox(height: 14),

                  ExpandableFriendCard(
                    initials: "BS",
                    name: "Bruno Santos",
                    email: "bruno@email.com",
                    book: "1984",
                    dueDate: "15/06/2026",
                  ),

                  SizedBox(height: 14),

                  ExpandableFriendCard(
                    initials: "CR",
                    name: "Camila Rocha",
                    email: "camila@email.com",
                    book: "Dom Casmurro",
                    dueDate: "25/06/2026",
                  ),

                  SizedBox(height: 14),

                  ExpandableFriendCard(
                    initials: "DM",
                    name: "Diego Moura",
                    email: "diego@email.com",
                    book: "Percy Jackson",
                    dueDate: "02/07/2026",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primary,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 1),
    );
  }
}
