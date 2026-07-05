import 'package:flutter/material.dart';
import 'package:xazna_bank/presentation/home/models/payment_category.dart';

class PaymentItem extends StatelessWidget {
  const PaymentItem({super.key, required this.paymentCategory});
  final PaymentCategory paymentCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 82,
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF255A3D).withValues(alpha: 0.84),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(paymentCategory.icon, color: Colors.white, size: 25),
          const Spacer(),
          Text(
            paymentCategory.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
