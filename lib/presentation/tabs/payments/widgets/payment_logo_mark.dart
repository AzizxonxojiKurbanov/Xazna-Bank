import 'package:flutter/material.dart';
import 'package:xazna_bank/presentation/tabs/payments/models/payment_service_item.dart';

class PaymentLogoMark extends StatelessWidget {
  const PaymentLogoMark({
    super.key,
    required this.type,
    required this.color,
    this.size = 74,
  });

  final PaymentLogoType type;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Center(child: _buildLogo()),
    );
  }

  Widget _buildLogo() {
    switch (type) {
      case PaymentLogoType.ucell:
        return _CircleText(text: 'U', color: color);
      case PaymentLogoType.beeline:
        return Container(
          width: size * 0.74,
          height: size * 0.74,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.black, Color(0xFFFFD22E), Colors.black],
              stops: [0.12, 0.5, 0.88],
            ),
          ),
        );
      case PaymentLogoType.mobiuz:
        return Text(
          'mobiuz',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontSize: size * 0.22,
            fontWeight: FontWeight.w900,
            height: 0.9,
          ),
        );
      case PaymentLogoType.uzmobile:
        return Text(
          'UZMOBILE\nCDMA',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontSize: size * 0.15,
            fontWeight: FontWeight.w900,
            height: 0.95,
          ),
        );
      case PaymentLogoType.orange:
        return Icon(Icons.blur_circular, color: color, size: size * 0.68);
      case PaymentLogoType.gas:
        return Icon(
          Icons.local_fire_department,
          color: color,
          size: size * 0.74,
        );
      case PaymentLogoType.electric:
        return Icon(Icons.bolt_outlined, color: color, size: size * 0.78);
      case PaymentLogoType.utility:
        return Icon(Icons.hub_outlined, color: color, size: size * 0.74);
      case PaymentLogoType.wave:
        return Icon(Icons.wifi_tethering, color: color, size: size * 0.74);
      case PaymentLogoType.partner:
        return Text(
          'et',
          style: TextStyle(
            color: color,
            fontSize: size * 0.48,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        );
      case PaymentLogoType.percent:
        return Icon(Icons.receipt_long, color: color, size: size * 0.74);
      case PaymentLogoType.stamp:
        return Icon(Icons.approval, color: color, size: size * 0.74);
    }
  }
}

class _CircleText extends StatelessWidget {
  const _CircleText({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.24),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
