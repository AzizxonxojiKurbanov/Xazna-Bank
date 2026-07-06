import 'package:flutter/material.dart';
import 'package:xazna_bank/presentation/home/data/home_mock_data.dart';
import 'package:xazna_bank/presentation/home/models/home_bank_card.dart';
import 'package:xazna_bank/presentation/home/widgets/home_balance_row.dart';
import 'package:xazna_bank/presentation/home/widgets/home_cards_strip.dart';
import 'package:xazna_bank/presentation/home/widgets/home_header_bar.dart';
import 'package:xazna_bank/presentation/home/widgets/payment_item.dart';

class HomeHeroSection extends StatelessWidget {
  const HomeHeroSection({
    super.key,
    required this.cards,
    required this.totalBalance,
    required this.isBalanceHidden,
    required this.onToggleBalance,
  });

  final List<HomeBankCard> cards;
  final num totalBalance;
  final bool isBalanceHidden;
  final VoidCallback onToggleBalance;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return SizedBox(
      height: 420 + topPadding,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 330 + topPadding,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(14, topPadding + 14, 14, 0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF11201C),
                  Color(0xFF173E30),
                  Color(0xFF46AE5C),
                ],
              ),
            ),
            child: Column(
              children: [
                const HomeHeaderBar(),
                const SizedBox(height: 16),
                HomeBalanceRow(
                  balance: totalBalance,
                  isHidden: isBalanceHidden,
                  onToggle: onToggleBalance,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 78,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: homePaymentCategories.length,
                    itemBuilder: (context, index) {
                      return PaymentItem(
                        paymentCategory: homePaymentCategories[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 14,
            right: 14,
            bottom: -10,
            child: HomeCardsStrip(
              cards: cards,
              isBalanceHidden: isBalanceHidden,
            ),
          ),
        ],
      ),
    );
  }
}
