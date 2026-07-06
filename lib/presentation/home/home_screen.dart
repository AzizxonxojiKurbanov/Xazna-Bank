import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xazna_bank/presentation/home/data/home_mock_data.dart';
import 'package:xazna_bank/presentation/home/models/exchange_rate.dart';
import 'package:xazna_bank/presentation/home/models/home_bank_card.dart';
import 'package:xazna_bank/presentation/home/widgets/banner_item.dart';
import 'package:xazna_bank/presentation/home/widgets/cashback_card.dart';
import 'package:xazna_bank/presentation/home/widgets/exchange_rates_card.dart';
import 'package:xazna_bank/presentation/home/widgets/home_bottom_nav.dart';
import 'package:xazna_bank/presentation/home/widgets/home_hero_section.dart';
import 'package:xazna_bank/presentation/tabs/monitoring/monitoring_screen.dart';
import 'package:xazna_bank/presentation/tabs/payments/payments_screen.dart';
import 'package:xazna_bank/presentation/tabs/services/services_screen.dart';
import 'package:xazna_bank/presentation/tabs/transfers/transfers_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isBalanceHidden = false;
  int selectedTab = 0;

  final List<HomeBankCard> cards = demoHomeCards;
  final List<ExchangeRate> exchangeRates = demoExchangeRates;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    final totalBalance = calculateCardsBalance(cards);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F3),
      bottomNavigationBar: HomeBottomNav(
        selectedIndex: selectedTab,
        onChanged: (index) => setState(() => selectedTab = index),
      ),
      body: IndexedStack(
        index: selectedTab,
        children: [
          RefreshIndicator(
            onRefresh: _refreshHome,
            color: const Color(0xFF54B96B),
            backgroundColor: Colors.white,
            strokeWidth: 2.4,
            displacement: 34,
            edgeOffset: 8,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: ClampingScrollPhysics(),
              ),
              slivers: [
                SliverToBoxAdapter(
                  child: HomeHeroSection(
                    cards: cards,
                    totalBalance: totalBalance,
                    isBalanceHidden: isBalanceHidden,
                    onToggleBalance: () {
                      setState(() => isBalanceHidden = !isBalanceHidden);
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
                    child: SizedBox(
                      height: 112,
                      child: PageView.builder(
                        controller: PageController(viewportFraction: 0.94),
                        itemCount: homeBanners.length,
                        itemBuilder: (context, index) {
                          return BannerItem(bannerModel: homeBanners[index]);
                        },
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: CashbackCard(isBalanceHidden: isBalanceHidden),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                    child: ExchangeRatesCard(rates: exchangeRates),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 22, 14, 26),
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        side: const BorderSide(
                          color: Color(0xFF55B96C),
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        foregroundColor: const Color(0xFF252A28),
                      ),
                      child: const Text(
                        'Vidjet sozlamalari',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const TransfersScreen(),
          const PaymentsScreen(),
          const MonitoringScreen(),
          const ServicesScreen(),
        ],
      ),
    );
  }

  Future<void> _refreshHome() async {
    await Future<void>.delayed(const Duration(milliseconds: 650));
  }
}
