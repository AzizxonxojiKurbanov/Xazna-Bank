import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xazna_bank/presentation/tabs/monitoring/models/monitoring_transaction.dart';

part 'monitoring_event.dart';
part 'monitoring_state.dart';

class MonitoringBloc extends Bloc<MonitoringEvent, MonitoringState> {
  MonitoringBloc() : super(const MonitoringState()) {
    on<MonitoringStarted>(_onStarted);
    on<MonitoringRefreshed>(_onRefreshed);
  }

  void _onStarted(MonitoringStarted event, Emitter<MonitoringState> emit) {
    emit(state.copyWith(transactions: _transactions));
  }

  void _onRefreshed(MonitoringRefreshed event, Emitter<MonitoringState> emit) {
    emit(state.copyWith(transactions: _transactions));
  }
}

final _transactions = <MonitoringTransaction>[
  MonitoringTransaction(
    id: 'monitoring-subscription',
    title: 'Monitoring obunasi',
    documentId: '455945',
    amount: 2500,
    currency: 'UZS',
    dateTime: DateTime(2026, 7, 6, 20, 35),
    type: MonitoringTransactionType.expense,
    icon: Icons.shopping_bag_outlined,
  ),
];
