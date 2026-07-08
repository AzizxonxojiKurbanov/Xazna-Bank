import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xazna_bank/presentation/home/models/home_bank_card.dart';
import 'package:xazna_bank/presentation/tabs/transfers/bloc/transfer_bloc.dart';
import 'package:xazna_bank/presentation/tabs/transfers/models/transfer_recipient.dart';

const transferGreen = Color(0xFF54B96B);
const transferText = Color(0xFF202426);
const transferMuted = Color(0xFF777D80);
const transferBorder = Color(0xFFE1E4E2);
const transferFieldBg = Color(0xFFF8FAF8);

class TransferPageShell extends StatelessWidget {
  const TransferPageShell({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 52,
              child: Row(
                children: [
                  _BackButton(onTap: () => Navigator.pop(context)),
                  Expanded(
                    child: Center(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: transferText,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 44),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 14),
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransferSectionLabel extends StatelessWidget {
  const TransferSectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF555A5D),
          fontSize: 15,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class TransferCardPicker extends StatelessWidget {
  const TransferCardPicker({
    super.key,
    required this.card,
    required this.cards,
    required this.placeholder,
    required this.onSelected,
  });

  final HomeBankCard? card;
  final List<HomeBankCard> cards;
  final String placeholder;
  final ValueChanged<HomeBankCard> onSelected;

  @override
  Widget build(BuildContext context) {
    return _FieldFrame(
      onTap: () => _showCards(context),
      child: Row(
        children: [
          if (card == null) ...[
            const _RoundIcon(icon: Icons.add, color: transferGreen),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                placeholder,
                style: const TextStyle(
                  color: transferText,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ] else ...[
            CardBrandMark(type: card!.type),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${_formatAmount(card!.balance)} ${card!.currency}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: transferText,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${card!.maskedNumber}  •  ${card!.type.toLowerCase()}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF5D6265),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(width: 8),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color(0xFF8B9092),
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
              return _FieldFrame(
                compact: true,
                onTap: () {
                  Navigator.pop(context);
                  onSelected(item);
                },
                child: Row(
                  children: [
                    CardBrandMark(type: item.type),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '${item.maskedNumber}  •  ${_formatAmount(item.balance)} ${item.currency}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: transferText,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class RecipientCardInput extends StatefulWidget {
  const RecipientCardInput({super.key});

  @override
  State<RecipientCardInput> createState() => _RecipientCardInputState();
}

class _RecipientCardInputState extends State<RecipientCardInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransferBloc, TransferState>(
      listenWhen: (previous, current) =>
          previous.recipientCardNumber != current.recipientCardNumber,
      listener: (context, state) {
        if (_controller.text != state.recipientCardNumber) {
          _controller.text = state.recipientCardNumber;
          _controller.selection = TextSelection.collapsed(
            offset: _controller.text.length,
          );
        }
      },
      child: _FieldFrame(
        child: Row(
          children: [
            const Icon(Icons.credit_card, color: transferGreen, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                ],
                onChanged: (value) {
                  context.read<TransferBloc>().add(
                    RecipientCardNumberChanged(value),
                  );
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  hintText: '0000 0000 0000 0000',
                  hintStyle: TextStyle(
                    color: Color(0xFFB7BBBD),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: const TextStyle(
                  color: transferText,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.qr_code_scanner, color: Color(0xFF555A5D)),
          ],
        ),
      ),
    );
  }
}

class AmountInput extends StatelessWidget {
  const AmountInput({super.key});

  @override
  Widget build(BuildContext context) {
    return _FieldFrame(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                context.read<TransferBloc>().add(TransferAmountChanged(value));
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: "0 so'm",
                hintStyle: TextStyle(
                  color: Color(0xFFB7BBBD),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: const TextStyle(
                color: transferText,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const Icon(Icons.attach_money, color: transferGreen, size: 24),
        ],
      ),
    );
  }
}

class RecentRecipientsList extends StatelessWidget {
  const RecentRecipientsList({super.key, required this.recipients});

  final List<TransferRecipient> recipients;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(child: TransferSectionLabel('Oxirgi qabul qiluvchilar')),
            Text(
              'Barchasi',
              style: TextStyle(
                color: Color(0xFF8B9092),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 4),
            Icon(Icons.chevron_right, color: Color(0xFFD0D3D1), size: 20),
          ],
        ),
        const SizedBox(height: 2),
        ...recipients.map((recipient) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _FieldFrame(
              compact: true,
              onTap: () {
                context.read<TransferBloc>().add(
                  RecentRecipientSelected(recipient),
                );
              },
              child: Row(
                children: [
                  CardBrandMark(
                    type: recipient.brand,
                    color: recipient.brandColor,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          recipient.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: transferText,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          recipient.maskedNumber,
                          style: const TextStyle(
                            color: Color(0xFF64696C),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

class TransferNextButton extends StatelessWidget {
  const TransferNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferBloc, TransferState>(
      builder: (context, state) {
        return SizedBox(
          height: 52,
          width: double.infinity,
          child: FilledButton(
            onPressed: state.canContinue ? () {} : null,
            style: FilledButton.styleFrom(
              backgroundColor: transferGreen,
              disabledBackgroundColor: const Color(0xFFE1E8E2),
              foregroundColor: Colors.white,
              disabledForegroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Keyingi',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            ),
          ),
        );
      },
    );
  }
}

class SwapCardsButton extends StatelessWidget {
  const SwapCardsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () =>
            context.read<TransferBloc>().add(const TransferCardsSwapped()),
        child: const CircleAvatar(
          radius: 18,
          backgroundColor: transferGreen,
          child: Icon(Icons.swap_vert, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}

class CardBrandMark extends StatelessWidget {
  const CardBrandMark({super.key, required this.type, this.color});

  final String type;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final normalized = type.toUpperCase();
    if (normalized.contains('UZCARD')) {
      return Image.asset('assets/images/uzcard.png', width: 34, height: 34);
    }

    return SizedBox(
      width: 34,
      height: 34,
      child: Center(
        child: Text(
          'H',
          style: TextStyle(
            color: color ?? const Color(0xFFC4A33B),
            fontSize: 26,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: 44,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(12),
          ),
        ),
        child: const Icon(
          Icons.chevron_left,
          color: Color(0xFF8B9092),
          size: 28,
        ),
      ),
    );
  }
}

class _RoundIcon extends StatelessWidget {
  const _RoundIcon({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 21,
      backgroundColor: color.withValues(alpha: 0.12),
      child: Icon(icon, color: color, size: 24),
    );
  }
}

class _FieldFrame extends StatelessWidget {
  const _FieldFrame({required this.child, this.onTap, this.compact = false});

  final Widget child;
  final VoidCallback? onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: transferFieldBg,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          constraints: BoxConstraints(minHeight: compact ? 58 : 62),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: transferBorder),
            borderRadius: BorderRadius.circular(16),
          ),
          child: child,
        ),
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
