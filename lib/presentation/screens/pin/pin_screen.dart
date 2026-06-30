
import 'package:flutter/material.dart';

class PinScreen extends StatelessWidget {
  const PinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const int filledCount = 1;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A3C34), Color(0xFF0F2620)],
          ),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: const Icon(
                  Icons.chevron_left,
                  size: 32,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            SizedBox(height: 24),
            Center(
              child: Text(
                "PIN-kod yaratish",
                style: TextStyle(color: Colors.white, fontSize: 28),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (i) {
                final filled = i < filledCount;
                return Container(
                  width: 14,
                  height: 14,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: filled ? Colors.white : Colors.white24,
                  ),
                );
              }),
            ),

            const SizedBox(height: 48),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Kirish uchun Face ID-dan foydalanish",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Switch(
                    value: true,
                    onChanged: (v) {},
                    activeColor: Colors.black,
                    trackColor: const WidgetStatePropertyAll(Colors.green),
                    thumbColor: WidgetStateProperty.resolveWith<Color?>((
                      states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.black;
                      }
                      return null;
                    }),
                  ),
                ],
              ),
            ),

            SizedBox(height: 48,),

            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                childAspectRatio: 1.3,
                children: [
                  ...List.generate(9, (i) => _buildKey('${i + 1}')),
                  _buildKey('bio'),
                  _buildKey('0'),
                  _buildKey('del'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildKey(String label) {
  final isDigit = int.tryParse(label) != null;

  return GestureDetector(
    onTap: () {},
    child: Center(
      child: isDigit
          ? Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            )
          : label == 'del'
          ? const Icon(Icons.backspace_outlined, color: Colors.white, size: 28)
          : const Icon(Icons.fingerprint, color: Colors.white, size: 32),
    ),
  );
}
