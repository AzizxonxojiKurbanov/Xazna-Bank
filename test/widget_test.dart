import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xazna_bank/core/source/api_client.dart';
import 'package:xazna_bank/core/source/dio_provider.dart';
import 'package:xazna_bank/data/repositories/auth_repository.dart';
import 'package:xazna_bank/data/services/auth_api_service.dart';
import 'package:xazna_bank/presentation/home/home_screen.dart';

import 'package:xazna_bank/main.dart';

void main() {
  testWidgets('shows language screen on app start', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final repository = AuthRepository(
      AuthApiService(ApiClient(DioProvider.create())),
    );

    await tester.pumpWidget(MyApp(repository: repository));
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('"xazna"ga xush kelibsiz'), findsOneWidget);
    expect(find.text('Davom etish uchun tilni tanlang'), findsOneWidget);
    expect(find.text('KEYINGI'), findsOneWidget);
  });

  testWidgets('opens home screen when session token exists', (tester) async {
    SharedPreferences.setMockInitialValues({'access_token': 'token'});
    final repository = AuthRepository(
      AuthApiService(ApiClient(DioProvider.create())),
    );

    await tester.pumpWidget(MyApp(repository: repository));
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
