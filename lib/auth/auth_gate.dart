// ignore: depend_on_referenced_packages
// ignore_for_file: avoid_print

// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/screen/smart_home_screen.dart';

// Enum để xác định chế độ đăng nhập hoặc đăng ký
enum AuthMode { login, register }

// Extension để lấy tiêu đề dựa trên chế độ hiện tại
extension on AuthMode {
  String get title => this == AuthMode.login ? 'Đăng nhập' : 'Đăng ký';
}

// Widget chính cho việc đăng nhập và đăng ký
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  var mode = AuthMode.login; // Chế độ hiện tại (đăng nhập hoặc đăng ký)
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>(); // Khóa cho form
  final auth = FirebaseAuth.instance; // Tham chiếu đến FirebaseAuth

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mode.title),
      ),
      body: mode == AuthMode.register
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.email_outlined),
                              label: Text('Email'),
                            ),
                            validator: (value) =>
                                value != null && value.isNotEmpty
                                    ? null
                                    : 'Required',
                          ),
                          TextFormField(
                            controller: passwordController,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.security_rounded),
                              label: Text('Mật khẩu'),
                            ),
                            obscureText: true,
                            validator: (value) =>
                                value != null && value.isNotEmpty
                                    ? null
                                    : 'Required',
                          ),
                          const SizedBox(height: 16.0),
                          Center(
                            child: FilledButton(
                              onPressed: register,
                              child: const Text('Đăng ký'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Text('Bạn đã có tài khoản?'),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        mode = AuthMode.login;
                      });
                    },
                    child: const Text('Đăng nhập'),
                  ),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.email_outlined),
                              label: Text('Email'),
                            ),
                            validator: (value) =>
                                value != null && value.isNotEmpty
                                    ? null
                                    : 'Required',
                          ),
                          TextFormField(
                            controller: passwordController,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.security_rounded),
                              label: Text('Mật khẩu'),
                            ),
                            obscureText: true,
                            validator: (value) =>
                                value != null && value.isNotEmpty
                                    ? null
                                    : 'Required',
                          ),
                          const SizedBox(height: 16.0),
                          Center(
                            child: FilledButton(
                              onPressed: login,
                              child: const Text('Đăng nhập'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Text('Bạn chưa có tài khoản?'),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        mode = AuthMode.register;
                      });
                    },
                    child: const Text('Đăng ký'),
                  ),
                ],
              ),
            ),
    );
  }

  // Hàm xử lý đăng ký người dùng
  Future<void> register() async {
    print('Thực hiện chức năng đăng ký người dùng');
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    if (formKey.currentState!.validate()) {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    }
  }

  // Hàm xử lý đăng nhập người dùng
  Future<void> login() async {
    print('Thực hiện chức năng đăng nhập');
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    if (formKey.currentState!.validate()) {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    }
    // Sau khi đăng nhập thành công, chuyển hướng đến trang chính
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SmartHomeScreen()),
    );
  }
}
