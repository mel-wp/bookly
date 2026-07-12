import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../pages/add_friend_page.dart';
import '../services/friends_services.dart';
import '../services/session_service.dart';
import '../widgets/app_bottom_navigation.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final TextEditingController searchController = TextEditingController();

  bool isLoading = true;
  String search = '';
  String? errorMessage;

  List<Map<String, dynamic>> friends = [];

  @override
  void initState() {
    super.initState();
    loadFriends();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> loadFriends() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final userId = await SessionService.getCurrentUserId();

      final loadedFriends = await FriendsService.listFriends(
        userId: userId,
      );

      if (!mounted) return;

      setState(() {
        friends = loadedFriends;
        isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        errorMessage = error.toString();
        isLoading = false;
      });
    }
  }

  Future<void> openAddFriendPage() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => const AddFriendPage(),
      ),
    );

    if (result == true) {
      await loadFriends();
    }
  }

  List<Map<String, dynamic>> get filteredFriends {
    if (search.trim().isEmpty) {
      return friends;
    }

    final searchLower = search.toLowerCase();

    return friends.where((friend) {
      final name = friend['name']?.toString().toLowerCase() ?? '';
      final email = friend['email']?.toString().toLowerCase() ?? '';
      final phone = friend['phone']?.toString().toLowerCase() ?? '';

      return name.contains(searchLower) ||
          email.contains(searchLower) ||
          phone.contains(searchLower);
    }).toList();
  }

  String initialsFromName(String name) {
    final parts = name.trim().split(' ');

    if (parts.isEmpty || name.trim().isEmpty) {
      return '?';
    }

    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }

    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  int activeLoansCount(Map<String, dynamic> friend) {
    final loans = friend['loans'];

    if (loans is! List) {
      return 0;
    }

    return loans.where((loan) {
      if (loan is! Map<String, dynamic>) {
        return false;
      }

      final status = loan['status']?.toString();

      return status == 'PENDING' || status == 'LATE';
    }).length;
  }

  @override
  Widget build(BuildContext context) {
    final visibleFriends = filteredFriends;

    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        onPressed: openAddFriendPage,
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Amigo'),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: loadFriends,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader(),
                const SizedBox(height: 25),
                buildSearchField(),
                const SizedBox(height: 25),
                if (isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (errorMessage != null)
                  buildErrorState()
                else if (visibleFriends.isEmpty)
                  const _EmptyCard(
                    icon: Icons.people_outline,
                    title: 'Nenhum amigo cadastrado',
                    description:
                        'Clique no botão “Amigo” para cadastrar uma pessoa para quem você empresta livros.',
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: visibleFriends.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final friend = visibleFriends[index];
                      final name = friend['name']?.toString() ?? 'Sem nome';
                      final email = friend['email']?.toString();
                      final phone = friend['phone']?.toString();
                      final notes = friend['notes']?.toString();
                      final activeLoans = activeLoansCount(friend);

                      return _FriendCard(
                        initials: initialsFromName(name),
                        name: name,
                        email: email,
                        phone: phone,
                        notes: notes,
                        activeLoans: activeLoans,
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 1),
    );
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Amigos',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Pessoas que pegam seus livros emprestados',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 15,
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: IconButton(
            onPressed: loadFriends,
            icon: const Icon(Icons.refresh),
          ),
        ),
      ],
    );
  }

  Widget buildSearchField() {
    return TextField(
      controller: searchController,
      onChanged: (value) {
        setState(() {
          search = value;
        });
      },
      decoration: InputDecoration(
        hintText: 'Buscar amigos...',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget buildErrorState() {
    return _EmptyCard(
      icon: Icons.error_outline,
      title: 'Erro ao carregar amigos',
      description:
          'Verifique se o backend está rodando em http://localhost:3000.\n\n$errorMessage',
    );
  }
}

class _FriendCard extends StatelessWidget {
  final String initials;
  final String name;
  final String? email;
  final String? phone;
  final String? notes;
  final int activeLoans;

  const _FriendCard({
    required this.initials,
    required this.name,
    required this.email,
    required this.phone,
    required this.notes,
    required this.activeLoans,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: AppColors.secondary,
            child: Text(
              initials,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (email != null && email!.trim().isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Text(
                    email!,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 13,
                    ),
                  ),
                ],
                if (phone != null && phone!.trim().isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Text(
                    phone!,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 13,
                    ),
                  ),
                ],
                if (notes != null && notes!.trim().isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Text(
                    notes!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$activeLoans ativos',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _EmptyCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 44,
            color: AppColors.primary,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}