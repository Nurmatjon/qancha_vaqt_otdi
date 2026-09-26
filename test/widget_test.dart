import 'package:flutter_test/flutter_test.dart';

import 'package:qancha_vaqt_otdi/main.dart';

void main() {
  testWidgets('Qancha vaqt o‘tdi ilovasi ishga tushadi', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const QanchaVaqtOtdiApp());

    expect(find.text('How Much Time Has Passed?'), findsOneWidget);
  });
}
