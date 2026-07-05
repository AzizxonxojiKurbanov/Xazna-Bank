import 'package:flutter/material.dart';
import 'package:xazna_bank/presentation/home/utils/amount_formatter.dart';

class HomeBalanceRow extends StatelessWidget {
  const HomeBalanceRow({
    super.key,
    required this.balance,
    required this.isHidden,
    required this.onToggle,
  });

  final num balance;
  final bool isHidden;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 52,
          width: 34,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withValues(alpha: 0.42)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 24),
              Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 24),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Flexible(
                    child: Text(
                      'Umumiy balans',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onToggle,
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                      isHidden
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.white,
                      size: 23,
                    ),
                  ),
                ],
              ),
              Text(
                isHidden ? '**** UZS' : '${formatAmount(balance)} UZS',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
