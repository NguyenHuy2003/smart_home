import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// Định nghĩa màn hình thông tin WiFi
class WiFiPage extends StatefulWidget {
  const WiFiPage({super.key});

  @override
  State<WiFiPage> createState() => _WiFiPageState();
}

// Định nghĩa trạng thái của màn hình thông tin WiFi
class _WiFiPageState extends State<WiFiPage> {
  // Khai báo tham chiếu đến cơ sở dữ liệu Firebase cho thông tin WiFi
  late DatabaseReference _wifiRef;

  // Phương thức khởi tạo
  @override
  void initState() {
    super.initState();
    // Khởi tạo tham chiếu đến đường dẫn thông tin WiFi trong Firebase
    _wifiRef = FirebaseDatabase.instance.ref('PTIOT_DHT');
  }

  // Xây dựng giao diện của màn hình
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông Tin WiFi',
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
        child: StreamBuilder<DatabaseEvent>(
          // Lắng nghe sự thay đổi dữ liệu từ Firebase
          stream: _wifiRef.onValue,
          builder: (context, snapshot) {
            // Kiểm tra xem có dữ liệu hay không
            if (snapshot.hasData &&
                !snapshot.hasError &&
                snapshot.data?.snapshot.value != null) {
              // Lấy dữ liệu WiFi từ Firebase
              Map<dynamic, dynamic> wifiData =
                  snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
              String ssid = wifiData['WiFi_SSID']!;
              String ip = wifiData['WiFi_IP']!;
              int rssi = wifiData['WiFi_RSSI']!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Card hiển thị tên WiFi (SSID)
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(
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
                  // Card hiển thị địa chỉ IP
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(
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
                  // Card hiển thị cường độ tín hiệu (RSSI)
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(
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
              // Hiển thị vòng tròn tiến trình khi đang tải dữ liệu
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
