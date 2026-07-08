import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xazna_bank/presentation/home/models/home_bank_card.dart';
import 'package:xazna_bank/presentation/tabs/payments/bloc/payment_bloc.dart';
import 'package:xazna_bank/presentation/tabs/payments/models/payment_service_item.dart';
import 'package:xazna_bank/presentation/tabs/payments/widgets/payment_logo_mark.dart';

const paymentGreen = Color(0xFF5FC66A);
const paymentText = Color(0xFF111416);
const paymentMuted = Color(0xFF98A09D);
const paymentBorder = Color(0xFFAAB5B0);
const paymentFieldBg = Color(0xFFF7F8F8);

class PaymentFormShell extends StatelessWidget {
  const PaymentFormShell({
    super.key,
    required this.service,
    required this.children,
  });

  final PaymentServiceItem service;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 56,
              child: Row(
                children: [
                  _PaymentBackButton(onTap: () => Navigator.pop(context)),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PaymentLogoMark(
                          type: service.logoType,
                          color: service.color,
                          size: 34,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            service.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: paymentText,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 44),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 64, 18, 16),
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentTextFieldFrame extends StatelessWidget {
  const PaymentTextFieldFrame({
    super.key,
    required this.child,
    this.onTap,
    this.height = 56,
  });

  final Widget child;
  final VoidCallback? onTap;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: paymentFieldBg,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          constraints: BoxConstraints(minHeight: height),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: paymentBorder, width: 1.2),
            borderRadius: BorderRadius.circular(14),
          ),
          child: child,
        ),
      ),
    );
  }
}

class PaymentPhoneInput extends StatelessWidget {
  const PaymentPhoneInput({super.key});

  @override
  Widget build(BuildContext context) {
    return PaymentTextFieldFrame(
      child: TextField(
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
          LengthLimitingTextInputFormatter(13),
        ],
        onChanged: (value) {
          context.read<PaymentBloc>().add(PaymentPhoneChanged(value));
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          hintText: '+998 00 000 00 00',
          hintStyle: TextStyle(
            color: Color(0xFFB0B8B5),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: const TextStyle(
          color: paymentText,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class PaymentCardPicker extends StatelessWidget {
  const PaymentCardPicker({
    super.key,
    required this.card,
    required this.cards,
    required this.onSelected,
  });

  final HomeBankCard? card;
  final List<HomeBankCard> cards;
  final ValueChanged<HomeBankCard> onSelected;

  @override
  Widget build(BuildContext context) {
    return PaymentTextFieldFrame(
      height: 68,
      onTap: () => _showCards(context),
      child: Row(
        children: [
          const Text(
            'VISA',
            style: TextStyle(
              color: Color(0xFF2478A8),
              fontSize: 15,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  card == null
                      ? 'Kartani tanlang'
                      : '${_formatAmount(card!.balance)} ${card!.currency}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: paymentText,
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                if (card != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    card!.maskedNumber,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: paymentMuted,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color(0xFFA2AAA7),
            size: 28,
          ),
        ],
      ),
    );
  }

  void _showCards(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return SafeArea(
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
            itemCount: cards.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = cards[index];
              return PaymentTextFieldFrame(
                onTap: () {
                  Navigator.pop(context);
                  onSelected(item);
                },
                child: Text(
                  '${item.maskedNumber}  •  ${_formatAmount(item.balance)} ${item.currency}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: paymentText,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class PaymentAmountInput extends StatelessWidget {
  const PaymentAmountInput({super.key});

  @override
  Widget build(BuildContext context) {
    return PaymentTextFieldFrame(
      child: TextField(
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          context.read<PaymentBloc>().add(PaymentAmountChanged(value));
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          hintText: "0 so'm",
          hintStyle: TextStyle(
            color: Color(0xFFB0B8B5),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: const TextStyle(
          color: paymentText,
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class PaymentSectionLabel extends StatelessWidget {
  const PaymentSectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: paymentMuted,
          fontSize: 16,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class PaymentConfirmButton extends StatelessWidget {
  const PaymentConfirmButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        return SizedBox(
          height: 52,
          width: double.infinity,
          child: FilledButton(
            onPressed: state.canConfirm ? () {} : null,
            style: FilledButton.styleFrom(
              backgroundColor: paymentGreen,
              disabledBackgroundColor: const Color(0xFFE0E7E2),
              foregroundColor: Colors.white,
              disabledForegroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Tasdiqlash',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
            ),
          ),
        );
      },
    );
  }
}

class _PaymentBackButton extends StatelessWidget {
  const _PaymentBackButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.horizontal(right: Radius.circular(12)),
      onTap: onTap,
      child: const SizedBox(
        width: 44,
        height: 40,
        child: Icon(Icons.chevron_left, color: Color(0xFF95A09C), size: 30),
      ),
    );
  }
}

String _formatAmount(num value) {
  final raw = value.round().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < raw.length; i++) {
    final reverseIndex = raw.length - i;
    buffer.write(raw[i]);
    if (reverseIndex > 1 && reverseIndex % 3 == 1) {
      buffer.write(' ');
    }
  }
  return buffer.toString();
}
