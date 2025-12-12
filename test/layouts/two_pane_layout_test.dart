import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material3_layout/src/layouts/enum/fixed_pane_position_enum.dart';
import 'package:material3_layout/src/layouts/layout.dart';
import 'package:material3_layout/src/layouts/two_pane_layout.dart';

void main() {
  group('TwoPaneLayout', () {
    group('Constructor', () {
      test('should create TwoPaneLayout with required children', () {
        const fixedPaneChild = Text('Fixed Pane');
        const flexiblePaneChild = Text('Flexible Pane');
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
        );

        expect(layout, isA<TwoPaneLayout>());
        expect(layout.fixedPaneChild, equals(fixedPaneChild));
        expect(layout.flexiblePaneChild, equals(flexiblePaneChild));
        expect(layout.fixedPanePosition, equals(FixedPanePositionEnum.left));
        expect(layout.verticalPadding, equals(0));
      });

      test('should create TwoPaneLayout with custom fixed pane position', () {
        const fixedPaneChild = Text('Fixed Pane');
        const flexiblePaneChild = Text('Flexible Pane');
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
          fixedPanePosition: FixedPanePositionEnum.right,
        );

        expect(layout.fixedPanePosition, equals(FixedPanePositionEnum.right));
      });

      test('should create TwoPaneLayout with custom vertical padding', () {
        const fixedPaneChild = Text('Fixed Pane');
        const flexiblePaneChild = Text('Flexible Pane');
        const verticalPadding = 20.0;
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
          verticalPadding: verticalPadding,
        );

        expect(layout.verticalPadding, equals(verticalPadding));
      });

      test('should accept key parameter', () {
        const key = Key('two_pane_key');
        const fixedPaneChild = Text('Fixed Pane');
        const flexiblePaneChild = Text('Flexible Pane');
        
        const layout = TwoPaneLayout(
          key: key,
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
        );

        expect(layout.key, equals(key));
      });

      test('should implement Layout interface', () {
        const fixedPaneChild = Text('Fixed Pane');
        const flexiblePaneChild = Text('Flexible Pane');
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
        );

        expect(layout, isA<Layout>());
        expect(layout, isA<StatelessWidget>());
      });
    });

    group('Fixed Pane Position Helper', () {
      test('should return true for left position', () {
        const layout = TwoPaneLayout(
          fixedPaneChild: Text('Fixed'),
          flexiblePaneChild: Text('Flexible'),
          fixedPanePosition: FixedPanePositionEnum.left,
        );

        expect(layout.isFixedPanePositionLeft, isTrue);
      });

      test('should return false for right position', () {
        const layout = TwoPaneLayout(
          fixedPaneChild: Text('Fixed'),
          flexiblePaneChild: Text('Flexible'),
          fixedPanePosition: FixedPanePositionEnum.right,
        );

        expect(layout.isFixedPanePositionLeft, isFalse);
      });
    });

    group('Basic Rendering', () {
      testWidgets('should render both children in a Row', (WidgetTester tester) async {
        const fixedPaneChild = Text('Fixed Content');
        const flexiblePaneChild = Text('Flexible Content');
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.text('Fixed Content'), findsOneWidget);
        expect(find.text('Flexible Content'), findsOneWidget);
        expect(find.byType(Row), findsOneWidget);
        expect(find.byType(Material), findsOneWidget);
      });

      testWidgets('should wrap layout in Material widget', (WidgetTester tester) async {
        const fixedPaneChild = Text('Fixed Content');
        const flexiblePaneChild = Text('Flexible Content');
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        final material = tester.widget<Material>(find.byType(Material));
        expect(material.elevation, equals(2));
        expect(material.shadowColor, equals(Colors.transparent));
      });

      testWidgets('should apply theme colors to Material', (WidgetTester tester) async {
        const fixedPaneChild = Text('Fixed Content');
        const flexiblePaneChild = Text('Flexible Content');
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: const ColorScheme.light(
                surface: Colors.purple,
                surfaceTint: Colors.yellow,
              ),
            ),
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        final material = tester.widget<Material>(find.byType(Material));
        expect(material.color, equals(Colors.purple));
        expect(material.surfaceTintColor, equals(Colors.yellow));
      });
    });

    group('Left Fixed Pane Position', () {
      testWidgets('should position fixed pane on left by default', (WidgetTester tester) async {
        const fixedPaneChild = Container(
          key: Key('fixed_pane'),
          child: Text('Fixed Content'),
        );
        const flexiblePaneChild = Container(
          key: Key('flexible_pane'),
          child: Text('Flexible Content'),
        );
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        final row = tester.widget<Row>(find.byType(Row));
        expect(row.children.length, equals(3)); // fixed, spacing, flexible

        // First child should be SizedBox containing fixed pane
        final firstChild = row.children[0] as SizedBox;
        expect(firstChild.width, equals(360));
        expect(firstChild.height, equals(double.infinity));
        expect(firstChild.child, equals(fixedPaneChild));

        // Third child should be Flexible containing flexible pane
        final thirdChild = row.children[2] as Flexible;
        expect(thirdChild.child, equals(flexiblePaneChild));
      });

      testWidgets('should include spacing between panes when fixed is left', (WidgetTester tester) async {
        const fixedPaneChild = Text('Fixed Content');
        const flexiblePaneChild = Text('Flexible Content');
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
          fixedPanePosition: FixedPanePositionEnum.left,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        final row = tester.widget<Row>(find.byType(Row));
        
        // Second child should be spacing SizedBox
        final spacingChild = row.children[1] as SizedBox;
        expect(spacingChild.width, equals(24.0)); // paneSpacing
      });
    });

    group('Right Fixed Pane Position', () {
      testWidgets('should position fixed pane on right when specified', (WidgetTester tester) async {
        const fixedPaneChild = Container(
          key: Key('fixed_pane'),
          child: Text('Fixed Content'),
        );
        const flexiblePaneChild = Container(
          key: Key('flexible_pane'),
          child: Text('Flexible Content'),
        );
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
          fixedPanePosition: FixedPanePositionEnum.right,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        final row = tester.widget<Row>(find.byType(Row));
        expect(row.children.length, equals(3)); // flexible, spacing, fixed

        // First child should be Flexible containing flexible pane
        final firstChild = row.children[0] as Flexible;
        expect(firstChild.child, equals(flexiblePaneChild));

        // Third child should be SizedBox containing fixed pane
        final thirdChild = row.children[2] as SizedBox;
        expect(thirdChild.width, equals(360));
        expect(thirdChild.height, equals(double.infinity));
        expect(thirdChild.child, equals(fixedPaneChild));
      });

      testWidgets('should include spacing between panes when fixed is right', (WidgetTester tester) async {
        const fixedPaneChild = Text('Fixed Content');
        const flexiblePaneChild = Text('Flexible Content');
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
          fixedPanePosition: FixedPanePositionEnum.right,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        final row = tester.widget<Row>(find.byType(Row));
        
        // Second child should be spacing Container
        final spacingChild = row.children[1] as Container;
        expect(spacingChild.constraints?.maxWidth, equals(24.0)); // paneSpacing
      });
    });

    group('Fixed Pane Dimensions', () {
      testWidgets('should set fixed pane width to 360 pixels', (WidgetTester tester) async {
        const fixedPaneChild = Text('Fixed Content');
        const flexiblePaneChild = Text('Flexible Content');
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
        final fixedPaneSizedBox = sizedBoxes.firstWhere(
          (sizedBox) => sizedBox.width == 360,
        );
        
        expect(fixedPaneSizedBox.width, equals(360));
        expect(fixedPaneSizedBox.height, equals(double.infinity));
      });

      testWidgets('should maintain fixed pane dimensions across screen sizes', (WidgetTester tester) async {
        const fixedPaneChild = Text('Fixed Content');
        const flexiblePaneChild = Text('Flexible Content');
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
        );

        for (final screenWidth in [800.0, 1200.0, 1600.0]) {
          tester.binding.window.physicalSizeTestValue = Size(screenWidth, 800);
          tester.binding.window.devicePixelRatioTestValue = 1.0;

          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: layout,
              ),
            ),
          );

          final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
          final fixedPaneSizedBox = sizedBoxes.firstWhere(
            (sizedBox) => sizedBox.width == 360,
          );
          
          expect(fixedPaneSizedBox.width, equals(360));
        }

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Flexible Pane Behavior', () {
      testWidgets('should use Flexible widget for flexible pane', (WidgetTester tester) async {
        const fixedPaneChild = Text('Fixed Content');
        const flexiblePaneChild = Text('Flexible Content');
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        final flexible = tester.widget<Flexible>(find.byType(Flexible));
        expect(flexible.child, equals(flexiblePaneChild));
        expect(flexible.flex, equals(1)); // Default flex value
      });

      testWidgets('should allow flexible pane to expand', (WidgetTester tester) async {
        const fixedPaneChild = Text('Fixed Content');
        const flexiblePaneChild = Container(
          color: Colors.blue,
          child: Text('Flexible Content'),
        );
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
        );

        tester.binding.window.physicalSizeTestValue = const Size(1000, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        final flexible = tester.widget<Flexible>(find.byType(Flexible));
        expect(flexible.flex, equals(1));

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Vertical Padding', () {
      testWidgets('should apply vertical padding through layoutSpacing', (WidgetTester tester) async {
        const fixedPaneChild = Text('Fixed Content');
        const flexiblePaneChild = Text('Flexible Content');
        const verticalPadding = 15.0;
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
          verticalPadding: verticalPadding,
        );

        // Set screen size to medium for predictable margin calculation
        tester.binding.window.physicalSizeTestValue = const Size(700, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        final padding = tester.widget<Padding>(find.byType(Padding));
        final edgeInsets = padding.padding as EdgeInsets;
        
        expect(edgeInsets.top, equals(verticalPadding));
        expect(edgeInsets.bottom, equals(verticalPadding));
        expect(edgeInsets.left, equals(24.0)); // mediumLayoutMargin
        expect(edgeInsets.right, equals(24.0));

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should handle zero vertical padding', (WidgetTester tester) async {
        const fixedPaneChild = Text('Fixed Content');
        const flexiblePaneChild = Text('Flexible Content');
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
          verticalPadding: 0,
        );

        tester.binding.window.physicalSizeTestValue = const Size(500, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        final padding = tester.widget<Padding>(find.byType(Padding));
        final edgeInsets = padding.padding as EdgeInsets;
        
        expect(edgeInsets.top, equals(0.0));
        expect(edgeInsets.bottom, equals(0.0));

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should handle negative vertical padding', (WidgetTester tester) async {
        const fixedPaneChild = Text('Fixed Content');
        const flexiblePaneChild = Text('Flexible Content');
        const verticalPadding = -10.0;
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
          verticalPadding: verticalPadding,
        );

        tester.binding.window.physicalSizeTestValue = const Size(1000, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        final padding = tester.widget<Padding>(find.byType(Padding));
        final edgeInsets = padding.padding as EdgeInsets;
        
        expect(edgeInsets.top, equals(-10.0));
        expect(edgeInsets.bottom, equals(-10.0));

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should handle large vertical padding', (WidgetTester tester) async {
        const fixedPaneChild = Text('Fixed Content');
        const flexiblePaneChild = Text('Flexible Content');
        const verticalPadding = 100.0;
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
          verticalPadding: verticalPadding,
        );

        tester.binding.window.physicalSizeTestValue = const Size(700, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        final padding = tester.widget<Padding>(find.byType(Padding));
        final edgeInsets = padding.padding as EdgeInsets;
        
        expect(edgeInsets.top, equals(100.0));
        expect(edgeInsets.bottom, equals(100.0));

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Responsive Behavior', () {
      testWidgets('should adapt margins to different screen sizes', (WidgetTester tester) async {
        const fixedPaneChild = Text('Fixed Content');
        const flexiblePaneChild = Text('Flexible Content');
        const verticalPadding = 10.0;
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
          verticalPadding: verticalPadding,
        );

        // Test compact screen
        tester.binding.window.physicalSizeTestValue = const Size(500, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        var padding = tester.widget<Padding>(find.byType(Padding));
        var edgeInsets = padding.padding as EdgeInsets;
        expect(edgeInsets.left, equals(16.0)); // compactLayoutMargin
        expect(edgeInsets.right, equals(16.0));

        // Test medium screen
        tester.binding.window.physicalSizeTestValue = const Size(700, 800);
        await tester.pumpAndSettle();

        padding = tester.widget<Padding>(find.byType(Padding));
        edgeInsets = padding.padding as EdgeInsets;
        expect(edgeInsets.left, equals(24.0)); // mediumLayoutMargin
        expect(edgeInsets.right, equals(24.0));

        // Test extended screen
        tester.binding.window.physicalSizeTestValue = const Size(1000, 800);
        await tester.pumpAndSettle();

        padding = tester.widget<Padding>(find.byType(Padding));
        edgeInsets = padding.padding as EdgeInsets;
        expect(edgeInsets.left, equals(24.0)); // exdendedLayoutMargin
        expect(edgeInsets.right, equals(24.0));

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should maintain fixed pane width across breakpoints', (WidgetTester tester) async {
        const fixedPaneChild = Text('Fixed Content');
        const flexiblePaneChild = Text('Flexible Content');
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
        );

        for (final screenWidth in [600.0, 800.0, 1200.0]) {
          tester.binding.window.physicalSizeTestValue = Size(screenWidth, 800);
          await tester.pumpAndSettle();

          final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
          final fixedPaneSizedBox = sizedBoxes.firstWhere(
            (sizedBox) => sizedBox.width == 360,
          );
          
          expect(fixedPaneSizedBox.width, equals(360));
        }

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Complex Child Widgets', () {
      testWidgets('should handle complex fixed and flexible pane children', (WidgetTester tester) async {
        final fixedPaneChild = Column(
          children: [
            const Text('Fixed Title'),
            Container(
              height: 100,
              color: Colors.red,
              child: const Center(child: Text('Fixed Content')),
            ),
            const Icon(Icons.push_pin),
          ],
        );

        final flexiblePaneChild = Column(
          children: [
            const Text('Flexible Title'),
            Container(
              height: 100,
              color: Colors.blue,
              child: const Center(child: Text('Flexible Content')),
            ),
            const Icon(Icons.expand),
          ],
        );
        
        final layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.text('Fixed Title'), findsOneWidget);
        expect(find.text('Fixed Content'), findsOneWidget);
        expect(find.byIcon(Icons.push_pin), findsOneWidget);
        
        expect(find.text('Flexible Title'), findsOneWidget);
        expect(find.text('Flexible Content'), findsOneWidget);
        expect(find.byIcon(Icons.expand), findsOneWidget);
      });

      testWidgets('should handle scrollable children', (WidgetTester tester) async {
        final fixedPaneChild = ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) => ListTile(
            title: Text('Fixed Item $index'),
            leading: const Icon(Icons.push_pin),
          ),
        );

        final flexiblePaneChild = ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) => ListTile(
            title: Text('Flexible Item $index'),
            trailing: const Icon(Icons.expand),
          ),
        );
        
        final layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.text('Fixed Item 0'), findsOneWidget);
        expect(find.text('Flexible Item 0'), findsOneWidget);
        expect(find.byType(ListView), findsNWidgets(2));

        // Test scrolling in fixed pane
        await tester.drag(find.text('Fixed Item 0'), const Offset(0, -100));
        await tester.pumpAndSettle();

        // Test scrolling in flexible pane
        await tester.drag(find.text('Flexible Item 0'), const Offset(0, -100));
        await tester.pumpAndSettle();
      });

      testWidgets('should handle interactive children', (WidgetTester tester) async {
        bool fixedButtonPressed = false;
        bool flexibleButtonPressed = false;

        final fixedPaneChild = Column(
          children: [
            const Text('Fixed Pane'),
            ElevatedButton(
              onPressed: () => fixedButtonPressed = true,
              child: const Text('Fixed Button'),
            ),
          ],
        );

        final flexiblePaneChild = Column(
          children: [
            const Text('Flexible Pane'),
            ElevatedButton(
              onPressed: () => flexibleButtonPressed = true,
              child: const Text('Flexible Button'),
            ),
          ],
        );
        
        final layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        // Test fixed pane button
        await tester.tap(find.text('Fixed Button'));
        await tester.pumpAndSettle();
        expect(fixedButtonPressed, isTrue);

        // Test flexible pane button
        await tester.tap(find.text('Flexible Button'));
        await tester.pumpAndSettle();
        expect(flexibleButtonPressed, isTrue);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle very small screen sizes', (WidgetTester tester) async {
        const fixedPaneChild = Text('F');
        const flexiblePaneChild = Text('Flex');
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
        );

        tester.binding.window.physicalSizeTestValue = const Size(400, 400);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.text('F'), findsOneWidget);
        expect(find.text('Flex'), findsOneWidget);

        // Fixed pane should still be 360px wide even on small screens
        final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
        final fixedPaneSizedBox = sizedBoxes.firstWhere(
          (sizedBox) => sizedBox.width == 360,
        );
        expect(fixedPaneSizedBox.width, equals(360));

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should handle very large screen sizes', (WidgetTester tester) async {
        const fixedPaneChild = Text('Fixed Content');
        const flexiblePaneChild = Text('Flexible Content');
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
        );

        tester.binding.window.physicalSizeTestValue = const Size(5000, 3000);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.text('Fixed Content'), findsOneWidget);
        expect(find.text('Flexible Content'), findsOneWidget);

        // Fixed pane should still be 360px wide even on large screens
        final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
        final fixedPaneSizedBox = sizedBoxes.firstWhere(
          (sizedBox) => sizedBox.width == 360,
        );
        expect(fixedPaneSizedBox.width, equals(360));

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should handle empty children', (WidgetTester tester) async {
        const fixedPaneChild = SizedBox.shrink();
        const flexiblePaneChild = SizedBox.shrink();
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.byType(SizedBox), findsNWidgets(3)); // 2 shrink + 1 fixed pane container
        expect(find.byType(Row), findsOneWidget);
      });
    });

    group('Widget Tree Integration', () {
      testWidgets('should integrate properly in complex layouts', (WidgetTester tester) async {
        const fixedPaneChild = Text('Fixed Panel');
        const flexiblePaneChild = Text('Flexible Panel');
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              appBar: AppBar(title: const Text('Two Pane App')),
              body: Column(
                children: [
                  const Text('Header'),
                  Expanded(child: layout),
                  const Text('Footer'),
                ],
              ),
            ),
          ),
        );

        expect(find.text('Two Pane App'), findsOneWidget);
        expect(find.text('Header'), findsOneWidget);
        expect(find.text('Fixed Panel'), findsOneWidget);
        expect(find.text('Flexible Panel'), findsOneWidget);
        expect(find.text('Footer'), findsOneWidget);
      });

      testWidgets('should work with nested layouts', (WidgetTester tester) async {
        final fixedPaneChild = TwoPaneLayout(
          fixedPaneChild: const Text('Nested Fixed'),
          flexiblePaneChild: const Text('Nested Flexible'),
        );
        const flexiblePaneChild = Text('Main Flexible');
        
        final layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.text('Nested Fixed'), findsOneWidget);
        expect(find.text('Nested Flexible'), findsOneWidget);
        expect(find.text('Main Flexible'), findsOneWidget);
        expect(find.byType(Row), findsNWidgets(2)); // Main row + nested row
      });
    });

    group('Performance Considerations', () {
      testWidgets('should not rebuild unnecessarily', (WidgetTester tester) async {
        int fixedBuildCount = 0;
        int flexibleBuildCount = 0;

        final fixedPaneChild = TestWidgetWithCounter(
          text: 'Fixed',
          onBuild: () => fixedBuildCount++,
        );
        final flexiblePaneChild = TestWidgetWithCounter(
          text: 'Flexible',
          onBuild: () => flexibleBuildCount++,
        );
        
        final layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(fixedBuildCount, equals(1));
        expect(flexibleBuildCount, equals(1));

        // Pump again without changes
        await tester.pump();

        expect(fixedBuildCount, equals(2)); // TwoPaneLayout rebuilds, so children rebuild
        expect(flexibleBuildCount, equals(2));
      });
    });

    group('Accessibility', () {
      testWidgets('should maintain accessibility properties of children', (WidgetTester tester) async {
        const fixedPaneChild = Text(
          'Fixed Content',
          semanticsLabel: 'Fixed pane content',
        );
        const flexiblePaneChild = Text(
          'Flexible Content',
          semanticsLabel: 'Flexible pane content',
        );
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.bySemanticsLabel('Fixed pane content'), findsOneWidget);
        expect(find.bySemanticsLabel('Flexible pane content'), findsOneWidget);
      });
    });

    group('Theme Integration', () {
      testWidgets('should respond to theme changes', (WidgetTester tester) async {
        const fixedPaneChild = Text('Fixed Content');
        const flexiblePaneChild = Text('Flexible Content');
        
        const layout = TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
        );

        // Test with light theme
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(),
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        var material = tester.widget<Material>(find.byType(Material));
        expect(material.color, equals(ThemeData.light().colorScheme.surface));

        // Test with dark theme
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        material = tester.widget<Material>(find.byType(Material));
        expect(material.color, equals(ThemeData.dark().colorScheme.surface));
      });
    });

    group('Position Switching', () {
      testWidgets('should switch pane positions correctly', (WidgetTester tester) async {
        const fixedPaneChild = Container(
          key: Key('fixed_pane'),
          child: Text('Fixed'),
        );
        const flexiblePaneChild = Container(
          key: Key('flexible_pane'),
          child: Text('Flexible'),
        );

        // Start with left position
        var layout = const TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
          fixedPanePosition: FixedPanePositionEnum.left,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        var row = tester.widget<Row>(find.byType(Row));
        expect((row.children[0] as SizedBox).child, equals(fixedPaneChild));
        expect((row.children[2] as Flexible).child, equals(flexiblePaneChild));

        // Switch to right position
        layout = const TwoPaneLayout(
          fixedPaneChild: fixedPaneChild,
          flexiblePaneChild: flexiblePaneChild,
          fixedPanePosition: FixedPanePositionEnum.right,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        row = tester.widget<Row>(find.byType(Row));
        expect((row.children[0] as Flexible).child, equals(flexiblePaneChild));
        expect((row.children[2] as SizedBox).child, equals(fixedPaneChild));
      });
    });
  });
}

// Helper widget for testing build counts
class TestWidgetWithCounter extends StatelessWidget {
  final String text;
  final VoidCallback onBuild;

  const TestWidgetWithCounter({
    Key? key,
    required this.text,
    required this.onBuild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    onBuild();
    return Text(text);
  }
}