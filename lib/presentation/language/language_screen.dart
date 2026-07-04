import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xazna_bank/presentation/auth/phone/phone_screen.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );

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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                const Spacer(flex: 52),

                const Text(
                  '"xazna"ga xush kelibsiz',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'Davom etish uchun tilni tanlang',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withAlpha(62),
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 32),

                const LanguageSelector(),

                const Spacer(flex: 64),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => PhoneScreen()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(
                        color: Color(0xFF66D06D),
                        width: 1.4,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                    child: const Text(
                      'KEYINGI',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: size.height * .03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SmallLanguageButton(text: '🇷🇺'),
        SizedBox(width: 10),
        SelectedLanguageButton(),
        SizedBox(width: 10),
        SmallLanguageButton(text: '🇬🇧'),
      ],
    );
  }
}

class SmallLanguageButton extends StatelessWidget {
  const SmallLanguageButton({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF244F34),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text, style: const TextStyle(fontSize: 28)),
    );
  }
}

class SelectedLanguageButton extends StatelessWidget {
  const SelectedLanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 205,
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF315D3C),
        borderRadius: BorderRadius.circular(11),
      ),
      child: const Row(
        children: [
          Text('🇺🇿', style: TextStyle(fontSize: 28)),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "O'zbekcha",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(width: 6),
          Icon(Icons.check_circle, color: Color(0xFF58D765), size: 28),
        ],
      ),
    );
  }
}
