import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ecoapp/HomeScreen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

List<CameraDescription> cameras;
List<String> testDeviceIds = ['DEVICEID'];
Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  RequestConfiguration configuration =
      RequestConfiguration(testDeviceIds: testDeviceIds);
  MobileAds.instance.updateRequestConfiguration(configuration);

  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error $e.code \n Error Message: $e.message');
  }

  runApp(new MainScreen());
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(cameras),
    );
  }
}
