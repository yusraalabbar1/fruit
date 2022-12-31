import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:fruit/fold1/description.dart';
import 'package:fruit/fold1/info.dart';
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
                        color: Color.fromARGB(255, 7, 41, 80),
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
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
                                Expanded(flex: 2, child: cont2()),
                              ],
                            )))),
              ],
            ),
    );
  }

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

  Widget cont2() {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              "Lable : \t",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Container(
                child: lable == null || lable == [] || lable.isEmpty
                    ? const Text(
                        "",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    : Column(
                        children: [
                          Text(
                            funcMatch(lable[0]["detectedClass"].toString())[0]
                                    [1]
                                .toString(),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 237, 229, 75),
                              fontSize: 20,
                              fontFamily: "lato",
                            ),
                          ),
                        ],
                      )),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        lable == null || lable == [] || lable.isEmpty
            ? Container()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 20, 36, 107),
                  textStyle: const TextStyle(color: Colors.white),
                  padding: const EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => description(
                              title: funcMatch(lable[0]["detectedClass"]
                                      .toString())[0][2]
                                  .toString(),
                              benefits: funcMatch(lable[0]["detectedClass"]
                                      .toString())[0][3]
                                  .toString(),
                              image1: funcMatch(lable[0]["detectedClass"]
                                      .toString())[0][4]
                                  .toString(),
                              image2: funcMatch(lable[0]["detectedClass"]
                                      .toString())[0][5]
                                  .toString(),
                            )),
                  );
                },
                child: Container(
                  height: 60,
                  width: 250,
                  decoration: const BoxDecoration(
                      // gradient: LinearGradient(
                      //   begin: Alignment.topLeft,
                      //   end: Alignment.bottomRight,
                      //   colors: <Color>[
                      //     Color(0xFFFFFFFFF),
                      //     Color.fromARGB(255, 31, 146, 148),
                      //     Color.fromARGB(255, 9, 82, 86),
                      //   ],
                      // ),
                      color: Color.fromARGB(255, 31, 61, 120),
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  padding: const EdgeInsets.fromLTRB(5, 10, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text(
                        "Read More",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'lato'),
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }

  Map fruit = {
    "Apple_invalid": [
      "Apple",
      "Not Fresh",
      Red_apple_t,
      Red_apple_d,
      "images__1_-removebg-preview.png",
      "images-removebg-preview.png"
    ],
    "Banana_invalid": [
      "Banana",
      "Not Fresh",
      Banana_t,
      Banana_d,
      "رؤية-الموز-removebg-preview.png",
      "tbl_articles_article_27833_4396beb8a7-83fc-4346-83f4-930764803b26-removebg-preview.png"
    ],
    "Banana_valid": [
      "Banana",
      "Fresh",
      Banana_t,
      Banana_d,
      "رؤية-الموز-removebg-preview.png",
      "tbl_articles_article_27833_4396beb8a7-83fc-4346-83f4-930764803b26-removebg-preview.png"
    ],
    "Bananas_invalid": [
      "Bananas",
      "Not Fresh",
      Banana_t,
      Banana_d,
      "رؤية-الموز-removebg-preview.png",
      "tbl_articles_article_27833_4396beb8a7-83fc-4346-83f4-930764803b26-removebg-preview.png"
    ],
    "Bananas_valid": [
      "Bananas",
      "Fresh",
      Banana_t,
      Banana_d,
      "رؤية-الموز-removebg-preview.png",
      "tbl_articles_article_27833_4396beb8a7-83fc-4346-83f4-930764803b26-removebg-preview.png"
    ],
    "Black_grapes_valid": [
      "Black grapes",
      "Fresh",
      Grapes_t,
      Grapes_d,
      "Grape_-3-17-5-2021-removebg-preview.png",
      "Grape_-3-17-5-2021-removebg-preview.png"
    ],
    "Black_raspberries_valid": ["Black raspberries", "Fresh", "", ""],
    "Grapes_invalid": [
      "Grapes",
      "Not Fresh",
      Grapes_t,
      Grapes_d,
      "Grape_-3-17-5-2021-removebg-preview.png",
      "Grape_-3-17-5-2021-removebg-preview.png"
    ],
    "Green_apple_valid": [
      "Green apple",
      "Fresh",
      Green_apple_t,
      Green_apple_d,
      "app.png",
      "appl.png"
    ],
    "Green_grapes_valid": [
      "Green grapes",
      "Fresh",
      Grapes_t,
      Grapes_d,
      "Grape_-3-17-5-2021-removebg-preview.png",
      "Grape_-3-17-5-2021-removebg-preview.png"
    ],
    "Mango_invalid": [
      "Mango",
      "Not Fresh",
      Mango_t,
      Mango_d,
      "dreamstime_m_15466474__1_-removebg-preview.png",
      "أنواع_فاكهة_المانجو_وفوائدها_.-removebg-preview.png"
    ],
    "Mango_valid": [
      "Mango",
      "Fresh",
      Mango_t,
      Mango_d,
      "dreamstime_m_15466474__1_-removebg-preview.png",
      "أنواع_فاكهة_المانجو_وفوائدها_.-removebg-preview.png"
    ],
    "Orange_invalid": [
      "Orange",
      "Not Fresh",
      Orange_t,
      Orange_d,
      "tbl_articles_article_25599_60787bd11dc-2f86-4dcd-be31-429bd6eec361-removebg-preview.png",
      "تنزيل__1_-removebg-preview.png",
    ],
    "Orange_valid": [
      "Orange",
      "Fresh",
      Orange_t,
      Orange_d,
      "tbl_articles_article_25599_60787bd11dc-2f86-4dcd-be31-429bd6eec361-removebg-preview.png",
      "تنزيل__1_-removebg-preview.png",
    ],
    "Pear_invalid": [
      "Pear",
      "Not Fresh",
      Pear_t,
      Pear_d,
      "tbl_articles_article_30979_49465187dfb-c7ba-4c1e-a1b0-48c1613012ca-removebg-preview.png",
      "2020_10_21_17_6_20_851-removebg-preview.png"
    ],
    "Pear_valid": [
      "Pear",
      "Fresh",
      Pear_t,
      Pear_d,
      "tbl_articles_article_30979_49465187dfb-c7ba-4c1e-a1b0-48c1613012ca-removebg-preview.png",
      "2020_10_21_17_6_20_851-removebg-preview.png"
    ],
    "Pineapple_invalid": [
      "Pineapple",
      "Not Fresh",
      Pineapple_t,
      Pineapple_d,
      "أناناس-750x430-removebg-preview.png",
      "اناناس-بالصور-2-removebg-preview.png"
    ],
    "Pineapple_valid": [
      "Pineapple",
      "Fresh",
      Pineapple_t,
      Pineapple_d,
      "أناناس-750x430-removebg-preview.png",
      "اناناس-بالصور-2-removebg-preview.png"
    ],
    "Plum_invalid": ["Plum", "Not Fresh", "", "", "", ""],
    "Plum_valid": ["Plum", "Fresh", "", "", "", ""],
    "Pomegranate_invalid": [
      "Pomegranate",
      "Not Fresh",
      Pomegranate_t,
      Pomegranate_d,
      "5ipj-15-removebg-preview.png",
      "tbl_articles_article_31587_94376846dad-61ca-4617-884f-e640fe491ac2-removebg-preview.png"
    ],
    "Pomegranate_valid": [
      "Pomegranate",
      "Fresh",
      Pomegranate_t,
      Pomegranate_d,
      "5ipj-15-removebg-preview.png",
      "tbl_articles_article_31587_94376846dad-61ca-4617-884f-e640fe491ac2-removebg-preview.png"
    ],
    "Raspberries_invalid": ["Raspberries", "Not Fresh", "", "", "", ""],
    "Red_apple_valid": [
      "Red apple",
      "Fresh",
      Red_apple_t,
      Red_apple_d,
      "images__1_-removebg-preview.png",
      "images-removebg-preview.png"
    ],
    "Red_raspberries_valid": ["Red raspberries", "Fresh", "", "", "", ""],
    "Strawberry_invalid": [
      "Strawberry",
      "Not Fresh",
      Strawberry_t,
      Strawberry_d,
      "20180117205558654-removebg-preview.png",
      "Strawberries-USA-removebg-preview.png"
    ],
    "Strawberry_valid": [
      "Strawberry",
      "Fresh",
      Strawberry_t,
      Strawberry_d,
      "20180117205558654-removebg-preview.png",
      "Strawberries-USA-removebg-preview.png"
    ],
    "Watermelon_invalid": [
      "Watermelon",
      "Not Fresh",
      Watermelon_t,
      Watermelon_d,
      "TsIHwz-watermelon-clipart-file.png",
      "watermelon-primal-shisha-gels-primal-brands-13.png"
    ],
    "Watermelon_valid": [
      "Watermelon",
      "Fresh",
      Watermelon_t,
      Watermelon_d,
      "TsIHwz-watermelon-clipart-file.png",
      "watermelon-primal-shisha-gels-primal-brands-13.png"
    ],
    "Yellow_apple_valid": ["Yellow apple", "Fresh", "", "", "", ""]
  };
}
