import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xazna_bank/presentation/tabs/payments/bloc/payment_bloc.dart';
import 'package:xazna_bank/presentation/tabs/payments/models/payment_category_item.dart';
import 'package:xazna_bank/presentation/tabs/payments/models/payment_service_item.dart';
import 'package:xazna_bank/presentation/tabs/payments/payment_service_screen.dart';
import 'package:xazna_bank/presentation/tabs/payments/widgets/payment_logo_mark.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaymentBloc()..add(const PaymentStarted()),
      child: const _PaymentsView(),
    );
  }
}

class _PaymentsView extends StatelessWidget {
  const _PaymentsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F2F1),
      body: SafeArea(
        top: false,
        child: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: _PaymentsHeader(
                    categories: state.categories,
                    selectedCategoryId: state.selectedCategoryId,
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(14, 18, 14, 24),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1,
                        ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final service = state.visibleServices[index];
                      return _PaymentServiceTile(service: service);
                    }, childCount: state.visibleServices.length),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _PaymentsHeader extends StatelessWidget {
  const _PaymentsHeader({
    required this.categories,
    required this.selectedCategoryId,
  });

  final List<PaymentCategoryItem> categories;
  final String selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 56, 18, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0F3C2D), Color(0xFF62C96B)],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Expanded(
                child: Text(
                  "To'lovlar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Icon(Icons.qr_code_2, color: Colors.white, size: 34),
              SizedBox(width: 18),
              Icon(Icons.search, color: Colors.white, size: 38),
            ],
          ),
          const SizedBox(height: 28),
          Row(
            children: categories.map((category) {
              final selected = category.id == selectedCategoryId;
              return Expanded(
                child: _PaymentCategoryButton(
                  category: category,
                  selected: selected,
                  onTap: () {
                    context.read<PaymentBloc>().add(
                      PaymentCategoryChanged(category.id),
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _PaymentCategoryButton extends StatelessWidget {
  const _PaymentCategoryButton({
    required this.category,
    required this.selected,
    required this.onTap,
  });

  final PaymentCategoryItem category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: selected
                  ? const Color(0xFF5FC66A)
                  : const Color(0xFF163F30),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(category.icon, color: Colors.white, size: 25),
          ),
          const SizedBox(height: 10),
          Text(
            category.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 0,
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentServiceTile extends StatelessWidget {
  const _PaymentServiceTile({required this.service});

  final PaymentServiceItem service;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => PaymentServiceScreen(service: service),
            ),
          );
        },
        child: Center(
          child: PaymentLogoMark(
            type: service.logoType,
            color: service.color,
            size: 72,
          ),
        ),
      ),
    );
  }
}
