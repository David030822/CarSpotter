import 'package:flutter/material.dart';
import 'package:mobile_ui/components/my_button.dart';
import 'package:mobile_ui/components/my_text_field.dart';
import 'package:mobile_ui/pages/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: true,  // This helps in automatically resizing the body to avoid the keyboard
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      
                      // logo
                      const Icon(
                        Icons.app_registration,
                        size: 100,
                      ),
                      
                      const SizedBox(height: 50),
                      
                      // welcome message
                      Text(
                        'Let\'s create an account for you!',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 16,
                        ),
                      ),
                      
                      const SizedBox(height: 25),
                      
                      // first name
                      MyTextField(
                        controller: firstNameController,
                        hintText: 'First Name',
                        obscureText: false,
                      ),
                      
                      const SizedBox(height: 10),
                      
                      // last name
                      MyTextField(
                        controller: lastNameController,
                        hintText: 'Last Name',
                        obscureText: false,
                      ),
                      
                      const SizedBox(height: 10),
                      
                      // email
                      MyTextField(
                        controller: emailController,
                        hintText: 'Email',
                        obscureText: false,
                      ),
                      
                      const SizedBox(height: 10),
                      
                      // username textfield
                      MyTextField(
                        controller: usernameController,
                        hintText: 'Username',
                        obscureText: false,
                      ),
                      
                      const SizedBox(height: 10),
                      
                      // password textfield
                      MyTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                      ),
                      
                      const SizedBox(height: 10),
                      
                      // confirm password
                      MyTextField(
                        controller: confirmPasswordController,
                        hintText: 'Confirm Password',
                        obscureText: true,
                      ),
                      
                      const SizedBox(height: 25),
                      
                      // register now button
                      MyButton(
                        text: 'Register Now',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}