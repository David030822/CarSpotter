import 'package:flutter/material.dart';
import 'package:mobile_ui/components/my_button.dart';
import 'package:mobile_ui/components/my_text_field.dart';
import 'package:mobile_ui/components/square_tile.dart';
import 'package:mobile_ui/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GooglePage extends StatelessWidget {
  GooglePage({super.key});

  // text editing controller
  final emailController = TextEditingController();

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signInWithGoogle(BuildContext context) async {
    try{
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if(googleUser == null) //if the user cancels the sign in process
      {
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;  //the authentification details

      final OAuthCredential credential = GoogleAuthProvider.credential(  //new creditential for the firebase auth
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);  //sign in with google credential

        //navigate to HomePage after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } catch (e) {
      print("Error during Google Sign-In: $e");
    }
  }

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
                text: 'Sign in with Google',
                onTap: () {
                 // Navigator.pop(context);
                  //Navigator.push(
                    //context,
                    //MaterialPageRoute(
                      //builder: (context) => HomePage(),
                    //),
                  //);
                  _signInWithGoogle(context); 
                }
              ),
            ],
          ),
        ),
      )
    );
  }
}