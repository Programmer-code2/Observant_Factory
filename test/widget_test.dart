import 'package:flutter_test/flutter_test.dart';
import 'package:observant_factory/app.dart';

void main() {
  testWidgets('App renders', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('الأماكن الرئيسية'), findsOneWidget);
  });
}
