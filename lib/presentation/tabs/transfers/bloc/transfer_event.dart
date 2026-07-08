part of 'transfer_bloc.dart';

sealed class TransferEvent {
  const TransferEvent();
}

class TransferStarted extends TransferEvent {
  const TransferStarted();
}

class SenderCardChanged extends TransferEvent {
  const SenderCardChanged(this.card);

  final HomeBankCard card;
}

class ReceiverCardChanged extends TransferEvent {
  const ReceiverCardChanged(this.card);

  final HomeBankCard card;
}

class RecipientCardNumberChanged extends TransferEvent {
  const RecipientCardNumberChanged(this.cardNumber);

  final String cardNumber;
}

class RecentRecipientSelected extends TransferEvent {
  const RecentRecipientSelected(this.recipient);

  final TransferRecipient recipient;
}

class TransferAmountChanged extends TransferEvent {
  const TransferAmountChanged(this.amount);

  final String amount;
}

class TransferCardsSwapped extends TransferEvent {
  const TransferCardsSwapped();
}
