import 'package:flutter/material.dart';
import 'package:mobile_ui/components/my_button.dart';
import 'package:mobile_ui/components/my_text_field.dart';
import 'package:mobile_ui/components/square_tile.dart';
import 'package:mobile_ui/pages/home_page.dart';

class GooglePage extends StatelessWidget {
  GooglePage({super.key});

  // text editing controller
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
          
              // google logo
              const SquareTile(
                imagePath: 'assets/images/google.png',
                height: 100
              ),
          
              const SizedBox(height: 50),
              
              // email
              MyTextField(
                controller: emailController,
                hintText: 'Enter your email',
                obscureText: false
              ),

              const SizedBox(height: 50),

              // confirm button
              MyButton(
                text: 'Confirm',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      )
    );
  }
}