import 'package:auth_flutter/components/my_button.dart';
import 'package:auth_flutter/components/my_textfield.dart';
import 'package:auth_flutter/components/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async {

    showDialog(context: context, builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, 
        password: passwordController.text
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      print("Error:" + e.code);
      showDialog(context: context, builder: (context) {
        return const AlertDialog(title: Text("Error"));
      });

      // if (e.code == 'user-not-found'){
      //   print("cORREO NO ENCONTRADO");
      //   wrongEmailMessage();
      // }else if (e.code == 'wrong-password'){
      //   print("CONTRASENA NO ENCONTRADO");
      //   wrongPasswordMessage();
      // }
    }
  }

  // void wrongEmailMessage() {
  //   showDialog(context: context, builder: (context) {
  //     return const AlertDialog(title: Text("Incorrect email"));
  //   });
  // }

  // void wrongPasswordMessage() {
  //   showDialog(context: context, builder: (context) {
  //     return const AlertDialog(title: Text("Incorrect password"));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),

              const Icon(
                Icons.lock,
                size: 48,
              ),

              const SizedBox(height: 30),

              Text(
                "Welcome back you\'ve been missed",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16
                ),
              ),

              const SizedBox(height: 25),

              MytextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              MytextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.grey[600])
                    ),  
                  ],
                )
              ),

              const SizedBox(height: 25),

              MyButton(
                onTap: signUserIn,
              ),

              const SizedBox(height: 30),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400]
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700])
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400]
                      ),
                    ),
                  ],
                )
              ),

              const SizedBox(height: 25),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(imagePath: 'lib/images/google.png'),
                  SizedBox(width: 25),
                  SquareTile(imagePath: 'lib/images/github.png'),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}