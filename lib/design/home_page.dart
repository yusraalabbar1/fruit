import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fruit/main.dart';
import 'package:tflite/tflite.dart';

class homePage extends StatefulWidget {
  homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  bool isWorking = false;
  String result = '';
  CameraController? cameraController;
  CameraImage? imgcamera;
  CameraController? controller;

  //////////////////////////////////
  initCamera() {
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      }

      setState(() {
        cameraController!.startImageStream((imageFromStream) => {
              if (!isWorking)
                {
                  isWorking = true,
                  imgcamera = imageFromStream,
                  runModelOfStreamFrames()
                }
            });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadModel();
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        print("=================================");
        print("amount ");
        print("=================================");
        cameraController!.startImageStream((imageFromStream) => {
              if (!isWorking)
                {
                  isWorking = true,
                  imgcamera = imageFromStream,
                  runModelOfStreamFrames()
                }
            });
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  loadModel() async {
    print("=================================");
    print("load model");
    print("=================================");
    await Tflite.loadModel(
        model: "assets/yolov2-tiny(1).tflite",
        labels: "assets/tflite_label_map.txt");
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   loadModel();
  // }

  @override
  void dispose() async {
    // TODO: implement dispose
    super.dispose();
    await Tflite.close();
  }

  runModelOfStreamFrames() async {
    print("=================================");
    print("run model");
    print("=================================");
    var recognition = await Tflite.runModelOnFrame(
      bytesList: imgcamera!.planes.map((plan) {
        return plan.bytes;
      }).toList(),
      imageHeight: imgcamera!.height,
      imageWidth: imgcamera!.width,
      imageMean: 127.5,
      imageStd: 127.5,
      rotation: 90,
      numResults: 1,
      threshold: 0.2,
      asynch: true,
    );

    result = "";
    print("=================================");
    print("recognition model");
    print("=================================");
    recognition!.forEach((response) {
      result += response['lable'];
    });
    setState(() {
      print("=================================");
      print("result model");
      print(result);
      print("=================================");
      result;
    });
    isWorking = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: CameraPreview(cameraController!),
      // Column(
      //   children: [
      //     Center(
      //       child: TextButton(
      //           onPressed: () async {
      //             await initCamera();
      //           },
      //           child: Container(
      //             height: 270,
      //             width: 360,
      //             margin: EdgeInsets.only(top: 65),
      //             child: imgcamera == null
      //                 ? Container(
      //                     height: 270,
      //                     width: 360,
      //                     child: Icon(Icons.photo_camera),
      //                   )
      //                 : AspectRatio(
      //                     aspectRatio:
      //                         cameraController!.value.aspectRatio,
      //                     child: CameraPreview(cameraController!),
      //                   ),
      //           )),
      //     ),
      //     Text(result)
      //   ],
      // )
    ));
  }
}
