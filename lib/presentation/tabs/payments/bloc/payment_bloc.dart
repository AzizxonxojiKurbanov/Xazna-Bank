import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xazna_bank/presentation/home/models/home_bank_card.dart';
import 'package:xazna_bank/presentation/tabs/payments/models/payment_category_item.dart';
import 'package:xazna_bank/presentation/tabs/payments/models/payment_service_item.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(const PaymentState()) {
    on<PaymentStarted>(_onStarted);
    on<PaymentCategoryChanged>(_onCategoryChanged);
    on<PaymentServiceSelected>(_onServiceSelected);
    on<PaymentPhoneChanged>(_onPhoneChanged);
    on<PaymentCardChanged>(_onCardChanged);
    on<PaymentAmountChanged>(_onAmountChanged);
  }

  void _onStarted(PaymentStarted event, Emitter<PaymentState> emit) {
    emit(
      state.copyWith(
        categories: _categories,
        services: _services,
        cards: _cards,
        selectedCategoryId: _categories.first.id,
        selectedCard: _cards.first,
      ),
    );
  }

  void _onCategoryChanged(
    PaymentCategoryChanged event,
    Emitter<PaymentState> emit,
  ) {
    emit(state.copyWith(selectedCategoryId: event.categoryId));
  }

  void _onServiceSelected(
    PaymentServiceSelected event,
    Emitter<PaymentState> emit,
  ) {
    emit(state.copyWith(selectedService: event.service));
  }

  void _onPhoneChanged(PaymentPhoneChanged event, Emitter<PaymentState> emit) {
    emit(state.copyWith(phone: event.phone));
  }

  void _onCardChanged(PaymentCardChanged event, Emitter<PaymentState> emit) {
    emit(state.copyWith(selectedCard: event.card));
  }

  void _onAmountChanged(
    PaymentAmountChanged event,
    Emitter<PaymentState> emit,
  ) {
    emit(state.copyWith(amount: event.amount));
  }
}

const _categories = <PaymentCategoryItem>[
  PaymentCategoryItem(id: 'all', title: 'ALL', icon: Icons.home_outlined),
  PaymentCategoryItem(id: 'mobile', title: 'MOBILE', icon: Icons.phone_iphone),
  PaymentCategoryItem(
    id: 'utility',
    title: 'UTILITY',
    icon: Icons.wb_sunny_outlined,
  ),
  PaymentCategoryItem(id: 'internet', title: 'INTERNET', icon: Icons.language),
  PaymentCategoryItem(id: 'other', title: 'OTHER', icon: Icons.more_horiz),
];

const _services = <PaymentServiceItem>[
  PaymentServiceItem(
    id: 'ucell',
    title: 'Ucell',
    categoryId: 'mobile',
    logoType: PaymentLogoType.ucell,
    color: Color(0xFF6D3B90),
  ),
  PaymentServiceItem(
    id: 'beeline',
    title: 'Beeline',
    categoryId: 'mobile',
    logoType: PaymentLogoType.beeline,
    color: Color(0xFFFFCD1E),
  ),
  PaymentServiceItem(
    id: 'mobiuz',
    title: 'Mobiuz',
    categoryId: 'mobile',
    logoType: PaymentLogoType.mobiuz,
    color: Color(0xFFE51D2E),
  ),
  PaymentServiceItem(
    id: 'uzmobile',
    title: 'Uzmobile',
    categoryId: 'mobile',
    logoType: PaymentLogoType.uzmobile,
    color: Color(0xFF24A9E0),
  ),
  PaymentServiceItem(
    id: 'orange',
    title: 'Orange',
    categoryId: 'internet',
    logoType: PaymentLogoType.orange,
    color: Color(0xFFFF6B1A),
  ),
  PaymentServiceItem(
    id: 'gas',
    title: 'Gaz',
    categoryId: 'utility',
    logoType: PaymentLogoType.gas,
    color: Color(0xFF5FC66A),
  ),
  PaymentServiceItem(
    id: 'electric',
    title: 'Elektr',
    categoryId: 'utility',
    logoType: PaymentLogoType.electric,
    color: Color(0xFF5FC66A),
  ),
  PaymentServiceItem(
    id: 'utility',
    title: 'Kommunal',
    categoryId: 'utility',
    logoType: PaymentLogoType.utility,
    color: Color(0xFF5FC66A),
  ),
  PaymentServiceItem(
    id: 'wave',
    title: 'Internet',
    categoryId: 'internet',
    logoType: PaymentLogoType.wave,
    color: Color(0xFF52749A),
  ),
  PaymentServiceItem(
    id: 'partner',
    title: 'ET',
    categoryId: 'other',
    logoType: PaymentLogoType.partner,
    color: Color(0xFFE33D3D),
  ),
  PaymentServiceItem(
    id: 'percent',
    title: 'Kredit',
    categoryId: 'other',
    logoType: PaymentLogoType.percent,
    color: Color(0xFF5FC66A),
  ),
  PaymentServiceItem(
    id: 'stamp',
    title: 'Davlat',
    categoryId: 'other',
    logoType: PaymentLogoType.stamp,
    color: Color(0xFF5FC66A),
  ),
];

const _cards = <HomeBankCard>[
  HomeBankCard(
    id: 'visa-card',
    maskedNumber: '8600 **** **** 1337',
    holderName: 'XAZNA VISA',
    expiry: '12/28',
    balance: 125000,
    currency: 'USD',
    isMain: true,
    isBlocked: false,
    type: 'VISA',
  ),
];
