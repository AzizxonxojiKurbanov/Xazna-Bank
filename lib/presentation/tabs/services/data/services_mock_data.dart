import 'package:flutter/material.dart';
import 'package:xazna_bank/presentation/tabs/services/models/service_menu_item.dart';

const serviceMenuItems = <ServiceMenuItem>[
  ServiceMenuItem(
    title: 'Eskrou xizmati',
    icon: Icons.settings_applications_outlined,
    isNew: true,
  ),
  ServiceMenuItem(title: 'KATM', icon: Icons.speed_outlined),
  ServiceMenuItem(title: 'xazna avia', icon: Icons.flight_takeoff_outlined),
  ServiceMenuItem(title: 'Ijtimoiy xizmatlar', icon: Icons.volunteer_activism),
  ServiceMenuItem(title: 'Mening bankim', icon: Icons.account_balance_outlined),
  ServiceMenuItem(title: 'Mening uyim', icon: Icons.home_outlined),
  ServiceMenuItem(title: 'Mening avtomobilim', icon: Icons.directions_car),
  ServiceMenuItem(
    title: 'Xazna drive',
    subtitle: 'Onlayn avtomobil xarid qilish',
    icon: Icons.bolt,
  ),
  ServiceMenuItem(title: 'Davlat xizmatlari', icon: Icons.public),
  ServiceMenuItem(title: 'Mening pensiyam', icon: Icons.payments_outlined),
  ServiceMenuItem(title: 'Soliq qarzdorliklar', icon: Icons.assured_workload),
  ServiceMenuItem(title: 'Mening arizalarim', icon: Icons.feed_outlined),
  ServiceMenuItem(
    title: 'Xizmat sifatini baholash',
    icon: Icons.reviews_outlined,
  ),
];
