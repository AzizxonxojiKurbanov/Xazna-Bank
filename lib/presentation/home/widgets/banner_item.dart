import 'package:flutter/material.dart';
import 'package:xazna_bank/presentation/home/models/banner_model.dart';

class BannerItem extends StatelessWidget {
  const BannerItem({super.key, required this.bannerModel});

  final BannerModel bannerModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF3F8F58),
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF55A85F),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    bannerModel.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    bannerModel.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            flex: 4,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(child: CustomPaint(painter: _CirclePainter())),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Image.asset(bannerModel.image, fit: BoxFit.contain),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    const radius = 32.0;

    for (double x = -10; x < size.width + 50; x += 64) {
      for (double y = -10; y < size.height + 50; y += 64) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
