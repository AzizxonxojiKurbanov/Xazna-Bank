import 'package:flutter/material.dart';
import 'package:xazna_bank/presentation/home/models/banner_model.dart';
import 'package:xazna_bank/presentation/home/models/exchange_rate.dart';
import 'package:xazna_bank/presentation/home/models/home_bank_card.dart';
import 'package:xazna_bank/presentation/home/models/payment_category.dart';

const homePaymentCategories = [
  PaymentCategory(title: 'XaznaPay', icon: Icons.qr_code_scanner),
  PaymentCategory(title: 'XaznaPass', icon: Icons.document_scanner_outlined),
  PaymentCategory(title: 'Alipay+', icon: Icons.add_card),
  PaymentCategory(title: 'HumoPay', icon: Icons.credit_card),
  PaymentCategory(title: 'Mobile', icon: Icons.phone_iphone),
  PaymentCategory(title: "QR to'lov", icon: Icons.qr_code_2),
];

const homeBanners = [
  BannerModel(
    title: "Kredit so'ndirish",
    subtitle: "Xalq banki kreditlarini komissiyasiz (0%) to'lang",
    image: 'assets/images/xazna_logo.png',
  ),
  BannerModel(
    title: 'Mobil aloqa',
    subtitle: "Barcha mobil operatorlarga tez va qulay to'lov qiling",
    image: 'assets/images/xazna_logo.png',
  ),
  BannerModel(
    title: "Kommunal to'lovlar",
    subtitle: "Gaz, elektr va suv xizmatlarini to'lang",
    image: 'assets/images/xazna_logo.png',
  ),
  BannerModel(
    title: "Kartaga o'tkazma",
    subtitle: 'Istalgan bank kartasiga bir zumda pul yuboring',
    image: 'assets/images/xazna_logo.png',
  ),
  BannerModel(
    title: 'Internet provayder',
    subtitle: "Internet va TV xizmatlari uchun to'lov qiling",
    image: 'assets/images/xazna_logo.png',
  ),
];

const demoHomeCards = [
  HomeBankCard(
    id: '550e8400-e29b-41d4-a716-446655440000',
    maskedNumber: '8600 **** **** 1234',
    holderName: 'ALISHER UMAROV',
    expiry: '12/28',
    balance: 150000,
    currency: 'UZS',
    isMain: true,
    isBlocked: false,
    type: 'UZCARD',
  ),
];

final demoExchangeRates = [
  ExchangeRate.fromJson(const {
    'currency': 'USD',
    'buy': 12700,
    'sell': 12750,
    'updatedAt': '2026-07-05T15:40:10.152Z',
  }),
];

num calculateCardsBalance(List<HomeBankCard> cards) {
  return cards.fold<num>(
    0,
    (sum, card) => sum + (card.isBlocked ? 0 : card.balance),
  );
}
