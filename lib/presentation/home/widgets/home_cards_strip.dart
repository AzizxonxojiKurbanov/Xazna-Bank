import 'package:flutter/material.dart';
import 'package:xazna_bank/presentation/home/models/home_bank_card.dart';
import 'package:xazna_bank/presentation/home/utils/amount_formatter.dart';
import 'package:xazna_bank/presentation/home/widgets/home_styles.dart';

class HomeCardsStrip extends StatelessWidget {
  const HomeCardsStrip({
    super.key,
    required this.cards,
    required this.isBalanceHidden,
  });

  final List<HomeBankCard> cards;
  final bool isBalanceHidden;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 148,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: cards.length + 1,
        separatorBuilder: (_, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          if (index == cards.length) {
            return const _AddCardTile();
          }

          return _BankCardTile(
            card: cards[index],
            isBalanceHidden: isBalanceHidden,
          );
        },
      ),
    );
  }
}

class _BankCardTile extends StatelessWidget {
  const _BankCardTile({required this.card, required this.isBalanceHidden});

  final HomeBankCard card;
  final bool isBalanceHidden;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 188,
      padding: const EdgeInsets.all(13),
      decoration: homeCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'KAPITALBANK',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xFF252A28),
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Image.asset('assets/images/uzcard.png', height: 20),
              if (card.isBlocked) ...[
                const SizedBox(width: 6),
                const Icon(
                  Icons.lock_outline,
                  size: 14,
                  color: Color(0xFFE53935),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          Text(
            card.type.toLowerCase(),
            style: const TextStyle(color: Color(0xFF9AA0A6), fontSize: 13),
          ),
          const SizedBox(height: 4),
          Text(
            isBalanceHidden
                ? '**** ${card.currency}'
                : '${formatAmount(card.balance)} ${card.currency}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF252A28),
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: Text(
                  card.maskedNumber,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF8C9398),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                card.isMain ? Icons.star_outline : Icons.star_border,
                color: const Color(0xFF27825A),
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddCardTile extends StatelessWidget {
  const _AddCardTile();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 188,
        decoration: homeCardDecoration(),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline, color: Color(0xFF54B96B), size: 34),
            SizedBox(height: 12),
            Text(
              "Karta qo'shing",
              style: TextStyle(
                color: Color(0xFF606469),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
