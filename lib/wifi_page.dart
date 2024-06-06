import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class WiFiPage extends StatefulWidget {
  const WiFiPage({super.key});

  @override
  State<WiFiPage> createState() => _WiFiPageState();
}

class _WiFiPageState extends State<WiFiPage> {
  late DatabaseReference _wifiRef;

  @override
  void initState() {
    super.initState();
    _wifiRef = FirebaseDatabase.instance.ref('PTIOT_DHT');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông Tin WiFi'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<DatabaseEvent>(
          stream: _wifiRef.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                !snapshot.hasError &&
                snapshot.data?.snapshot.value != null) {
              Map<dynamic, dynamic> wifiData =
                  snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
              String ssid = wifiData['WiFi_SSID']!;
              String ip = wifiData['WiFi_IP']!;
              int rssi = wifiData['WiFi_RSSI']!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // SSID Card
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.wifi,
                            size: 48,
                            color: Colors.blueAccent,
                          ),
                          const SizedBox(width: 16.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Tên WiFi (SSID):',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                ssid,
                                style: const TextStyle(fontSize: 18.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // IP Address Card
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.router,
                            size: 48,
                            color: Colors.blueAccent,
                          ),
                          const SizedBox(width: 16.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Địa chỉ IP:',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                ip,
                                style: const TextStyle(fontSize: 18.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // RSSI Card
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.signal_wifi_4_bar,
                            size: 48,
                            color: Colors.blueAccent,
                          ),
                          const SizedBox(width: 16.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Cường độ tín hiệu (RSSI):',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                rssi.toString(),
                                style: const TextStyle(fontSize: 18.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
