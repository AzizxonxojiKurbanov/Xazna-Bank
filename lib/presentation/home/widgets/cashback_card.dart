import 'package:flutter/material.dart';
import 'package:xazna_bank/presentation/home/widgets/home_styles.dart';

class CashbackCard extends StatelessWidget {
  const CashbackCard({super.key, required this.isBalanceHidden});

  final bool isBalanceHidden;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF4E4A4)),
        boxShadow: homeSoftShadow,
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF5BD37),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.account_balance_wallet_outlined,
              color: Colors.white,
              size: 26,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CASHBACK',
                  style: TextStyle(
                    color: Color(0xFFF5BD37),
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isBalanceHidden ? '**** UZS' : '0.00 UZS',
                  style: const TextStyle(
                    color: Color(0xFF252A28),
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.wallet, color: Color(0xFFF5BD37), size: 36),
        ],
      ),
    );
  }
}
