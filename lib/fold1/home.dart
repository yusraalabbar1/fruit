import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

import 'camera.dart';
import 'bndbox.dart';
import 'models.dart';

class Home extends StatefulWidget {
  final List<CameraDescription> cameras;

  Home(this.cameras);

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic>? _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";

  @override
  void initState() {
    super.initState();
    onSelect(yolo);
  }

  loadModel() async {
    String res;
    res = (await Tflite.loadModel(
        model: "assets/yolov2-tiny(2).tflite",
        labels: "assets/tflite_label_map.txt"))!;
    print(res);
  }

  onSelect(model) {
    setState(() {
      _model = model;
    });
    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: _model == ""
          ? Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  child: Image.asset(
                    "assets/22.PNG",
                    height: 150,
                    width: 150,
                  ),
                ),
                Center(
                    child: InkWell(
                  onTap: () {
                    onSelect(yolo);
                  },
                  child: Container(
                      height: 300,
                      width: 350,
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xff351B6F),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Center(
                        child: Text("Camera",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      )),
                )),
              ],
            )
          : Stack(
              children: [
                Camera(
                  widget.cameras,
                  _model,
                  setRecognitions,
                ),
                BndBox(
                    _recognitions ?? [],
                    math.max(_imageHeight, _imageWidth),
                    math.min(_imageHeight, _imageWidth),
                    screen.height,
                    screen.width,
                    _model),
                Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width,
                        color: const Color(0xff351B6F),
                        child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Type : \t",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      cont1()
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Lable : \t",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      cont2()
                                    ],
                                  ),
                                )
                              ],
                            )))),
              ],
            ),
    );
  }

  Map fruit = {
    "Apple_invalid": ["Apple", "Not Fresh"],
    "Banana_invalid": ["Banana", "Not Fresh"],
    "Banana_valid": ["Banana", "Fresh"],
    "Bananas_invalid": ["Bananas", "Not Fresh"],
    "Bananas_valid": ["Bananas", "Fresh"],
    "Black_grapes_valid": ["Black grapes", "Fresh"],
    "Black_raspberries_valid": ["Black raspberries", "Fresh"],
    "Grapes_invalid": ["Grapes", "Not Fresh"],
    "Green_apple_valid": ["Green apple", "Fresh"],
    "Green_grapes_valid": ["Green grapes", "Fresh"],
    "Mango_invalid": ["Mango", "Not Fresh"],
    "Mango_valid": ["Apple", "Fresh"],
    "Orange_invalid": ["Orange", "Not Fresh"],
    "Orange_valid": ["Orange", "Fresh"],
    "Pear_invalid": ["Pear", "Not Fresh"],
    "Pear_valid": ["Pear", "Fresh"],
    "Pineapple_invalid": ["Pineapple", "Not Fresh"],
    "Pineapple_valid": ["Pineapple", "Fresh"],
    "Plum_invalid": ["Plum", "Not Fresh"],
    "Plum_valid": ["Plum", "Fresh"],
    "Pomegranate_invalid": ["Pomegranate", "Not Fresh"],
    "Pomegranate_valid": ["Pomegranate", "Fresh"],
    "Raspberries_invalid": ["Raspberries", "Not Fresh"],
    "Red_apple_valid": ["Red apple", "Fresh"],
    "Red_raspberries_valid": ["Red raspberries", "Fresh"],
    "Strawberry_invalid": ["Strawberry", "Not Fresh"],
    "Strawberry_valid": ["Strawberry", "Fresh"],
    "Watermelon_invalid": ["Watermelon", "Not Fresh"],
    "Watermelon_valid": ["Watermelon", "Fresh"],
    "Yellow_apple_valid": ["Yellow apple", "Fresh"]
  };

  funcMatch(word) {
    List typeLable = [];
    fruit.forEach((k, v) {
      if (k == word) {
        typeLable.add(v);
      }
    });
    return typeLable;
  }

  Container cont1() {
    return Container(
        child: lable == null || lable == [] || lable.isEmpty
            ? const Text(
                "",
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            : Text(
                funcMatch(lable[0]["detectedClass"].toString())[0][0]
                    .toString(),
                style: const TextStyle(
                  color: Color.fromARGB(255, 237, 229, 75),
                  fontSize: 20,
                  fontFamily: "lato",
                ),
              ));
  }

  Container cont2() {
    return Container(
        child: lable == null || lable == [] || lable.isEmpty
            ? const Text(
                "",
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            : Text(
                funcMatch(lable[0]["detectedClass"].toString())[0][1]
                    .toString(),
                style: const TextStyle(
                  color: Color.fromARGB(255, 237, 229, 75),
                  fontSize: 20,
                  fontFamily: "lato",
                ),
              ));
  }
}
