import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DistanceSensorScreen extends StatefulWidget {
  const DistanceSensorScreen({super.key});

  @override
  State<DistanceSensorScreen> createState() => _DistanceSensorScreenState();
}

class _DistanceSensorScreenState extends State<DistanceSensorScreen> {
  late DatabaseReference _distanceRef;

  @override
  void initState() {
    super.initState();
    _distanceRef = FirebaseDatabase.instance.ref('PTIOT_DHT/Dis');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cảm biến khoảng cách',
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
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: StreamBuilder<DatabaseEvent>(
              stream: _distanceRef.onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    !snapshot.hasError &&
                    snapshot.data?.snapshot.value != null) {
                  double distance = snapshot.data!.snapshot.value is int
                      ? (snapshot.data!.snapshot.value as int).toDouble()
                      : snapshot.data!.snapshot.value as double;
                  return Text(
                    'Khoảng cách từ vật đến cảm biến: $distance cm',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
