import 'package:flutter/material.dart';

class description extends StatefulWidget {
  final title;
  final benefits;
  final image1;
  final image2;
  const description(
      {super.key, this.title, this.benefits, this.image1, this.image2});

  @override
  State<description> createState() => _descriptionState();
}

class _descriptionState extends State<description> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 26, 4, 72),
      body: widget.title == ""
          ? const Text("There is no information")
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      "assets/${widget.image1}",
                      width: 250,
                      height: 250,
                    ),
                  ),
                  Center(
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.benefits,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold, height: 1.5),
                  ),
                  Image.asset(
                    "assets/${widget.image2}",
                    width: 150,
                    height: 150,
                  ),
                ],
              ),
            ),
    );
  }
}
