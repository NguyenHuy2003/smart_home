// ignore: depend_on_referenced_packages
// ignore_for_file: sized_box_for_whitespace

// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/auth/auth_gate.dart';
import 'package:smart_home/screen/smart_home_screen.dart';

// Widget chính cho màn hình xác thực Firebase
class FirebaseAuthScreen extends StatefulWidget {
  const FirebaseAuthScreen({super.key});

  @override
  State<FirebaseAuthScreen> createState() => _FirebaseAuthScreenState();
}

class _FirebaseAuthScreenState extends State<FirebaseAuthScreen> {
  final auth = FirebaseAuth.instance; // Tham chiếu đến FirebaseAuth

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              children: [
                // Hiển thị Placeholder nếu chiều rộng màn hình >= 720
                Visibility(
                  visible: constraints.maxWidth >= 720,
                  child: Expanded(
                    child: Container(
                      height: double.infinity,
                      child: const Placeholder(),
                    ),
                  ),
                ),
                // StreamBuilder để lắng nghe trạng thái xác thực của người dùng
                SizedBox(
                  width: constraints.maxWidth >= 720
                      ? constraints.maxWidth / 2
                      : constraints.maxWidth,
                  child: StreamBuilder<User?>(
                    stream: auth.authStateChanges(),
                    builder: (context, snapshot) {
                      // Nếu người dùng đã đăng nhập, chuyển hướng đến SmartHomeScreen
                      if (snapshot.hasData) {
                        return const SmartHomeScreen();
                      }
                      // Nếu chưa đăng nhập, hiển thị AuthGate để đăng nhập hoặc đăng ký
                      return const AuthGate();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
