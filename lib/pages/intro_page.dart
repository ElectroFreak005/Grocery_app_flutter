import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app_flutter/pages/login_page.dart';

import 'home_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent,
      body: Column(
        children: [
          //logo
          Padding(
            padding: const EdgeInsets.only(
                left: 60.0, right: 80.0, bottom: 50.0, top: 70.0),
            child: Image.asset('images/app_icon.png'),
          ),
          //description text
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              'Manage your Grocery list easily now!!',
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSerif(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'All grocery items available',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600],
            ),
          ),
          const Spacer(),
          //get started button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => FirebaseAuth.instance.signOut(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: const Text(
                    ' Sign Out ',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
