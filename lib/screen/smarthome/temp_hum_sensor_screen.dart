import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// Định nghĩa màn hình cảm biến nhiệt độ và độ ẩm
class TempHumSensorScreen extends StatefulWidget {
  const TempHumSensorScreen({super.key});

  @override
  State<TempHumSensorScreen> createState() => _TempHumSensorScreenState();
}

// Định nghĩa trạng thái của màn hình cảm biến nhiệt độ và độ ẩm
class _TempHumSensorScreenState extends State<TempHumSensorScreen> {
  // Khai báo các tham chiếu đến cơ sở dữ liệu Firebase cho nhiệt độ và độ ẩm
  late DatabaseReference _temperatureRef;
  late DatabaseReference _humidityRef;

  // Phương thức khởi tạo
  @override
  void initState() {
    super.initState();
    // Khởi tạo các tham chiếu đến đường dẫn tương ứng của nhiệt độ và độ ẩm trong Firebase
    _temperatureRef = FirebaseDatabase.instance.ref('PTIOT_DHT/Temp');
    _humidityRef = FirebaseDatabase.instance.ref('PTIOT_DHT/hum');
  }

  // Xây dựng giao diện của màn hình
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
            // Card hiển thị nhiệt độ
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: StreamBuilder<DatabaseEvent>(
                  stream: _temperatureRef.onValue,
                  builder: (context, snapshot) {
                    // Kiểm tra xem có dữ liệu hay không
                    if (snapshot.hasData &&
                        !snapshot.hasError &&
                        snapshot.data?.snapshot.value != null) {
                      // Lấy giá trị nhiệt độ từ dữ liệu Firebase
                      double temperature = snapshot.data!.snapshot.value is int
                          ? (snapshot.data!.snapshot.value as int).toDouble()
                          : snapshot.data!.snapshot.value as double;
                      // Hiển thị nhiệt độ lên màn hình
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
                      // Hiển thị vòng tròn tiến trình khi đang tải dữ liệu
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Card hiển thị độ ẩm
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: StreamBuilder<DatabaseEvent>(
                  stream: _humidityRef.onValue,
                  builder: (context, snapshot) {
                    // Kiểm tra xem có dữ liệu hay không
                    if (snapshot.hasData &&
                        !snapshot.hasError &&
                        snapshot.data?.snapshot.value != null) {
                      // Lấy giá trị độ ẩm từ dữ liệu Firebase
                      double humidity = snapshot.data!.snapshot.value is int
                          ? (snapshot.data!.snapshot.value as int).toDouble()
                          : snapshot.data!.snapshot.value as double;
                      // Hiển thị độ ẩm lên màn hình
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
                      // Hiển thị vòng tròn tiến trình khi đang tải dữ liệu
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
