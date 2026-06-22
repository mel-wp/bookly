import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../widgets/app_bottom_navigation.dart';
import '../widgets/app_header.dart';
import '../widgets/empty_state.dart';
import '../widgets/status_chip.dart';

class DeadlinesPage extends StatelessWidget {
  const DeadlinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: 'Prazos e Devoluções'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CalendarCard(),
            const SizedBox(height: 12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StatusChip(text: 'Pendente', color: AppTheme.warning),
                StatusChip(text: 'Atrasado', color: AppTheme.danger),
                StatusChip(text: 'Devolvido', color: AppTheme.success),
                StatusChip(text: 'Hoje', color: AppTheme.today),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Próximas devoluções', style: AppTheme.title),
            const SizedBox(height: 10),
            const EmptyState(
              message: 'Nenhuma devolução próxima.',
              icon: Icons.event_available_outlined,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 2),
    );
  }
}

class _CalendarCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.border),
      ),
      child: CalendarDatePicker(
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2035),
        onDateChanged: (date) {},
      ),
    );
  }
}
