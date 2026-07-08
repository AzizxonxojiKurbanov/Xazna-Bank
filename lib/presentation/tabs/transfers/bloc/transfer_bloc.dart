import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xazna_bank/presentation/home/data/home_mock_data.dart';
import 'package:xazna_bank/presentation/home/models/home_bank_card.dart';
import 'package:xazna_bank/presentation/tabs/transfers/models/transfer_recipient.dart';

part 'transfer_event.dart';
part 'transfer_state.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  TransferBloc() : super(const TransferState()) {
    on<TransferStarted>(_onStarted);
    on<SenderCardChanged>(_onSenderCardChanged);
    on<ReceiverCardChanged>(_onReceiverCardChanged);
    on<RecipientCardNumberChanged>(_onRecipientCardNumberChanged);
    on<RecentRecipientSelected>(_onRecentRecipientSelected);
    on<TransferAmountChanged>(_onAmountChanged);
    on<TransferCardsSwapped>(_onCardsSwapped);
  }

  void _onStarted(TransferStarted event, Emitter<TransferState> emit) {
    final cards = _demoCards;
    emit(
      state.copyWith(
        cards: cards,
        recentRecipients: _demoRecipients,
        senderCard: cards.firstOrNull,
        receiverCard: cards.length > 1 ? cards[1] : null,
      ),
    );
  }

  void _onSenderCardChanged(
    SenderCardChanged event,
    Emitter<TransferState> emit,
  ) {
    emit(state.copyWith(senderCard: event.card));
  }

  void _onReceiverCardChanged(
    ReceiverCardChanged event,
    Emitter<TransferState> emit,
  ) {
    emit(state.copyWith(receiverCard: event.card));
  }

  void _onRecipientCardNumberChanged(
    RecipientCardNumberChanged event,
    Emitter<TransferState> emit,
  ) {
    emit(
      state.copyWith(
        recipientCardNumber: event.cardNumber,
        selectedRecipient: null,
        clearSelectedRecipient: true,
      ),
    );
  }

  void _onRecentRecipientSelected(
    RecentRecipientSelected event,
    Emitter<TransferState> emit,
  ) {
    emit(
      state.copyWith(
        selectedRecipient: event.recipient,
        recipientCardNumber: event.recipient.maskedNumber,
      ),
    );
  }

  void _onAmountChanged(
    TransferAmountChanged event,
    Emitter<TransferState> emit,
  ) {
    emit(state.copyWith(amount: event.amount));
  }

  void _onCardsSwapped(
    TransferCardsSwapped event,
    Emitter<TransferState> emit,
  ) {
    emit(
      state.copyWith(
        senderCard: state.receiverCard,
        receiverCard: state.senderCard,
      ),
    );
  }
}

final _demoCards = <HomeBankCard>[
  ...demoHomeCards,
  const HomeBankCard(
    id: 'receiver-card',
    maskedNumber: '5614 68** **** 6178',
    holderName: 'XAZNA CARD',
    expiry: '10/29',
    balance: 0,
    currency: 'UZS',
    isMain: false,
    isBlocked: false,
    type: 'UZCARD',
  ),
];

const _demoRecipients = <TransferRecipient>[
  TransferRecipient(
    id: '1',
    name: 'NURIDDIN NURMAMATOV',
    maskedNumber: '5614 68** **** 5570',
    brand: 'UZCARD',
    brandColor: Color(0xFF00639B),
  ),
  TransferRecipient(
    id: '2',
    name: 'DURDONA TAIROVA',
    maskedNumber: '5614 68** **** 7768',
    brand: 'UZCARD',
    brandColor: Color(0xFF00639B),
  ),
  TransferRecipient(
    id: '3',
    name: 'SAYYORAKHON S',
    maskedNumber: '9860 08** **** 6651',
    brand: 'HUMO',
    brandColor: Color(0xFFC4A33B),
  ),
  TransferRecipient(
    id: '4',
    name: 'TADJIKHON KURBANOVA',
    maskedNumber: '9860 08** **** 3847',
    brand: 'HUMO',
    brandColor: Color(0xFFC4A33B),
  ),
  TransferRecipient(
    id: '5',
    name: 'VOSITKHON ABDULLAEV',
    maskedNumber: '9860 35** **** 0133',
    brand: 'HUMO',
    brandColor: Color(0xFFC4A33B),
  ),
];
