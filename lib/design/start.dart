import 'package:flutter/material.dart';

class start extends StatefulWidget {
  start({Key? key}) : super(key: key);

  @override
  State<start> createState() => _startState();
}

class _startState extends State<start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 6, 47),
      body: ListView(
        children: [
          Image.asset("assets/DFruit (3).png"),
          Center(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10),
              child: const Text(
                "Check The Fruit If It's",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "lato",
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Center(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 20),
              child: const Text(
                "Good And Edible",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "lato",
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Center(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                "We use artificial intelligence. Not",
                style: TextStyle(
                  color: Color.fromARGB(255, 190, 188, 188),
                  fontSize: 13,
                  fontFamily: "lato",
                ),
              ),
            ),
          ),
          const Center(
            child: Text(
              "all results are correct.",
              style: TextStyle(
                color: Color.fromARGB(255, 190, 188, 188),
                fontSize: 13,
                fontFamily: "lato",
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("Home");
              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Color(0xFFFFFFFFF),
                        Color(0xFFB971A3),
                        Color(0xFFA03E82),
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(80.0))),
                padding: const EdgeInsets.fromLTRB(5, 10, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      // <-- Icon
                      Icons.arrow_circle_right,
                      size: 57.0,
                      color: Color(0xff351B6F),
                    ),
                    // SizedBox(
                    //   width: 5,
                    // ),
                    Text(
                      "Get Started",
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
          )
        ],
      ),
    );
  }
}
