import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sokrio_user/presentation/widgets/user_info_tile.dart';

void main() {
  testWidgets('UserInfoTile displays icon, title, and value correctly', (WidgetTester tester) async {
    // 1. Arrange: Define properties to pass into the widget
    const testIcon = Icons.email_outlined;
    const testTitle = 'Email Address';
    const testValue = 'john.doe@example.com';

    // 2. Act: Pump/render the UserInfoTile inside a standard MaterialApp scaffold shell
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: UserInfoTile(
            icon: testIcon,
            title: testTitle,
            value: testValue,
          ),
        ),
      ),
    );

    // 3. Assert: Verify that the expected Text elements and Icon are drawn on screen
    expect(find.text(testTitle), findsOneWidget);
    expect(find.text(testValue), findsOneWidget);
    expect(find.byIcon(testIcon), findsOneWidget);
  });
}
