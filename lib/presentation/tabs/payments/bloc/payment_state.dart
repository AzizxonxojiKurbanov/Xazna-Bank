part of 'payment_bloc.dart';

class PaymentState {
  const PaymentState({
    this.categories = const [],
    this.services = const [],
    this.cards = const [],
    this.selectedCategoryId = 'all',
    this.selectedService,
    this.selectedCard,
    this.phone = '',
    this.amount = '',
  });

  final List<PaymentCategoryItem> categories;
  final List<PaymentServiceItem> services;
  final List<HomeBankCard> cards;
  final String selectedCategoryId;
  final PaymentServiceItem? selectedService;
  final HomeBankCard? selectedCard;
  final String phone;
  final String amount;

  List<PaymentServiceItem> get visibleServices {
    if (selectedCategoryId == 'all') return services;
    return services
        .where((service) => service.categoryId == selectedCategoryId)
        .toList();
  }

  bool get canConfirm {
    return selectedService != null &&
        selectedCard != null &&
        phone.trim().isNotEmpty &&
        amount.trim().isNotEmpty;
  }

  PaymentState copyWith({
    List<PaymentCategoryItem>? categories,
    List<PaymentServiceItem>? services,
    List<HomeBankCard>? cards,
    String? selectedCategoryId,
    PaymentServiceItem? selectedService,
    HomeBankCard? selectedCard,
    String? phone,
    String? amount,
  }) {
    return PaymentState(
      categories: categories ?? this.categories,
      services: services ?? this.services,
      cards: cards ?? this.cards,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      selectedService: selectedService ?? this.selectedService,
      selectedCard: selectedCard ?? this.selectedCard,
      phone: phone ?? this.phone,
      amount: amount ?? this.amount,
    );
  }
}
