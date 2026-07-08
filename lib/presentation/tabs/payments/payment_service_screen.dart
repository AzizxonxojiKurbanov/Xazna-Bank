import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xazna_bank/presentation/tabs/payments/bloc/payment_bloc.dart';
import 'package:xazna_bank/presentation/tabs/payments/models/payment_service_item.dart';
import 'package:xazna_bank/presentation/tabs/payments/widgets/payment_form_widgets.dart';

class PaymentServiceScreen extends StatelessWidget {
  const PaymentServiceScreen({super.key, required this.service});

  final PaymentServiceItem service;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaymentBloc()
        ..add(const PaymentStarted())
        ..add(PaymentServiceSelected(service)),
      child: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          return PaymentFormShell(
            service: service,
            children: [
              const PaymentPhoneInput(),
              const SizedBox(height: 82),
              PaymentCardPicker(
                card: state.selectedCard,
                cards: state.cards,
                onSelected: (card) {
                  context.read<PaymentBloc>().add(PaymentCardChanged(card));
                },
              ),
              const SizedBox(height: 18),
              const PaymentSectionLabel("To'lov miqdori"),
              const PaymentAmountInput(),
              const SizedBox(height: 220),
              const PaymentConfirmButton(),
            ],
          );
        },
      ),
    );
  }
}
