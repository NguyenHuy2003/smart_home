import 'package:flutter/material.dart';
import 'package:smart_home/screen/smarthome/light_control_screen.dart';
import 'package:smart_home/screen/smarthome/temp_hum_sensor_screen.dart';

import 'profile_page.dart';
import 'smarthome/distance_sensor_screen.dart';
import 'smarthome/wifi_screen.dart'; // Import WiFiPage

class SmartHomeScreen extends StatelessWidget {
  const SmartHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nhà Thông Minh',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            color: Colors.blue,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
            icon: const Icon(Icons.account_circle),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(deviceList.length, (index) {
                  return DeviceCard(device: deviceList[index]);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Device {
  final String name;
  final IconData icon;
  final Widget page; // Add this field

  Device({required this.name, required this.icon, required this.page});
}

class DeviceCard extends StatelessWidget {
  final Device device;

  const DeviceCard({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {
          // Navigate to the specific page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => device.page),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(device.icon, size: 48, color: Colors.blue),
            const SizedBox(height: 10),
            Text(device.name, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

final List<Device> deviceList = [
  Device(
      name: 'Đèn',
      icon: Icons.lightbulb_outline,
      page: const LightControlScreen()),
  Device(
      name: 'Nhiệt - Ẩm',
      icon: Icons.thermostat,
      page: const TempHumSensorScreen()),
  Device(name: 'Wifi', icon: Icons.wifi, page: const WiFiPage()),
  Device(
      name: 'Khoảng Cách',
      icon: Icons.social_distance,
      page: const DistanceSensorScreen()),
];
