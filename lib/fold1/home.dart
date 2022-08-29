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
  }

  loadModel() async {
    String res;
    res = (await Tflite.loadModel(
        // model: "assets/yolov2_tiny.tflite",
        // labels: "assets/yolov2_tiny.txt",
        model: "assets/yolov2-tiny(1).tflite",
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
                Expanded(
                  child: Align(
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
                                              color: Colors.white,
                                              fontSize: 20),
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
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        cont2()
                                      ],
                                    ),
                                  )
                                ],
                              )))),
                ),
              ],
            ),
    );
  }

  Map fruit = {
    "Apple_invalid": ["Apple", "invalid"],
    "Banana_invalid": ["Banana", "invalid"],
    "Banana_valid": ["Banana", "valid"],
    "Bananas_invalid": ["Bananas", "invalid"],
    "Bananas_valid": ["Bananas", "valid"],
    "Black_grapes_valid": ["Black grapes", "valid"],
    "Black_raspberries_valid": ["Black raspberries", "valid"],
    "Grapes_invalid": ["Grapes", "invalid"],
    "Green_apple_valid": ["Green apple", "valid"],
    "Green_grapes_valid": ["Green grapes", "valid"],
    "Mango_invalid": ["Mango", "invalid"],
    "Mango_valid": ["Apple", "valid"],
    "Orange_invalid": ["Orange", "invalid"],
    "Orange_valid": ["Orange", "valid"],
    "Pear_invalid": ["Pear", "invalid"],
    "Pear_valid": ["Pear", "valid"],
    "Pineapple_invalid": ["Pineapple", "invalid"],
    "Pineapple_valid": ["Pineapple", "valid"],
    "Plum_invalid": ["Plum", "invalid"],
    "Plum_valid": ["Plum", "valid"],
    "Pomegranate_invalid": ["Pomegranate", "invalid"],
    "Pomegranate_valid": ["Pomegranate", "valid"],
    "Raspberries_invalid": ["Raspberries", "invalid"],
    "Red_apple_valid": ["Red apple", "valid"],
    "Red_raspberries_valid": ["Red raspberries", "valid"],
    "Strawberry_invalid": ["Strawberry", "invalid"],
    "Strawberry_valid": ["Strawberry", "valid"],
    "Watermelon_invalid": ["Watermelon", "invalid"],
    "Watermelon_valid": ["Watermelon", "valid"],
    "Yellow_apple_valid": ["Yellow apple", "valid"]
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
                style: TextStyle(color: Colors.white),
              )
            : Text(
                funcMatch(lable[0]["detectedClass"].toString())[0][0]
                    .toString(),
                style: const TextStyle(color: Colors.white),
              ));
  }

  Container cont2() {
    return Container(
        child: lable == null || lable == [] || lable.isEmpty
            ? const Text(
                "",
                style: TextStyle(color: Colors.white),
              )
            : Text(
                funcMatch(lable[0]["detectedClass"].toString())[0][1]
                    .toString(),
                style: const TextStyle(color: Colors.white),
              ));
  }
}
