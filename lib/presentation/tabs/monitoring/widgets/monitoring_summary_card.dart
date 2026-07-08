import 'package:flutter/material.dart';
import 'package:xazna_bank/presentation/home/utils/amount_formatter.dart';
import 'package:xazna_bank/presentation/tabs/monitoring/models/monitoring_transaction.dart';

class MonitoringSummaryCard extends StatelessWidget {
  const MonitoringSummaryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.type,
  });

  final String title;
  final double amount;
  final MonitoringTransactionType type;

  @override
  Widget build(BuildContext context) {
    final isIncome = type.isIncome;
    final color = isIncome ? const Color(0xFF5FC66A) : const Color(0xFFE1444D);

    return Container(
      height: 96,
      padding: const EdgeInsets.fromLTRB(14, 16, 14, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE1E6E1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isIncome
                    ? Icons.keyboard_double_arrow_down
                    : Icons.keyboard_double_arrow_up,
                color: color,
                size: 28,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF8B9090),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              '${formatAmount(amount)} UZS',
              maxLines: 1,
              style: const TextStyle(
                color: Color(0xFF1D272D),
                fontSize: 17,
                fontWeight: FontWeight.w900,
                letterSpacing: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
