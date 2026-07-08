import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xazna_bank/presentation/tabs/transfers/bloc/transfer_bloc.dart';
import 'package:xazna_bank/presentation/tabs/transfers/widgets/transfer_form_widgets.dart';

class BetweenCardsScreen extends StatelessWidget {
  const BetweenCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TransferBloc()..add(const TransferStarted()),
      child: BlocBuilder<TransferBloc, TransferState>(
        builder: (context, state) {
          return TransferPageShell(
            title: 'Kartalarim orasida',
            children: [
              const TransferSectionLabel("Jo'natuvchi"),
              TransferCardPicker(
                card: state.senderCard,
                cards: state.cards,
                placeholder: 'Kartani tanlang',
                onSelected: (card) {
                  context.read<TransferBloc>().add(SenderCardChanged(card));
                },
              ),
              const SizedBox(height: 10),
              const SwapCardsButton(),
              const SizedBox(height: 10),
              const TransferSectionLabel('Qabul qiluvchi'),
              TransferCardPicker(
                card: state.receiverCard,
                cards: state.cards,
                placeholder: 'Kartani tanlang',
                onSelected: (card) {
                  context.read<TransferBloc>().add(ReceiverCardChanged(card));
                },
              ),
              const SizedBox(height: 22),
              const TransferSectionLabel("O'tkazma miqdori"),
              const AmountInput(),
              const SizedBox(height: 24),
              const TransferNextButton(),
            ],
          );
        },
      ),
    );
  }
}
