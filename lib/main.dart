import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:xazna_bank/data/repositories/auth_repository.dart';
import 'package:xazna_bank/data/services/auth_api_service.dart';
import 'package:xazna_bank/presentation/auth/bloc/auth_bloc.dart';
import 'package:xazna_bank/presentation/splash/splash_screen.dart';

import 'core/source/api_client.dart';
import 'core/source/dio_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final repository = AuthRepository(
    AuthApiService(ApiClient(DioProvider.create())),
  );

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final AuthRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );

    return BlocProvider(
      create: (_) => AuthBloc(repository),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Xazna Bank',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: SplashScreen(repository: repository),
      ),
    );
  }
}
