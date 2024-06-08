import 'package:flutter/material.dart';
import 'package:smart_home/auth/firebase_auth_screen.dart'; // Đây là trang đăng nhập của bạn

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoggedIn = false; // Biến để theo dõi trạng thái đăng nhập

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Xin chào!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Điều hướng sang trang đăng nhập khi nhấn nút "Đăng nhập"
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FirebaseAuthScreen()),
                ).then((value) {
                  // Hàm được gọi khi trang đăng nhập đóng lại
                  setState(() {
                    // Cập nhật trạng thái đăng nhập
                    isLoggedIn = value ??
                        false; // Giá trị value là true nếu đăng nhập thành công, ngược lại là false
                  });
                });
              },
              child: const Text('Đăng nhập'),
            ),
          ],
        ),
      ),
    );
  }
}
