import 'package:flutter/material.dart';
import 'package:xazna_bank/data/repositories/auth_repository.dart';
import 'package:xazna_bank/presentation/home/home_screen.dart';
import 'package:xazna_bank/presentation/language/language_screen.dart';

class SplashScreen extends StatefulWidget {
  final AuthRepository repository;

  const SplashScreen({super.key, required this.repository});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _openNextScreen();
  }

  Future<void> _openNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    final hasSavedSession = await widget.repository.hasSavedSession();
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            hasSavedSession ? const HomeScreen() : const LanguageScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF101C1B), Color(0xFF123329), Color(0xFF0F4635)],
          ),
        ),
        child: Center(child: Image.asset("assets/images/xazna_logo.png")),
      ),
    );
  }
}
