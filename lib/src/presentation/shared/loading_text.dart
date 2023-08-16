import 'dart:async';

import 'package:flutter/material.dart';

class LoadingText extends StatefulWidget {
  const LoadingText({
    Key? key,
    required this.placeholder,
    this.style,
  }) : super(key: key);

  final String placeholder;
  final TextStyle? style;
  @override
  State<LoadingText> createState() => _LoadingTextState();
}

class _LoadingTextState extends State<LoadingText> {
  late Timer _timer;
  List<String> text = ["...", "..", ".", ".."];
  int currentTextIndex = 0;
  String currentText = "...";

  @override
  void initState() {
    initTimer();
    super.initState();
  }

  initTimer() async {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        currentTextIndex = (currentTextIndex + 1) % text.length;
        currentText = text[currentTextIndex];
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.placeholder + currentText,
          style: widget.style,
        ),
      ],
    );
  }
}
