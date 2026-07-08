import 'package:flutter/material.dart';

enum MonitoringTransactionType {
  income,
  expense;

  bool get isIncome => this == MonitoringTransactionType.income;
  bool get isExpense => this == MonitoringTransactionType.expense;
}

class MonitoringTransaction {
  const MonitoringTransaction({
    required this.id,
    required this.title,
    required this.documentId,
    required this.amount,
    required this.currency,
    required this.dateTime,
    required this.type,
    required this.icon,
  });

  final String id;
  final String title;
  final String documentId;
  final double amount;
  final String currency;
  final DateTime dateTime;
  final MonitoringTransactionType type;
  final IconData icon;
}
