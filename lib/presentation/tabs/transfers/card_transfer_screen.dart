import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xazna_bank/presentation/tabs/transfers/bloc/transfer_bloc.dart';
import 'package:xazna_bank/presentation/tabs/transfers/widgets/transfer_form_widgets.dart';

class CardTransferScreen extends StatelessWidget {
  const CardTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TransferBloc()..add(const TransferStarted()),
      child: BlocBuilder<TransferBloc, TransferState>(
        builder: (context, state) {
          return TransferPageShell(
            title: "Kartaga o'tkazma",
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
              const SizedBox(height: 20),
              const TransferSectionLabel('Qabul qiluvchi'),
              const RecipientCardInput(),
              const SizedBox(height: 20),
              const TransferSectionLabel("O'tkazma miqdori"),
              const AmountInput(),
              const SizedBox(height: 18),
              RecentRecipientsList(recipients: state.recentRecipients),
              const SizedBox(height: 10),
              const TransferNextButton(),
            ],
          );
        },
      ),
    );
  }
}
