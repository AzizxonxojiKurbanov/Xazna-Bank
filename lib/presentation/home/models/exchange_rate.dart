class ExchangeRate {
  const ExchangeRate({
    required this.currency,
    required this.buy,
    required this.sell,
    required this.updatedAt,
  });

  final String currency;
  final num buy;
  final num sell;
  final DateTime? updatedAt;

  factory ExchangeRate.fromJson(Map<String, dynamic> json) {
    return ExchangeRate(
      currency: json['currency'] as String? ?? '',
      buy: json['buy'] as num? ?? 0,
      sell: json['sell'] as num? ?? 0,
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? ''),
    );
  }
}
