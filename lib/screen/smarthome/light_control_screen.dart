import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// Định nghĩa màn hình điều khiển đèn
class LightControlScreen extends StatefulWidget {
  const LightControlScreen({super.key});

  @override
  State<LightControlScreen> createState() => _LightControlScreenState();
}

// Định nghĩa trạng thái của màn hình điều khiển đèn
class _LightControlScreenState extends State<LightControlScreen> {
  // Khai báo các tham chiếu đến cơ sở dữ liệu Firebase cho từng đèn
  late DatabaseReference _light1Ref;
  late DatabaseReference _light4Ref;
  late DatabaseReference _light5Ref;
  late DatabaseReference _light6Ref;

  // Phương thức khởi tạo
  @override
  void initState() {
    super.initState();
    // Khởi tạo các tham chiếu đến đường dẫn tương ứng của các đèn trong Firebase
    _light1Ref = FirebaseDatabase.instance.ref('PTIOT_DHT/LED_01');
    _light4Ref = FirebaseDatabase.instance.ref('PTIOT_DHT/LED_04');
    _light5Ref = FirebaseDatabase.instance.ref('PTIOT_DHT/LED_05');
    _light6Ref = FirebaseDatabase.instance.ref('PTIOT_DHT/LED_06');
  }

  // Phương thức chuyển đổi trạng thái đèn
  void _toggleLight(DatabaseReference lightRef, bool value) {
    lightRef.set(value ? 1 : 0); // Cập nhật giá trị trong Firebase
  }

  // Xây dựng giao diện của màn hình
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
            // Card điều khiển đèn 1
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
                    // Sử dụng StreamBuilder để lắng nghe thay đổi dữ liệu từ Firebase
                    StreamBuilder<DatabaseEvent>(
                      stream: _light1Ref.onValue,
                      builder: (context, snapshot) {
                        // Kiểm tra xem có dữ liệu hay không
                        if (snapshot.hasData &&
                            !snapshot.hasError &&
                            snapshot.data?.snapshot.value != null) {
                          bool isLightOn =
                              (snapshot.data!.snapshot.value as int) == 1;
                          // Hiển thị công tắc chuyển đổi trạng thái đèn
                          return Switch(
                            value: isLightOn,
                            onChanged: (value) =>
                                _toggleLight(_light1Ref, value),
                          );
                        } else {
                          // Hiển thị vòng tròn tiến trình khi đang tải dữ liệu
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Card điều khiển đèn 4
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
                    // Sử dụng StreamBuilder để lắng nghe thay đổi dữ liệu từ Firebase
                    StreamBuilder<DatabaseEvent>(
                      stream: _light4Ref.onValue,
                      builder: (context, snapshot) {
                        // Kiểm tra xem có dữ liệu hay không
                        if (snapshot.hasData &&
                            !snapshot.hasError &&
                            snapshot.data?.snapshot.value != null) {
                          bool isLightOn =
                              (snapshot.data!.snapshot.value as int) == 1;
                          // Hiển thị công tắc chuyển đổi trạng thái đèn
                          return Switch(
                            value: isLightOn,
                            onChanged: (value) =>
                                _toggleLight(_light4Ref, value),
                          );
                        } else {
                          // Hiển thị vòng tròn tiến trình khi đang tải dữ liệu
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Card điều khiển đèn 5
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
                    // Sử dụng StreamBuilder để lắng nghe thay đổi dữ liệu từ Firebase
                    StreamBuilder<DatabaseEvent>(
                      stream: _light5Ref.onValue,
                      builder: (context, snapshot) {
                        // Kiểm tra xem có dữ liệu hay không
                        if (snapshot.hasData &&
                            !snapshot.hasError &&
                            snapshot.data?.snapshot.value != null) {
                          bool isLightOn =
                              (snapshot.data!.snapshot.value as int) == 1;
                          // Hiển thị công tắc chuyển đổi trạng thái đèn
                          return Switch(
                            value: isLightOn,
                            onChanged: (value) =>
                                _toggleLight(_light5Ref, value),
                          );
                        } else {
                          // Hiển thị vòng tròn tiến trình khi đang tải dữ liệu
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Card điều khiển đèn 6
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
                    // Sử dụng StreamBuilder để lắng nghe thay đổi dữ liệu từ Firebase
                    StreamBuilder<DatabaseEvent>(
                      stream: _light6Ref.onValue,
                      builder: (context, snapshot) {
                        // Kiểm tra xem có dữ liệu hay không
                        if (snapshot.hasData &&
                            !snapshot.hasError &&
                            snapshot.data?.snapshot.value != null) {
                          bool isLightOn =
                              (snapshot.data!.snapshot.value as int) == 1;
                          // Hiển thị công tắc chuyển đổi trạng thái đèn
                          return Switch(
                            value: isLightOn,
                            onChanged: (value) =>
                                _toggleLight(_light6Ref, value),
                          );
                        } else {
                          // Hiển thị vòng tròn tiến trình khi đang tải dữ liệu
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
