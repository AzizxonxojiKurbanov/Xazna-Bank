import 'package:flutter/material.dart';

class ServiceMenuItem {
  const ServiceMenuItem({
    required this.title,
    required this.icon,
    this.subtitle,
    this.isNew = false,
  });

  final String title;
  final IconData icon;
  final String? subtitle;
  final bool isNew;
}
