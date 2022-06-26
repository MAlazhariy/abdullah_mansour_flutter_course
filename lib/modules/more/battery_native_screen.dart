import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BatteryNativeScreen extends StatefulWidget {
  const BatteryNativeScreen({Key? key}) : super(key: key);

  @override
  State<BatteryNativeScreen> createState() => _BatteryNativeScreenState();
}

class _BatteryNativeScreenState extends State<BatteryNativeScreen> {

  static const platform = MethodChannel('samples.flutter.dev/battery');
  String _batteryLevel = 'Calculating..';

  Future<void> getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level: $result%.';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_batteryLevel),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              child: const Text('Get Battery Level'),
              onPressed: getBatteryLevel,
            ),
          ],
        ),
      ),
    );
  }
}
