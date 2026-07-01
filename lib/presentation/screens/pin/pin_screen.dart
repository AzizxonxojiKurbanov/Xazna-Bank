import 'package:flutter/material.dart';
import 'package:xazna_bank/presentation/screens/pin/confirm_pin_screen.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String pin = '';

  void _onKeyTap(String key) {
    setState(() {
      if (key == 'del') {
        if (pin.isNotEmpty) {
          pin = pin.substring(0, pin.length - 1);
        }
        return;
      }

      if (pin.length < 4) {
        pin += key;
      }
    });

    if (pin.length == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ConfirmPinScreen(pin: pin)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _PinScaffold(
      title: 'PIN-kod yarating',
      subtitle:
          'Ilovaga kirish va amallarni tasdiqlash uchun 4 xonali kod tanlang',
      filledCount: pin.length,
      onKeyTap: _onKeyTap,
    );
  }
}

class PinKeypad extends StatelessWidget {
  final ValueChanged<String> onKeyTap;

  const PinKeypad({super.key, required this.onKeyTap});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 34),
      childAspectRatio: 1.65,
      children: [
        ...List.generate(9, (i) => _PinKey(label: '${i + 1}', onTap: onKeyTap)),
        const SizedBox.shrink(),
        _PinKey(label: '0', onTap: onKeyTap),
        _PinKey(label: 'del', onTap: onKeyTap),
      ],
    );
  }
}

class _PinScaffold extends StatelessWidget {
  final String title;
  final String subtitle;
  final int filledCount;
  final ValueChanged<String> onKeyTap;
  final Widget? footer;

  const _PinScaffold({
    required this.title,
    required this.subtitle,
    required this.filledCount,
    required this.onKeyTap,
    this.footer,
  });

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
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 20,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 22),
              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFB8C5BF),
                    fontSize: 13,
                    height: 1.25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (i) {
                  final filled = i < filledCount;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    width: 11,
                    height: 11,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: filled ? Colors.white : Colors.white24,
                    ),
                  );
                }),
              ),
              const Spacer(),
              ?footer,
              PinKeypad(onKeyTap: onKeyTap),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _PinKey extends StatelessWidget {
  final String label;
  final ValueChanged<String> onTap;

  const _PinKey({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDigit = int.tryParse(label) != null;

    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: isDigit || label == 'del' ? () => onTap(label) : null,
      child: Center(
        child: isDigit
            ? Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              )
            : const Icon(
                Icons.backspace_outlined,
                color: Colors.white,
                size: 22,
              ),
      ),
    );
  }
}

class PinInputScaffold extends StatelessWidget {
  final String title;
  final String subtitle;
  final int filledCount;
  final ValueChanged<String> onKeyTap;
  final Widget? footer;

  const PinInputScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.filledCount,
    required this.onKeyTap,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return _PinScaffold(
      title: title,
      subtitle: subtitle,
      filledCount: filledCount,
      onKeyTap: onKeyTap,
      footer: footer,
    );
  }
}
