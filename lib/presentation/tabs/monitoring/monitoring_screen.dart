import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xazna_bank/presentation/tabs/monitoring/bloc/monitoring_bloc.dart';
import 'package:xazna_bank/presentation/tabs/monitoring/models/monitoring_transaction.dart';
import 'package:xazna_bank/presentation/tabs/monitoring/widgets/monitoring_summary_card.dart';
import 'package:xazna_bank/presentation/tabs/monitoring/widgets/monitoring_transaction_tile.dart';

class MonitoringScreen extends StatelessWidget {
  const MonitoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MonitoringBloc()..add(const MonitoringStarted()),
      child: const _MonitoringView(),
    );
  }
}

class _MonitoringView extends StatelessWidget {
  const _MonitoringView();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F9F6),
        body: SafeArea(
          child: BlocBuilder<MonitoringBloc, MonitoringState>(
            builder: (context, state) {
              return RefreshIndicator(
                color: const Color(0xFF5FC66A),
                onRefresh: () async {
                  context.read<MonitoringBloc>().add(
                    const MonitoringRefreshed(),
                  );
                },
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: ClampingScrollPhysics(),
                  ),
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
                      sliver: SliverToBoxAdapter(
                        child: _Header(onFilterTap: () {}),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16, 18, 16, 22),
                      sliver: SliverToBoxAdapter(
                        child: Row(
                          children: [
                            Expanded(
                              child: MonitoringSummaryCard(
                                title: 'Kirim',
                                amount: state.incomeTotal,
                                type: MonitoringTransactionType.income,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: MonitoringSummaryCard(
                                title: 'Chiqim',
                                amount: state.expenseTotal,
                                type: MonitoringTransactionType.expense,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (state.groupedTransactions.isEmpty)
                      const SliverFillRemaining(
                        hasScrollBody: false,
                        child: _EmptyTransactions(),
                      )
                    else
                      ...state.groupedTransactions.map((group) {
                        return SliverMainAxisGroup(
                          slivers: [
                            SliverPadding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                              sliver: SliverToBoxAdapter(
                                child: Text(
                                  group.dateLabel,
                                  style: const TextStyle(
                                    color: Color(0xFF43494D),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                            SliverList.separated(
                              itemCount: group.transactions.length,
                              separatorBuilder: (_, _) => const Padding(
                                padding: EdgeInsets.only(left: 68),
                                child: Divider(
                                  height: 1,
                                  color: Color(0xFFE4E7E4),
                                ),
                              ),
                              itemBuilder: (context, index) {
                                return MonitoringTransactionTile(
                                  transaction: group.transactions[index],
                                );
                              },
                            ),
                            const SliverPadding(
                              padding: EdgeInsets.only(bottom: 20),
                            ),
                          ],
                        );
                      }),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onFilterTap});

  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Monitoring',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Color(0xFF1F2A32),
              fontSize: 28,
              fontWeight: FontWeight.w900,
              letterSpacing: 0,
            ),
          ),
        ),
        IconButton(
          tooltip: 'Filter',
          onPressed: onFilterTap,
          icon: const Icon(Icons.filter_alt_outlined),
          iconSize: 28,
          color: const Color(0xFF858C8C),
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }
}

class _EmptyTransactions extends StatelessWidget {
  const _EmptyTransactions();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Monitoring ma'lumotlari yo'q",
        style: TextStyle(
          color: Color(0xFF8A9090),
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
