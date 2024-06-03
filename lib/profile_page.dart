// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Column(
        children: [
          Text(
            auth.currentUser?.email ?? 'N/A',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          FilledButton.tonalIcon(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
            label: const Text('Sign Out'),
          )
        ],
      ),
    );
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
