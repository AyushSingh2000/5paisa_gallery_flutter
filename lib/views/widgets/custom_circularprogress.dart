import "package:flutter/material.dart";

class CPI extends StatelessWidget {
  CPI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.6,
      child: const CircularProgressIndicator(color: Colors.white),
    );
  }
}
