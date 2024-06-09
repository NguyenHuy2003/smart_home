import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'auth/firebase_auth_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Đảm bảo Flutter được khởi tạo trước khi chạy bất kỳ mã nào
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Khởi tạo Firebase với các tùy chọn nền tảng hiện tại
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Tắt banner debug
      home: FirebaseAuthScreen(), // Màn hình chính của ứng dụng
    );
  }
}
