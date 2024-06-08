import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TempHumSensorScreen extends StatefulWidget {
  const TempHumSensorScreen({super.key});

  @override
  State<TempHumSensorScreen> createState() => _TempHumSensorScreenState();
}

class _TempHumSensorScreenState extends State<TempHumSensorScreen> {
  late DatabaseReference _temperatureRef;
  late DatabaseReference _humidityRef;

  @override
  void initState() {
    super.initState();
    _temperatureRef = FirebaseDatabase.instance.ref('PTIOT_DHT/Temp');
    _humidityRef = FirebaseDatabase.instance.ref('PTIOT_DHT/hum');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nhiệt Độ & Độ Ẩm',
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
            // Temperature Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: StreamBuilder<DatabaseEvent>(
                  stream: _temperatureRef.onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        !snapshot.hasError &&
                        snapshot.data?.snapshot.value != null) {
                      double temperature = snapshot.data!.snapshot.value is int
                          ? (snapshot.data!.snapshot.value as int).toDouble()
                          : snapshot.data!.snapshot.value as double;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Nhiệt độ hiện tại:',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            '$temperature°C',
                            style: const TextStyle(fontSize: 18.0),
                          ),
                        ],
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Humidity Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: StreamBuilder<DatabaseEvent>(
                  stream: _humidityRef.onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        !snapshot.hasError &&
                        snapshot.data?.snapshot.value != null) {
                      double humidity = snapshot.data!.snapshot.value is int
                          ? (snapshot.data!.snapshot.value as int).toDouble()
                          : snapshot.data!.snapshot.value as double;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Độ ẩm hiện tại:',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            '$humidity%',
                            style: const TextStyle(fontSize: 18.0),
                          ),
                        ],
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
