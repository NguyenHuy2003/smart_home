// ignore: depend_on_referenced_packages
// ignore_for_file: sized_box_for_whitespace

// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/auth/auth_gate.dart';
import 'package:smart_home/screen/smart_home_screen.dart';

class FirebaseAuthScreen extends StatefulWidget {
  const FirebaseAuthScreen({super.key});

  @override
  State<FirebaseAuthScreen> createState() => _FirebaseAuthScreenState();
}

class _FirebaseAuthScreenState extends State<FirebaseAuthScreen> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Visibility(
                visible: constraints.maxWidth >= 720,
                child: Expanded(
                  child: Container(
                    height: double.infinity,
                    child: const Placeholder(),
                  ),
                ),
              ),
              SizedBox(
                width: constraints.maxWidth >= 720
                    ? constraints.maxWidth / 2
                    : constraints.maxWidth,
                child: StreamBuilder<User?>(
                  stream: auth.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return const SmartHomeScreen();
                    }
                    return const AuthGate();
                  },
                ),
              )
            ],
          );
        },
      )),
    );
  }
}
