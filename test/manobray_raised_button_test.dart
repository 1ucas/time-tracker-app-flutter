import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker_flutter/common/ui/custom_widgets/manobray_raised_button.dart';

void main() {
  testWidgets('onPressed callback', (WidgetTester tester) async {
    var pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: ManobrayRaisedButton(
          child: Text('tap me'),
          onPressed: () => pressed = true,
        ),
      ),
    );
    final button = find.byType(RaisedButton);

    // Testes na Widget Tree
    expect(button, findsOneWidget);
    expect(find.byType(FlatButton), findsNothing);

    // Teste de conteúdo dos Widgets
    expect(find.text('tap me'), findsOneWidget);

    // Teste de clicar no botão
    await tester.tap(button);
    expect(pressed, true);
  });
}
