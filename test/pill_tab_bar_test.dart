import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pill_tab_bar/pill_tab_bar.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(
        home: Scaffold(
          body: Center(child: SizedBox(width: 240, child: child)),
        ),
      );

  testWidgets('renders all tab labels', (tester) async {
    await tester.pumpWidget(
      wrap(
        PillTabBar(
          tabs: const [
            PillTab(label: 'One'),
            PillTab(label: 'Two'),
            PillTab(label: 'Three'),
          ],
          index: 0,
          onChanged: (_) {},
        ),
      ),
    );

    expect(find.text('One'), findsOneWidget);
    expect(find.text('Two'), findsOneWidget);
    expect(find.text('Three'), findsOneWidget);
  });

  testWidgets('tapping a tab fires onChanged with that index', (tester) async {
    int? received;
    await tester.pumpWidget(
      wrap(
        PillTabBar(
          tabs: const [
            PillTab(label: 'A'),
            PillTab(label: 'B'),
          ],
          index: 0,
          onChanged: (i) => received = i,
        ),
      ),
    );

    await tester.tap(find.text('B'));
    await tester.pumpAndSettle();

    expect(received, 1);
  });

  testWidgets('renders icon when provided', (tester) async {
    await tester.pumpWidget(
      wrap(
        PillTabBar(
          tabs: const [
            PillTab(label: 'Edit', icon: Icons.edit),
            PillTab(label: 'Read'),
          ],
          index: 0,
          onChanged: (_) {},
        ),
      ),
    );

    expect(find.byIcon(Icons.edit), findsOneWidget);
  });

  testWidgets('asserts on out-of-range index', (tester) async {
    expect(
      () => PillTabBar(
        tabs: const [
          PillTab(label: 'A'),
          PillTab(label: 'B'),
        ],
        index: 5,
        onChanged: (_) {},
      ),
      throwsAssertionError,
    );
  });
}
