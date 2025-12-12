import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material3_layout/src/layouts/layout.dart';
import 'package:material3_layout/src/layouts/split_pane_layout.dart';

void main() {
  group('SplitPaneLayout', () {
    group('Constructor', () {
      test('should create SplitPaneLayout with required children', () {
        const leftChild = Text('Left Child');
        const rightChild = Text('Right Child');
        
        final layout = SplitPaneLayout(
          leftChild: leftChild,
          rightChild: rightChild,
        );

        expect(layout, isA<SplitPaneLayout>());
        expect(layout.leftChild, equals(leftChild));
        expect(layout.rightChild, equals(rightChild));
        expect(layout.verticalPadding, equals(0));
      });

      test('should create SplitPaneLayout with custom vertical padding', () {
        const leftChild = Text('Left Child');
        const rightChild = Text('Right Child');
        const verticalPadding = 20.0;
        
        final layout = SplitPaneLayout(
          leftChild: leftChild,
          rightChild: rightChild,
          verticalPadding: verticalPadding,
        );

        expect(layout.leftChild, equals(leftChild));
        expect(layout.rightChild, equals(rightChild));
        expect(layout.verticalPadding, equals(verticalPadding));
      });

      test('should accept key parameter', () {
        const key = Key('split_pane_key');
        const leftChild = Text('Left Child');
        const rightChild = Text('Right Child');
        
        final layout = SplitPaneLayout(
          key: key,
          leftChild: leftChild,
          rightChild: rightChild,
        );

        expect(layout.key, equals(key));
      });

      test('should implement Layout interface', () {
        const leftChild = Text('Left Child');
        const rightChild = Text('Right Child');
        
        final layout = SplitPaneLayout(
          leftChild: leftChild,
          rightChild: rightChild,
        );

        expect(layout, isA<Layout>());
        expect(layout, isA<StatelessWidget>());
      });
    });

    group('Basic Rendering', () {
      testWidgets('should render both children in a Row', (WidgetTester tester) async {
        const leftChild = Text('Left Content');
        const rightChild = Text('Right Content');
        
        final layout = SplitPaneLayout(
          leftChild: leftChild,
          rightChild: rightChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.text('Left Content'), findsOneWidget);
        expect(find.text('Right Content'), findsOneWidget);
        expect(find.byType(Row), findsOneWidget);
        expect(find.byType(Material), findsOneWidget);
      });

      testWidgets('should wrap layout in Material widget', (WidgetTester tester) async {
        const leftChild = Text('Left Content');
        const rightChild = Text('Right Content');
        
        final layout = SplitPaneLayout(
          leftChild: leftChild,
          rightChild: rightChild,
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

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should apply theme colors to Material', (WidgetTester tester) async {
        const leftChild = Text('Left Content');
        const rightChild = Text('Right Content');
        
        final layout = SplitPaneLayout(
          leftChild: leftChild,
          rightChild: rightChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: const ColorScheme.light(
                surface: Colors.green,
                surfaceTint: Colors.orange,
              ),
            ),
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        final material = tester.widget<Material>(find.byType(Material));
        expect(material.color, equals(Colors.green));
        expect(material.surfaceTintColor, equals(Colors.orange));
      });
    });

    group('Layout Structure', () {
      testWidgets('should use Flexible widgets for both children', (WidgetTester tester) async {
        const leftChild = Text('Left Content');
        const rightChild = Text('Right Content');
        
        final layout = SplitPaneLayout(
          leftChild: leftChild,
          rightChild: rightChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        final flexibleWidgets = tester.widgetList<Flexible>(find.byType(Flexible));
        expect(flexibleWidgets.length, equals(2));

        // Both should have default flex value (1)
        for (final flexible in flexibleWidgets) {
          expect(flexible.flex, equals(1));
        }
      });

      testWidgets('should include spacing between panes', (WidgetTester tester) async {
        const leftChild = Text('Left Content');
        const rightChild = Text('Right Content');
        
        final layout = SplitPaneLayout(
          leftChild: leftChild,
          rightChild: rightChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        final row = tester.widget<Row>(find.byType(Row));
        expect(row.children.length, equals(3)); // left, spacing, right

        // Check that middle child is a SizedBox with correct width
        final sizedBox = row.children[1] as SizedBox;
        expect(sizedBox.width, equals(24.0)); // paneSpacing
      });

      testWidgets('should arrange children in correct order', (WidgetTester tester) async {
        const leftChild = Container(
          key: Key('left_container'),
          child: Text('Left Content'),
        );
        const rightChild = Container(
          key: Key('right_container'),
          child: Text('Right Content'),
        );
        
        final layout = SplitPaneLayout(
          leftChild: leftChild,
          rightChild: rightChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        final row = tester.widget<Row>(find.byType(Row));
        
        // First child should be Flexible containing left child
        final firstFlexible = row.children[0] as Flexible;
        expect(firstFlexible.child, equals(leftChild));
        
        // Third child should be Flexible containing right child
        final thirdFlexible = row.children[2] as Flexible;
        expect(thirdFlexible.child, equals(rightChild));
      });
    });

    group('Vertical Padding', () {
      testWidgets('should apply vertical padding through layoutSpacing', (WidgetTester tester) async {
        const leftChild = Text('Left Content');
        const rightChild = Text('Right Content');
        const verticalPadding = 15.0;
        
        final layout = SplitPaneLayout(
          leftChild: leftChild,
          rightChild: rightChild,
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

        final container = tester.widget<Container>(find.byType(Container));
        final margin = container.margin as EdgeInsets;
        
        expect(margin.top, equals(verticalPadding));
        expect(margin.bottom, equals(verticalPadding));
        expect(margin.left, equals(24.0)); // mediumLayoutMargin
        expect(margin.right, equals(24.0));

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should handle zero vertical padding', (WidgetTester tester) async {
        const leftChild = Text('Left Content');
        const rightChild = Text('Right Content');
        
        final layout = SplitPaneLayout(
          leftChild: leftChild,
          rightChild: rightChild,
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

        final container = tester.widget<Container>(find.byType(Container));
        final margin = container.margin as EdgeInsets;
        
        expect(margin.top, equals(0.0));
        expect(margin.bottom, equals(0.0));

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should handle negative vertical padding', (WidgetTester tester) async {
        const leftChild = Text('Left Content');
        const rightChild = Text('Right Content');
        const verticalPadding = -10.0;
        
        final layout = SplitPaneLayout(
          leftChild: leftChild,
          rightChild: rightChild,
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

        final container = tester.widget<Container>(find.byType(Container));
        final margin = container.margin as EdgeInsets;
        
        expect(margin.top, equals(-10.0));
        expect(margin.bottom, equals(-10.0));

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should handle large vertical padding', (WidgetTester tester) async {
        const leftChild = Text('Left Content');
        const rightChild = Text('Right Content');
        const verticalPadding = 100.0;
        
        final layout = SplitPaneLayout(
          leftChild: leftChild,
          rightChild: rightChild,
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

        final container = tester.widget<Container>(find.byType(Container));
        final margin = container.margin as EdgeInsets;
        
        expect(margin.top, equals(100.0));
        expect(margin.bottom, equals(100.0));

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Responsive Behavior', () {
      testWidgets('should adapt margins to different screen sizes', (WidgetTester tester) async {
        const leftChild = Text('Left Content');
        const rightChild = Text('Right Content');
        const verticalPadding = 10.0;
        
        final layout = SplitPaneLayout(
          leftChild: leftChild,
          rightChild: rightChild,
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

        var container = tester.widget<Container>(find.byType(Container));
        var margin = container.margin as EdgeInsets;
        expect(margin.left, equals(16.0)); // compactLayoutMargin
        expect(margin.right, equals(16.0));

        // Test medium screen
        tester.binding.window.physicalSizeTestValue = const Size(700, 800);
        await tester.pumpAndSettle();

        container = tester.widget<Container>(find.byType(Container));
        margin = container.margin as EdgeInsets;
        expect(margin.left, equals(24.0)); // mediumLayoutMargin
        expect(margin.right, equals(24.0));

        // Test extended screen
        tester.binding.window.physicalSizeTestValue = const Size(1000, 800);
        await tester.pumpAndSettle();

        container = tester.widget<Container>(find.byType(Container));
        margin = container.margin as EdgeInsets;
        expect(margin.left, equals(24.0)); // exdendedLayoutMargin
        expect(margin.right, equals(24.0));

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should maintain equal pane distribution across screen sizes', (WidgetTester tester) async {
        const leftChild = Container(
          key: Key('left_pane'),
          color: Colors.red,
          child: Text('Left'),
        );
        const rightChild = Container(
          key: Key('right_pane'),
          color: Colors.blue,
          child: Text('Right'),
        );
        
        final layout = SplitPaneLayout(
          leftChild: leftChild,
          rightChild: rightChild,
        );

        for (final screenWidth in [600.0, 800.0, 1200.0]) {
          tester.binding.window.physicalSizeTestValue = Size(screenWidth, 800);
          await tester.pumpAndSettle();

          final flexibleWidgets = tester.widgetList<Flexible>(find.byType(Flexible));
          expect(flexibleWidgets.length, equals(2));
          
          // Both panes should have equal flex values
          expect(flexibleWidgets.first.flex, equals(flexibleWidgets.last.flex));
        }

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Complex Child Widgets', () {
      testWidgets('should handle complex left and right children', (WidgetTester tester) async {
        final leftChild = Column(
          children: [
            const Text('Left Title'),
            Container(
              height: 100,
              color: Colors.red,
              child: const Center(child: Text('Left Content')),
            ),
            const Icon(Icons.arrow_left),
          ],
        );

        final rightChild = Column(
          children: [
            const Text('Right Title'),
            Container(
              height: 100,
              color: Colors.blue,
              child: const Center(child: Text('Right Content')),
            ),
            const Icon(Icons.arrow_right),
          ],
        );
        
        final layout = SplitPaneLayout(
          leftChild: leftChild,
          rightChild: rightChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.text('Left Title'), findsOneWidget);
        expect(find.text('Left Content'), findsOneWidget);
        expect(find.byIcon(Icons.arrow_left), findsOneWidget);
        
        expect(find.text('Right Title'), findsOneWidget);
        expect(find.text('Right Content'), findsOneWidget);
        expect(find.byIcon(Icons.arrow_right), findsOneWidget);
      });

      testWidgets('should handle scrollable children', (WidgetTester tester) async {
        final leftChild = ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) => ListTile(
            title: Text('Left Item $index'),
            leading: const Icon(Icons.list),
          ),
        );

        final rightChild = ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) => ListTile(
            title: Text('Right Item $index'),
            trailing: const Icon(Icons.arrow_forward),
          ),
        );
        
        final layout = SplitPaneLayout(
          leftChild: leftChild,
          rightChild: rightChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.text('Left Item 0'), findsOneWidget);
        expect(find.text('Right Item 0'), findsOneWidget);
        expect(find.byType(ListView), findsNWidgets(2));

        // Test scrolling in left pane
        await tester.drag(find.text('Left Item 0'), const Offset(0, -100));
        await tester.pumpAndSettle();

        // Test scrolling in right pane
        await tester.drag(find.text('Right Item 0'), const Offset(0, -100));
        await tester.pumpAndSettle();
      });

      testWidgets('should handle interactive children', (WidgetTester tester) async {
        bool leftButtonPressed = false;
        bool rightButtonPressed = false;

        final leftChild = Column(
          children: [
            const Text('Left Pane'),
            ElevatedButton(
              onPressed: () => leftButtonPressed = true,
              child: const Text('Left Button'),
            ),
          ],
        );

        final rightChild = Column(
          children: [
            const Text('Right Pane'),
            ElevatedButton(
              onPressed: () => rightButtonPressed = true,
              child: const Text('Right Button'),
            ),
          ],
        );
        
        final layout = SplitPaneLayout(
          leftChild: leftChild,
          rightChild: rightChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        // Test left button
        await tester.tap(find.text('Left Button'));
        await tester.pumpAndSettle();
        expect(leftButtonPressed, isTrue);

        // Test right button
        await tester.tap(find.text('Right Button'));
        await tester.pumpAndSettle();
        expect(rightButtonPressed, isTrue);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle very small screen sizes', (WidgetTester tester) async {
        const leftChild = Text('L');
        const rightChild = Text('R');
        
        final layout = SplitPaneLayout(
          leftChild: leftChild,
          rightChild: rightChild,
        );

        tester.binding.window.physicalSizeTestValue = const Size(100, 100);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.text('L'), findsOneWidget);
        expect(find.text('R'), findsOneWidget);

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should handle very large screen sizes', (WidgetTester tester) async {
        const leftChild = Text('Left Content');
        const rightChild = Text('Right Content');
        
        final layout = SplitPaneLayout(
          leftChild: leftChild,
          rightChild: rightChild,
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

        expect(find.text('Left Content'), findsOneWidget);
        expect(find.text('Right Content'), findsOneWidget);

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should handle empty children', (WidgetTester tester) async {
        const leftChild = SizedBox.shrink();
        const rightChild = SizedBox.shrink();
        
        final layout = SplitPaneLayout(
          leftChild: leftChild,
          rightChild: rightChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.byType(SizedBox), findsNWidgets(3)); // 2 shrink + 1 spacing
        expect(find.byType(Row), findsOneWidget);
      });
    });

    group('Widget Tree Integration', () {
      testWidgets('should integrate properly in complex layouts', (WidgetTester tester) async {
        const leftChild = Text('Left Panel');
        const rightChild = Text('Right Panel');
        
        final layout = SplitPaneLayout(
          leftChild: leftChild,
          rightChild: rightChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              appBar: AppBar(title: const Text('Split Pane App')),
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

        expect(find.text('Split Pane App'), findsOneWidget);
        expect(find.text('Header'), findsOneWidget);
        expect(find.text('Left Panel'), findsOneWidget);
        expect(find.text('Right Panel'), findsOneWidget);
        expect(find.text('Footer'), findsOneWidget);
      });

      testWidgets('should work with nested layouts', (WidgetTester tester) async {
        final leftChild = SplitPaneLayout(
          leftChild: const Text('Nested Left'),
          rightChild: const Text('Nested Right'),
        );
        const rightChild = Text('Main Right');
        
        final layout = SplitPaneLayout(
          leftChild: leftChild,
          rightChild: rightChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.text('Nested Left'), findsOneWidget);
        expect(find.text('Nested Right'), findsOneWidget);
        expect(find.text('Main Right'), findsOneWidget);
        expect(find.byType(Row), findsNWidgets(2)); // Main row + nested row
      });
    });

    group('Performance Considerations', () {
      testWidgets('should not rebuild unnecessarily', (WidgetTester tester) async {
        int leftBuildCount = 0;
        int rightBuildCount = 0;

        final leftChild = TestWidgetWithCounter(
          text: 'Left',
          onBuild: () => leftBuildCount++,
        );
        final rightChild = TestWidgetWithCounter(
          text: 'Right',
          onBuild: () => rightBuildCount++,
        );
        
        final layout = SplitPaneLayout(
          leftChild: leftChild,
          rightChild: rightChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(leftBuildCount, equals(1));
        expect(rightBuildCount, equals(1));

        // Pump again without changes
        await tester.pump();

        expect(leftBuildCount, equals(2)); // SplitPaneLayout rebuilds, so children rebuild
        expect(rightBuildCount, equals(2));
      });
    });

    group('Accessibility', () {
      testWidgets('should maintain accessibility properties of children', (WidgetTester tester) async {
        const leftChild = Text(
          'Left Content',
          semanticsLabel: 'Left pane content',
        );
        const rightChild = Text(
          'Right Content',
          semanticsLabel: 'Right pane content',
        );
        
        final layout = SplitPaneLayout(
          leftChild: leftChild,
          rightChild: rightChild,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.bySemanticsLabel('Left pane content'), findsOneWidget);
        expect(find.bySemanticsLabel('Right pane content'), findsOneWidget);
      });
    });

    group('Theme Integration', () {
      testWidgets('should respond to theme changes', (WidgetTester tester) async {
        const leftChild = Text('Left Content');
        const rightChild = Text('Right Content');
        
        final layout = SplitPaneLayout(
          leftChild: leftChild,
          rightChild: rightChild,
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