import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeService {
  static const String controlUrl =
      'https://api.netpie.io/v2/device/message?topic=home/device_control';
  static const String statusUrl = 'https://api.netpie.io/v2/device/shadow/data';

  // สำหรับการควบคุมหลอดไฟ (setLedStatus)
  static const String controlClientId = "R6cXcT2cj7bqAcfoeJZ8uSceKHvGtfz1"; // of Mobile App"";
  static const String controlToken = "dXL1YZqRbzceN4yznCzfVXZxCQGcPyHV"; // of Mobile App

  // สำหรับการอ่านสถานะหลอดไฟ (getLedStatus)
  static const String statusClientId = "3ee18b4b-fbbf-47d9-b94d-486ee5480e6d";  // of ESP32
  static const String statusToken = "KKio91FUWqHE5uYMWq9hksCDznzLTN7K";  // of ESP32

  Map<String, String> get _controlHeaders => {
    'Content-Type': 'application/json',
    'Authorization': 'Device $controlClientId:$controlToken',
  };

  Map<String, String> get _statusHeaders => {
    'Content-Type': 'application/json',
    'Authorization': 'Device $statusClientId:$statusToken',
  };

  Future<bool> getLedStatus() async {
    final response = await http.get(
      Uri.parse(statusUrl),
      headers: _statusHeaders,
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['led1'] == 1;
    } else {
      throw Exception('Failed to fetch LED status');
    }
  }

  Future<void> setLedStatus(bool isOn) async {
    final payload = json.encode({
      'data': {'led1': isOn ? 1 : 0},
    });
    final response = await http.put(
      Uri.parse(controlUrl),
      headers: _controlHeaders,
      body: payload,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to send LED command');
    }
  }

  Future<Map<String, bool>> getDeviceStatus() async {
    try {
      final response = await http.get(
        Uri.parse(statusUrl),
        headers: _statusHeaders,
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final deviceData = data['data'] ?? {};
        return {
          'led1': (deviceData['led1'] ?? 0) == 1,
          'led2': (deviceData['led2'] ?? 0) == 1,
          'led3': (deviceData['led3'] ?? 0) == 1,
          'speaker': (deviceData['speaker'] ?? 0) == 1,
        };
      } else {
        throw Exception('Failed to fetch device status');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setDevice(String device, bool value) async {
    final payload = json.encode({
      'data': {device: value ? 1 : 0},
    });
    final response = await http.put(
      Uri.parse(controlUrl),
      headers: _controlHeaders,
      body: payload,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to send command for $device');
    }
  }
}
