import 'package:flutter/material.dart';

enum PaymentLogoType {
  ucell,
  beeline,
  mobiuz,
  uzmobile,
  orange,
  gas,
  electric,
  utility,
  wave,
  partner,
  percent,
  stamp,
}

class PaymentServiceItem {
  const PaymentServiceItem({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.logoType,
    required this.color,
  });

  final String id;
  final String title;
  final String categoryId;
  final PaymentLogoType logoType;
  final Color color;
}
