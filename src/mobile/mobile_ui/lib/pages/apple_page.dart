import 'package:flutter/material.dart';

class ApplePage extends StatelessWidget {
  const ApplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Apple Page',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      )
    );
  }
}