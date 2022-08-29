import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fruit/fold1/home.dart';
import 'package:fruit/design/home_page.dart';
import 'package:fruit/design/splash.dart';
import 'package:fruit/design/start.dart';
import 'package:get/get.dart';

// List<CameraDescription>? cameras;

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   cameras = await availableCameras();

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'RealTime Detection',
//       // home: HomePage(cameras!),
//       home: homePage(),
//       routes: {
//         "splash": ((context) => splash()),
//         "start": ((context) => start()),
//       },
//     );
//   }
// }

List<CameraDescription>? cameras;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'tflite real-time detection',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      //Home(cameras!)
      home: splash(),
      routes: {
        "splash": ((context) => splash()),
        "start": ((context) => start()),
        "Home": ((context) => Home(cameras!)),
      },
    );
  }
}
