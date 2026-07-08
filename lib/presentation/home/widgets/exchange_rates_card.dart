import 'package:flutter/material.dart';
import 'package:xazna_bank/presentation/home/models/exchange_rate.dart';
import 'package:xazna_bank/presentation/home/utils/amount_formatter.dart';
import 'package:xazna_bank/presentation/home/widgets/home_styles.dart';

class ExchangeRatesCard extends StatelessWidget {
  const ExchangeRatesCard({super.key, required this.rates});

  final List<ExchangeRate> rates;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: homeCardDecoration(radius: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Valyutalar kursi',
              style: TextStyle(
                color: Color(0xFF252A28),
                fontSize: 17,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          for (final rate in rates) _ExchangeRateRow(rate: rate),
          const Divider(height: 1),
          TextButton.icon(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              foregroundColor: const Color(0xFF54B96B),
              textStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
            iconAlignment: IconAlignment.end,
            icon: const Icon(Icons.chevron_right, size: 24),
            label: const Text('Barcha valyuta kurslari'),
          ),
        ],
      ),
    );
  }
}

class _ExchangeRateRow extends StatelessWidget {
  const _ExchangeRateRow({required this.rate});

  final ExchangeRate rate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              _CurrencyBadge(currency: rate.currency),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  rate.currency,
                  style: const TextStyle(
                    color: Color(0xFF252A28),
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(
                width: 82,
                child: Text(
                  formatAmount(rate.buy),
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Color(0xFF252A28),
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 82,
                child: Text(
                  formatAmount(rate.sell),
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Color(0xFF252A28),
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1, indent: 16, endIndent: 16),
      ],
    );
  }
}

class _CurrencyBadge extends StatelessWidget {
  const _CurrencyBadge({required this.currency});

  final String currency;

  @override
  Widget build(BuildContext context) {
    final color = switch (currency) {
      'USD' => const Color(0xFF2459A8),
      'EUR' => const Color(0xFF1D4D9F),
      _ => const Color(0xFF54B96B),
    };

    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(
        currency.characters.take(1).toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
