import 'dart:async';

import 'package:flutter/material.dart';

class splash extends StatefulWidget {
  splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> with AutomaticKeepAliveClientMixin {
  Timer? searchOnStoppedTyping;
  _onChangeHandler() {
    const duration = Duration(
        milliseconds:
            4000); // set the duration that you want call pop() after that.
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping?.cancel(); // clear timer
    }
    searchOnStoppedTyping = new Timer(duration, () => navigateHome());
  }

  navigateHome() {
    Navigator.of(context).pushReplacementNamed("start");
  }

  @override
  void initState() {
    _onChangeHandler();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 6, 47),
      body: Center(child: Image.asset("assets/DFruit.gif")),
    );
  }
}
