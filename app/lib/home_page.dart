import 'dart:async';
import 'package:flutter/material.dart';
import 'home_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeService _service = HomeService();

  bool _led1 = false;
  bool _led2 = false;
  bool _led3 = false;
  bool _speaker = false; 

  bool _isLoading = true;
  Timer? _pollingTimer;

  @override
  void initState() {
    super.initState();
    _loadDeviceStatus();
    _startPolling();
  }

  void _startPolling() {
    _pollingTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      _loadDeviceStatus();
    });
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadDeviceStatus() async {
    try {
      final status = await _service.getDeviceStatus();
      setState(() {
        _led1 = status['led1'] ?? false;
        _led2 = status['led2'] ?? false;
        _led3 = status['led3'] ?? false;
        _speaker = status['speaker'] ?? false; 
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  // 🎮 สั่งงานอุปกรณ์
  Future<void> _toggleDevice(String device, bool value) async {
    setState(() {
      if (device == 'led1') _led1 = value;
      if (device == 'led2') _led2 = value;
      if (device == 'led3') _led3 = value;
      if (device == 'speaker') _speaker = value; 
    });

    await _service.setDevice(device, value);
  }

  Widget _ledWidget(String title, bool value, String device, Color color) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              color.withOpacity(value ? 1.0 : 0.3),
              BlendMode.multiply,
            ),
            child: Image.asset(
              value ? 'assets/led-on.png' : 'assets/led-off.png',
              width: 100,
            ),
          ),
          Switch(
            value: value,
            activeColor: Colors.amber,
            onChanged: (v) => _toggleDevice(device, v),
          ),
        ],
      ),
    );
  }

  // 🔊 Speaker
  Widget _speakerWidget() {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          const Text(
            'Speaker',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Icon(
            Icons.volume_up,
            color: _speaker ? Colors.red : Colors.grey,
            size: 60,
          ),
          Switch(
            value: _speaker,
            activeColor: Colors.red,
            onChanged: (v) => _toggleDevice('speaker', v),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Device Controller'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _ledWidget('RED', _led1, 'led1', Colors.red),
                        _ledWidget('YELLOW', _led2, 'led2', Colors.amber),
                        _ledWidget('GREEN', _led3, 'led3', Colors.green),
                        _speakerWidget(),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
