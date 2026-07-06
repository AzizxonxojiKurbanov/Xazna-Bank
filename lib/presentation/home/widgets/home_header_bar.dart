import 'package:flutter/material.dart';

class HomeHeaderBar extends StatelessWidget {
  const HomeHeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(3),
          child: Image.asset('assets/images/user.png'),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'AZIZXONXOJI',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        _HeaderIconButton(icon: Icons.search, onTap: () {}),
        _HeaderIconButton(icon: Icons.chat_bubble_outline, onTap: () {}),
        Stack(
          clipBehavior: Clip.none,
          children: [
            _HeaderIconButton(icon: Icons.notifications_none, onTap: () {}),
            Positioned(
              top: 2,
              right: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                  color: const Color(0xFFE53935),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  '11',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      visualDensity: VisualDensity.compact,
      icon: Icon(icon, color: Colors.white, size: 26),
    );
  }
}
