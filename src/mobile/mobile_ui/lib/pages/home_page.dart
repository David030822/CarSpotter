import 'package:flutter/material.dart';
import 'package:mobile_ui/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: MyDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Home Page',
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