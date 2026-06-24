import 'package:flutter/material.dart';

import '../widgets/app_header.dart';
import '../widgets/empty_state.dart';
import '../widgets/primary_button.dart';

class LoanDetailPage extends StatelessWidget {
  const LoanDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(
        title: 'Detalhe do Empréstimo',
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            const Expanded(
              child: Center(
                child: EmptyState(
                  message: 'Nenhum empréstimo selecionado.',
                  icon: Icons.info_outline,
                ),
              ),
            ),
            PrimaryButton(text: 'Marcar como devolvido', onPressed: () {}),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    text: 'Lembrete',
                    outlined: true,
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: PrimaryButton(
                    text: 'Editar',
                    outlined: true,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
