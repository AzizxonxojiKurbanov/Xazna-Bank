import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cardNameController = TextEditingController();

  int selectedDesign = 0;

  bool get isFormValid {
    final cardDigits = cardNumberController.text.replaceAll(' ', '');
    final expiryDigits = expiryController.text.replaceAll('/', '');
    return cardDigits.length == 16 && expiryDigits.length == 4;
  }

  @override
  void initState() {
    super.initState();
    cardNumberController.addListener(_refreshForm);
    expiryController.addListener(_refreshForm);
    cardNameController.addListener(_refreshForm);
  }

  @override
  void dispose() {
    cardNumberController
      ..removeListener(_refreshForm)
      ..dispose();
    expiryController
      ..removeListener(_refreshForm)
      ..dispose();
    cardNameController
      ..removeListener(_refreshForm)
      ..dispose();
    super.dispose();
  }

  void _refreshForm() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(14, 8, 14, 16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 24,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _AddCardHeader(
                          onBack: () => Navigator.of(context).pop(),
                        ),
                        const SizedBox(height: 22),
                        _CardPreview(
                          selectedDesign: selectedDesign,
                          cardNumberController: cardNumberController,
                          expiryController: expiryController,
                        ),
                        const SizedBox(height: 14),
                        _DesignSelector(
                          selectedIndex: selectedDesign,
                          onSelected: (index) {
                            setState(() => selectedDesign = index);
                          },
                        ),
                        const SizedBox(height: 26),
                        const _InputLabel('Karta nomi'),
                        const SizedBox(height: 8),
                        TextField(
                          controller: cardNameController,
                          textInputAction: TextInputAction.done,
                          style: const TextStyle(
                            color: Color(0xFF252A28),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: _inputDecoration('Karta nomini kiriting'),
                        ),
                        const SizedBox(height: 28),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: isFormValid
                                ? () => Navigator.of(context).pop()
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF61C36A),
                              disabledBackgroundColor: const Color(0xFFF3F5F3),
                              foregroundColor: Colors.white,
                              disabledForegroundColor: const Color(0xFF9EA2A5),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Qo'shish",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _AddCardHeader extends StatelessWidget {
  const _AddCardHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: onBack,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE7E8EA)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.chevron_left,
                    color: Color(0xFF9EA2A5),
                    size: 26,
                  ),
                ),
              ),
            ),
          ),
          const Text(
            "Karta qo'shing",
            style: TextStyle(
              color: Color(0xFF1F2428),
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 0,
            ),
          ),
        ],
      ),
    );
  }
}

class _CardPreview extends StatelessWidget {
  const _CardPreview({
    required this.selectedDesign,
    required this.cardNumberController,
    required this.expiryController,
  });

  final int selectedDesign;
  final TextEditingController cardNumberController;
  final TextEditingController expiryController;

  @override
  Widget build(BuildContext context) {
    final colors = _cardColors[selectedDesign % _cardColors.length];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 120,
            top: -70,
            bottom: -80,
            child: Container(
              width: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.07),
                  width: 24,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const _CardFieldLabel('Karta raqami'),
              const SizedBox(height: 7),
              TextField(
                controller: cardNumberController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  _CardNumberInputFormatter(),
                ],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
                decoration: _previewInputDecoration(
                  hintText: '0000 0000 0000 0000',
                  suffixIcon: Icons.document_scanner_outlined,
                ),
              ),
              const SizedBox(height: 18),
              const _CardFieldLabel('Amal qilish muddati'),
              const SizedBox(height: 7),
              SizedBox(
                width: 84,
                child: TextField(
                  controller: expiryController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                    _ExpiryInputFormatter(),
                  ],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                  decoration: _previewInputDecoration(hintText: 'MM/YY'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DesignSelector extends StatelessWidget {
  const _DesignSelector({
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _cardColors.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 74,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: _cardColors[index],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF61C36A)
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -22,
                    top: -18,
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.13),
                          width: 10,
                        ),
                      ),
                    ),
                  ),
                  if (isSelected)
                    Center(
                      child: Container(
                        width: 26,
                        height: 26,
                        decoration: const BoxDecoration(
                          color: Color(0xFF72D36F),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 19,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InputLabel extends StatelessWidget {
  const _InputLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF45494D),
        fontSize: 14,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

class _CardFieldLabel extends StatelessWidget {
  const _CardFieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

InputDecoration _inputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(
      color: Color(0xFFA5A9A7),
      fontSize: 13,
      fontWeight: FontWeight.w500,
    ),
    filled: true,
    fillColor: const Color(0xFFF7F9F7),
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFE1E4E2), width: 1.2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF61C36A), width: 1.2),
    ),
  );
}

InputDecoration _previewInputDecoration({
  required String hintText,
  IconData? suffixIcon,
}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.white.withValues(alpha: 0.96),
      fontSize: 15,
      fontWeight: FontWeight.w700,
      letterSpacing: 1,
    ),
    suffixIcon: suffixIcon == null
        ? null
        : Icon(suffixIcon, color: Colors.white, size: 22),
    filled: true,
    fillColor: Colors.white.withValues(alpha: 0.08),
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Colors.white.withValues(alpha: 0.26),
        width: 1.2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF65C96D), width: 1.2),
    ),
  );
}

class _CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();

    for (var index = 0; index < digits.length; index++) {
      if (index > 0 && index % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(digits[index]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class _ExpiryInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll('/', '');
    final buffer = StringBuffer();

    for (var index = 0; index < digits.length; index++) {
      if (index == 2) {
        buffer.write('/');
      }
      buffer.write(digits[index]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

const List<List<Color>> _cardColors = [
  [Color(0xFF14A494), Color(0xFF0F867B)],
  [Color(0xFF063E24), Color(0xFF0AA36D)],
  [Color(0xFF456E5C), Color(0xFF7B907D)],
  [Color(0xFF050706), Color(0xFF214835)],
  [Color(0xFF0D5541), Color(0xFF195F50)],
];
