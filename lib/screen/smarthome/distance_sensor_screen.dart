import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// Định nghĩa màn hình cảm biến khoảng cách
class DistanceSensorScreen extends StatefulWidget {
  const DistanceSensorScreen({super.key});

  @override
  State<DistanceSensorScreen> createState() => _DistanceSensorScreenState();
}

// Định nghĩa trạng thái của màn hình cảm biến khoảng cách
class _DistanceSensorScreenState extends State<DistanceSensorScreen> {
  // Khai báo tham chiếu đến cơ sở dữ liệu Firebase
  late DatabaseReference _distanceRef;

  // Phương thức khởi tạo
  @override
  void initState() {
    super.initState();
    // Khởi tạo tham chiếu đến đường dẫn 'PTIOT_DHT/Dis' trong Firebase
    _distanceRef = FirebaseDatabase.instance.ref('PTIOT_DHT/Dis');
  }

  // Xây dựng giao diện của màn hình
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
            // Sử dụng StreamBuilder để lắng nghe thay đổi dữ liệu từ Firebase
            child: StreamBuilder<DatabaseEvent>(
              stream: _distanceRef.onValue,
              builder: (context, snapshot) {
                // Kiểm tra xem có dữ liệu hay không
                if (snapshot.hasData &&
                    !snapshot.hasError &&
                    snapshot.data?.snapshot.value != null) {
                  // Lấy giá trị khoảng cách từ dữ liệu Firebase
                  double distance = snapshot.data!.snapshot.value is int
                      ? (snapshot.data!.snapshot.value as int).toDouble()
                      : snapshot.data!.snapshot.value as double;
                  // Hiển thị khoảng cách lên màn hình
                  return Text(
                    'Khoảng cách từ vật đến cảm biến: $distance cm',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                } else {
                  // Hiển thị vòng tròn tiến trình khi đang tải dữ liệu
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
