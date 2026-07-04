import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xazna_bank/presentation/auth/bloc/auth_bloc.dart';
import 'package:xazna_bank/presentation/screens/pin/pin_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phone;

  const OtpScreen({super.key, required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is VerifyOtpSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const PinScreen()),
          );
        }

        if (state is SendOtpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('SMS kod qayta yuborildi')),
          );
        }

        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF101C1B),
                  Color(0xFF123329),
                  Color(0xFF0F4635),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 42),
                  const Center(
                    child: Text(
                      'SMS kodni kiriting',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Center(
                    child: Text(
                      '${widget.phone} raqamiga yuborilgan 6 xonali kodni kiriting',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFB8C5BF),
                        fontSize: 15,
                        height: 1.25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2B4E41),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green, width: 1.2),
                    ),
                    alignment: Alignment.center,
                    child: TextField(
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 8,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '------',
                        hintStyle: TextStyle(
                          color: Colors.white38,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 8,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Center(
                    child: TextButton(
                      onPressed: state is AuthLoading
                          ? null
                          : () {
                              context.read<AuthBloc>().add(
                                SendOtpRequested(widget.phone),
                              );
                            },
                      child: const Text(
                        'Kodni qayta yuborish',
                        style: TextStyle(
                          color: Color(0xFF66D06D),
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF2D5A49),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: state is AuthLoading
                          ? null
                          : () {
                              final otp = otpController.text.trim();
                              if (otp.length != 6) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('6 xonali kodni kiriting'),
                                  ),
                                );
                                return;
                              }

                              context.read<AuthBloc>().add(
                                VerifyOtpRequested(
                                  phone: widget.phone,
                                  otp: otp,
                                ),
                              );
                            },
                      child: state is AuthLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text(
                              'TASDIQLASH',
                              style: TextStyle(
                                color: Color(0xFFB9C8C0),
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 36),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
