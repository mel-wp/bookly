import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../widgets/app_header.dart';
import '../widgets/primary_button.dart';

class NewLoanPage extends StatefulWidget {
  const NewLoanPage({super.key});

  @override
  State<NewLoanPage> createState() => _NewLoanPageState();
}

class _NewLoanPageState extends State<NewLoanPage> {
  int currentStep = 0;

  void nextStep() {
    if (currentStep < 3) {
      setState(() {
        currentStep++;
      });
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: 'Novo Empréstimo', showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            _LoanStepper(currentStep: currentStep),
            const SizedBox(height: 24),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: _StepContent(
                  key: ValueKey(currentStep),
                  step: currentStep,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    text: 'Voltar',
                    outlined: true,
                    onPressed: previousStep,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PrimaryButton(
                    text: currentStep == 3 ? 'Finalizar' : 'Próximo',
                    onPressed: nextStep,
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

class _LoanStepper extends StatelessWidget {
  final int currentStep;

  const _LoanStepper({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final steps = ['Amigo', 'Livro', 'Prazo', 'Foto'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(steps.length, (index) {
        final bool active = index <= currentStep;

        return Column(
          children: [
            CircleAvatar(
              radius: 17,
              backgroundColor: active ? AppTheme.primary : Colors.grey.shade300,
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: active ? Colors.white : Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              steps[index],
              style: TextStyle(
                fontSize: 11,
                color: active ? AppTheme.primary : AppTheme.textLight,
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _StepContent extends StatelessWidget {
  final int step;

  const _StepContent({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    switch (step) {
      case 0:
        return const _EmptyStepCard(
          icon: Icons.person_outline,
          title: 'Selecionar amigo',
          description: 'Nenhum amigo cadastrado para selecionar.',
        );
      case 1:
        return const _EmptyStepCard(
          icon: Icons.menu_book_outlined,
          title: 'Selecionar livro',
          description: 'Nenhum livro cadastrado para selecionar.',
        );
      case 2:
        return const _DeadlineStep();
      case 3:
        return const _PhotoStep();
      default:
        return const SizedBox();
    }
  }
}

class _EmptyStepCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _EmptyStepCard({
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
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 52, color: AppTheme.primary),
          const SizedBox(height: 12),
          Text(title, style: AppTheme.title),
          const SizedBox(height: 6),
          Text(
            description,
            textAlign: TextAlign.center,
            style: AppTheme.subtitle,
          ),
        ],
      ),
    );
  }
}

class _DeadlineStep extends StatelessWidget {
  const _DeadlineStep();

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
        firstDate: DateTime.now(),
        lastDate: DateTime(2035),
        onDateChanged: (date) {},
      ),
    );
  }
}

class _PhotoStep extends StatelessWidget {
  const _PhotoStep();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 130,
            width: 130,
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.border),
            ),
            child: const Icon(
              Icons.camera_alt_outlined,
              size: 52,
              color: AppTheme.primary,
            ),
          ),
          const SizedBox(height: 14),
          const Text('Adicionar foto do livro', style: AppTheme.title),
          const SizedBox(height: 6),
          const Text(
            'A função de câmera será conectada depois.',
            textAlign: TextAlign.center,
            style: AppTheme.subtitle,
          ),
        ],
      ),
    );
  }
}
