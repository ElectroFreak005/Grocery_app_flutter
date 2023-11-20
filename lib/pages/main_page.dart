import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app_flutter/pages/auth_page.dart';
import 'package:grocery_app_flutter/pages/intro_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData)
            {
              return const IntroPage();
            }
          else
            {
              return AuthPage();
            }
        },
      ),
    );
  }
}
