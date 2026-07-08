import 'package:flutter/material.dart';

class TransferRecipient {
  const TransferRecipient({
    required this.id,
    required this.name,
    required this.maskedNumber,
    required this.brand,
    required this.brandColor,
  });

  final String id;
  final String name;
  final String maskedNumber;
  final String brand;
  final Color brandColor;
}
