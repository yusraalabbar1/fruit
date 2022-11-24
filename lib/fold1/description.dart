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
      body: ListView(
        children: [
          Image.asset(widget.image1),
          Text(widget.title),
          Text(widget.benefits),
          Image.asset(widget.image2),
        ],
      ),
    );
  }
}
