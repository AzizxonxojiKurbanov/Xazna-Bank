import 'package:flutter/material.dart';
import 'package:xazna_bank/presentation/tabs/transfers/between_cards_screen.dart';
import 'package:xazna_bank/presentation/tabs/transfers/card_transfer_screen.dart';

class TransfersScreen extends StatelessWidget {
  const TransfersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <_TransferItem>[
      _TransferItem(
        icon: Icons.swap_horiz,
        iconColor: const Color(0xFF00A651),
        title: "Kartaga o'tkazma",
        builder: (_) => const CardTransferScreen(),
      ),
      _TransferItem(
        icon: Icons.credit_card,
        iconColor: const Color(0xFF00A651),
        title: "Kartalarim orasida",
        builder: (_) => const BetweenCardsScreen(),
      ),
      _TransferItem(
        icon: Icons.account_balance_wallet_outlined,
        iconColor: const Color(0xFF00A651),
        title: "Hamyonga o'tkazma",
      ),
      _TransferItem(
        icon: Icons.receipt_long_outlined,
        iconColor: const Color(0xFF00A651),
        title: "Rekvizitlar bo'yicha to'lov",
      ),
      _TransferItem(
        icon: Icons.description_outlined,
        iconColor: const Color(0xFF00A651),
        title: "Hisob raqamlar orasida",
        isNew: true,
      ),
      _TransferItem(
        icon: Icons.attach_money,
        iconColor: const Color(0xFF00A651),
        title: "Konversiya",
      ),
      _TransferItem(
        icon: Icons.language,
        iconColor: const Color(0xFF00A651),
        title: "Xalqaro o'tkazmalar",
      ),
      _TransferItem(
        icon: Icons.qr_code_scanner,
        iconColor: const Color(0xFF00A651),
        title: "Pul so'rash",
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverPadding(
              padding: EdgeInsets.fromLTRB(20, 12, 20, 8),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "O'tkazmalar",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.35,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _TransferCard(item: items[index]),
                  childCount: items.length,
                ),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(top: 12)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: _TransferCard(
                  item: _TransferItem(
                    icon: Icons.landscape,
                    iconColor: const Color(0xFF00A651),
                    title: "Qirg'izistonga o'tkazma",
                    subtitle: "elcard",
                  ),
                  fullWidth: true,
                ),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
          ],
        ),
      ),
    );
  }
}

class _TransferItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final bool isNew;
  final WidgetBuilder? builder;

  _TransferItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    this.isNew = false,
    this.builder,
  });
}

class _TransferCard extends StatelessWidget {
  final _TransferItem item;
  final bool fullWidth;

  const _TransferCard({required this.item, this.fullWidth = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          final builder = item.builder;
          if (builder == null) return;
          Navigator.of(context).push(MaterialPageRoute(builder: builder));
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: fullWidth
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: item.iconColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(item.icon, color: item.iconColor, size: 20),
                  ),
                  if (item.isNew)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        "NEW",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                item.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
