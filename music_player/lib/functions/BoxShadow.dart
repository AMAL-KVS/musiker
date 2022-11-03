import 'package:flutter/material.dart';

class dbox extends StatelessWidget {
  final Child;
  const dbox({super.key, required this.Child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Child,
      ),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 53, 51, 51),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 37, 36, 36),
                blurRadius: 15,
                offset: Offset(5, 5)),
            BoxShadow(
                color: Color.fromARGB(255, 0, 0, 0),
                blurRadius: 15,
                offset: Offset(-5, -5))
          ]),
    );
  }
}
