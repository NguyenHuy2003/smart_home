import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class LightControlScreen extends StatefulWidget {
  const LightControlScreen({super.key});

  @override
  State<LightControlScreen> createState() => _LightControlScreenState();
}

class _LightControlScreenState extends State<LightControlScreen> {
  late DatabaseReference _light1Ref;
  late DatabaseReference _light4Ref;
  late DatabaseReference _light5Ref;
  late DatabaseReference _light6Ref;

  @override
  void initState() {
    super.initState();
    _light1Ref = FirebaseDatabase.instance.ref('PTIOT_DHT/LED_01');
    _light4Ref = FirebaseDatabase.instance.ref('PTIOT_DHT/LED_04');
    _light5Ref = FirebaseDatabase.instance.ref('PTIOT_DHT/LED_05');
    _light6Ref = FirebaseDatabase.instance.ref('PTIOT_DHT/LED_06');
  }

  void _toggleLight(DatabaseReference lightRef, bool value) {
    lightRef.set(value ? 1 : 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Điểu Khiển Đèn',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Light Switch Card 1
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Đèn 1:',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    StreamBuilder<DatabaseEvent>(
                      stream: _light1Ref.onValue,
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            !snapshot.hasError &&
                            snapshot.data?.snapshot.value != null) {
                          bool isLightOn =
                              (snapshot.data!.snapshot.value as int) == 1;
                          return Switch(
                            value: isLightOn,
                            onChanged: (value) =>
                                _toggleLight(_light1Ref, value),
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Light Switch Card 2
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Đèn 4:',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    StreamBuilder<DatabaseEvent>(
                      stream: _light4Ref.onValue,
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            !snapshot.hasError &&
                            snapshot.data?.snapshot.value != null) {
                          bool isLightOn =
                              (snapshot.data!.snapshot.value as int) == 1;
                          return Switch(
                            value: isLightOn,
                            onChanged: (value) =>
                                _toggleLight(_light4Ref, value),
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Light Switch Card 3
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Đèn 5:',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    StreamBuilder<DatabaseEvent>(
                      stream: _light5Ref.onValue,
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            !snapshot.hasError &&
                            snapshot.data?.snapshot.value != null) {
                          bool isLightOn =
                              (snapshot.data!.snapshot.value as int) == 1;
                          return Switch(
                            value: isLightOn,
                            onChanged: (value) =>
                                _toggleLight(_light5Ref, value),
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Light Switch Card 4
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Đèn 6:',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    StreamBuilder<DatabaseEvent>(
                      stream: _light6Ref.onValue,
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            !snapshot.hasError &&
                            snapshot.data?.snapshot.value != null) {
                          bool isLightOn =
                              (snapshot.data!.snapshot.value as int) == 1;
                          return Switch(
                            value: isLightOn,
                            onChanged: (value) =>
                                _toggleLight(_light6Ref, value),
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
