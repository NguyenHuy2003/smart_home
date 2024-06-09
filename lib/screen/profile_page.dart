import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/auth/firebase_auth_screen.dart';

// Định nghĩa màn hình hồ sơ người dùng
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

// Định nghĩa trạng thái của màn hình hồ sơ người dùng
class _ProfilePageState extends State<ProfilePage> {
  // Khai báo biến `auth` để truy cập Firebase Authentication
  final auth = FirebaseAuth.instance;

  // Xây dựng giao diện của màn hình
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hồ Sơ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Hiển thị ảnh đại diện của người dùng
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(auth.currentUser?.photoURL ??
                    'https://cdn.iconscout.com/icon/free/png-256/free-account-269-866236.png'),
              ),
              const SizedBox(height: 16),
              // Hiển thị tên của người dùng
              Text(
                auth.currentUser?.displayName ?? 'Hồ Sơ',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // Hiển thị email của người dùng
              Text(
                auth.currentUser?.email ?? 'N/A',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 40),
              // Nút đăng xuất
              FilledButton.tonalIcon(
                onPressed: signOut,
                icon: const Icon(Icons.logout),
                label: const Text('Sign Out'),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Phương thức đăng xuất người dùng
  Future<void> signOut() async {
    await auth.signOut();
    // Chuyển hướng người dùng về màn hình đăng nhập sau khi đăng xuất
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const FirebaseAuthScreen(),
      ),
    );
  }
}
