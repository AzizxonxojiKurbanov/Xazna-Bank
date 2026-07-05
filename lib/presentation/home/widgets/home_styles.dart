import 'package:flutter/material.dart';

BoxDecoration homeCardDecoration({double radius = 18}) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(radius),
    boxShadow: homeSoftShadow,
  );
}

List<BoxShadow> get homeSoftShadow {
  return [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.11),
      blurRadius: 12,
      offset: const Offset(0, 5),
    ),
  ];
}
