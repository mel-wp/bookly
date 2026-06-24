import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../core/mock_data.dart';
import '../widgets/app_bottom_navigation.dart';
import '../widgets/app_header.dart';
import '../widgets/empty_state.dart';
import '../widgets/statistic_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: 'Perfil e Estatísticas'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: const [
            _ProfileHeader(),
            SizedBox(height: 16),
            Row(
              children: [
                StatisticCard(
                  value: '${MockData.totalBooks}',
                  label: 'Livros',
                  color: AppTheme.primary,
                ),
                SizedBox(width: 8),
                StatisticCard(
                  value: '${MockData.returnedLoans}',
                  label: 'Devolvidos',
                  color: AppTheme.success,
                ),
                SizedBox(width: 8),
                StatisticCard(
                  value: '${MockData.pendingLoans}',
                  label: 'Pendentes',
                  color: AppTheme.warning,
                ),
                SizedBox(width: 8),
                StatisticCard(
                  value: '${MockData.lateLoans}',
                  label: 'Atrasados',
                  color: AppTheme.danger,
                ),
              ],
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Histórico de Empréstimos',
                style: TextStyle(
                  color: AppTheme.title,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            EmptyState(
              message: 'Nenhum histórico disponível.',
              icon: Icons.bar_chart,
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Últimos empréstimos',
                style: TextStyle(
                  color: AppTheme.title,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            EmptyState(
              message: 'Nenhum empréstimo recente.',
              icon: Icons.history,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 3),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 42,
                backgroundColor: Colors.white,
                child: Text(
                  'CP',
                  style: TextStyle(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 28,
                  width: 28,
                  decoration: const BoxDecoration(
                    color: AppTheme.success,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Clara Paludo',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          const Text(
            'Leitora desde 2022',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
