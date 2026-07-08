part of 'transfer_bloc.dart';

class TransferState {
  const TransferState({
    this.cards = const [],
    this.recentRecipients = const [],
    this.senderCard,
    this.receiverCard,
    this.selectedRecipient,
    this.recipientCardNumber = '',
    this.amount = '',
  });

  final List<HomeBankCard> cards;
  final List<TransferRecipient> recentRecipients;
  final HomeBankCard? senderCard;
  final HomeBankCard? receiverCard;
  final TransferRecipient? selectedRecipient;
  final String recipientCardNumber;
  final String amount;

  bool get canContinue {
    return senderCard != null &&
        amount.trim().isNotEmpty &&
        (receiverCard != null ||
            selectedRecipient != null ||
            recipientCardNumber.trim().length >= 16);
  }

  TransferState copyWith({
    List<HomeBankCard>? cards,
    List<TransferRecipient>? recentRecipients,
    HomeBankCard? senderCard,
    HomeBankCard? receiverCard,
    TransferRecipient? selectedRecipient,
    String? recipientCardNumber,
    String? amount,
    bool clearSelectedRecipient = false,
  }) {
    return TransferState(
      cards: cards ?? this.cards,
      recentRecipients: recentRecipients ?? this.recentRecipients,
      senderCard: senderCard ?? this.senderCard,
      receiverCard: receiverCard ?? this.receiverCard,
      selectedRecipient: clearSelectedRecipient
          ? null
          : selectedRecipient ?? this.selectedRecipient,
      recipientCardNumber: recipientCardNumber ?? this.recipientCardNumber,
      amount: amount ?? this.amount,
    );
  }
}
