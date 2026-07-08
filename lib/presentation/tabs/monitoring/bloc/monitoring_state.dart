part of 'monitoring_bloc.dart';

class MonitoringState {
  const MonitoringState({this.transactions = const []});

  final List<MonitoringTransaction> transactions;

  double get incomeTotal {
    return transactions
        .where((transaction) => transaction.type.isIncome)
        .fold(0, (total, transaction) => total + transaction.amount);
  }

  double get expenseTotal {
    return transactions
        .where((transaction) => transaction.type.isExpense)
        .fold(0, (total, transaction) => total + transaction.amount);
  }

  List<MonitoringTransactionGroup> get groupedTransactions {
    final sorted = [...transactions]
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
    final groups = <String, List<MonitoringTransaction>>{};

    for (final transaction in sorted) {
      final label = _formatDate(transaction.dateTime);
      groups.putIfAbsent(label, () => []).add(transaction);
    }

    return groups.entries
        .map(
          (entry) => MonitoringTransactionGroup(
            dateLabel: entry.key,
            transactions: entry.value,
          ),
        )
        .toList();
  }

  MonitoringState copyWith({List<MonitoringTransaction>? transactions}) {
    return MonitoringState(transactions: transactions ?? this.transactions);
  }
}

class MonitoringTransactionGroup {
  const MonitoringTransactionGroup({
    required this.dateLabel,
    required this.transactions,
  });

  final String dateLabel;
  final List<MonitoringTransaction> transactions;
}

String _formatDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  return '$day.$month.${date.year}';
}
