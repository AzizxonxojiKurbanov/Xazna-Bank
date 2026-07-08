part of 'payment_bloc.dart';

sealed class PaymentEvent {
  const PaymentEvent();
}

class PaymentStarted extends PaymentEvent {
  const PaymentStarted();
}

class PaymentCategoryChanged extends PaymentEvent {
  const PaymentCategoryChanged(this.categoryId);

  final String categoryId;
}

class PaymentServiceSelected extends PaymentEvent {
  const PaymentServiceSelected(this.service);

  final PaymentServiceItem service;
}

class PaymentPhoneChanged extends PaymentEvent {
  const PaymentPhoneChanged(this.phone);

  final String phone;
}

class PaymentCardChanged extends PaymentEvent {
  const PaymentCardChanged(this.card);

  final HomeBankCard card;
}

class PaymentAmountChanged extends PaymentEvent {
  const PaymentAmountChanged(this.amount);

  final String amount;
}
