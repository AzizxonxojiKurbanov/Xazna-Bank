import 'package:flutter/material.dart';

class SimpleTabBody extends StatelessWidget {
  const SimpleTabBody({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF252A28),
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
