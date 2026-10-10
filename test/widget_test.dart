// Smoke tests for the Tawana Foundation website.
//
// The previous file was the default counter template: it imported
// `package:tawanaweb/main.dart` and `MyApp`, neither of which exists in this
// package (`tawanafoundation`), so `flutter analyze` / `flutter test` failed.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tawanafoundation/app/app.dart';
import 'package:tawanafoundation/core/widgets/responsive_grid.dart';

void main() {
  group('LocaleNotifier', () {
    test('restores a supported saved language', () {
      expect(LocaleNotifier('ps').state, const Locale('ps'));
    });

    test('falls back to English for missing or unsupported codes', () {
      expect(LocaleNotifier(null).state, const Locale('en'));
      expect(LocaleNotifier('de').state, const Locale('en'));
    });

    test('persists the selected language', () async {
      SharedPreferences.setMockInitialValues({});
      final notifier = LocaleNotifier(null);
      await notifier.set(const Locale('fa'));
      final prefs = await SharedPreferences.getInstance();
      expect(notifier.state, const Locale('fa'));
      expect(prefs.getString(LocaleNotifier.prefsKey), 'fa');
    });
  });

  testWidgets('ResponsiveGrid sizes rows to content without overflow at 280 px',
      (tester) async {
    tester.view.physicalSize = const Size(280, 653);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ResponsiveGrid(
              columns: 2,
              children: List.generate(
                5,
                (i) => Card(
                  child: Text('Card $i ' * (i + 1) * 4),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.byType(Card), findsNWidgets(5));
  });
}
