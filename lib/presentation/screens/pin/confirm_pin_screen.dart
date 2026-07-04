import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xazna_bank/presentation/auth/bloc/auth_bloc.dart';
import 'package:xazna_bank/presentation/home/home_screen.dart';
import 'package:xazna_bank/presentation/screens/pin/pin_screen.dart';

class ConfirmPinScreen extends StatefulWidget {
  final String pin;

  const ConfirmPinScreen({super.key, required this.pin});

  @override
  State<ConfirmPinScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen> {
  String confirmPin = '';

  void _onKeyTap(String key) {
    setState(() {
      if (key == 'del') {
        if (confirmPin.isNotEmpty) {
          confirmPin = confirmPin.substring(0, confirmPin.length - 1);
        }
        return;
      }

      if (confirmPin.length < 4) {
        confirmPin += key;
      }
    });

    if (confirmPin.length == 4) {
      if (confirmPin != widget.pin) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('PIN-kodlar mos emas')));
        setState(() => confirmPin = '');
        return;
      }

      context.read<AuthBloc>().add(SetPinRequested(confirmPin));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SetPinSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomeScreen()),
          );
        }

        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          setState(() => confirmPin = '');
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            PinInputScaffold(
              title: 'PIN-kodni tasdiqlang',
              subtitle:
                  'Xavfsizlik uchun tanlagan PIN-kodingizni qayta kiriting',
              filledCount: confirmPin.length,
              onKeyTap: state is AuthLoading ? (_) {} : _onKeyTap,
            ),
            if (state is AuthLoading)
              Container(
                color: Colors.black.withAlpha(80),
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        );
      },
    );
  }
}
