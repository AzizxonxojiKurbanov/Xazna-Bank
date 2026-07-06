class HomeBankCard {
  const HomeBankCard({
    required this.id,
    required this.maskedNumber,
    required this.holderName,
    required this.expiry,
    required this.balance,
    required this.currency,
    required this.isMain,
    required this.isBlocked,
    required this.type,
  });

  final String id;
  final String maskedNumber;
  final String holderName;
  final String expiry;
  final num balance;
  final String currency;
  final bool isMain;
  final bool isBlocked;
  final String type;

  factory HomeBankCard.fromJson(Map<String, dynamic> json) {
    return HomeBankCard(
      id: json['id'] as String? ?? '',
      maskedNumber: json['maskedNumber'] as String? ?? '',
      holderName: json['holderName'] as String? ?? '',
      expiry: json['expiry'] as String? ?? '',
      balance: json['balance'] as num? ?? 0,
      currency: json['currency'] as String? ?? 'UZS',
      isMain: json['isMain'] as bool? ?? false,
      isBlocked: json['isBlocked'] as bool? ?? false,
      type: json['type'] as String? ?? 'CARD',
    );
  }
}
