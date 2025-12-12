import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material3_layout/src/layouts/layout.dart';
import 'package:material3_layout/src/layouts/single_pane_layout.dart';

void main() {
  group('SinglePaneLayout', () {
    group('Constructor', () {
      test('should create SinglePaneLayout with required child', () {
        const child = Text('Test Child');
        final layout = SinglePaneLayout(child: child);

        expect(layout, isA<SinglePaneLayout>());
        expect(layout.child, equals(child));
        expect(layout.verticalPadding, equals(0));
      });

      test('should create SinglePaneLayout with custom vertical padding', () {
        const child = Text('Test Child');
        const verticalPadding = 20.0;
        
        final layout = SinglePaneLayout(
          child: child,
          verticalPadding: verticalPadding,
        );

        expect(layout.child, equals(child));
        expect(layout.verticalPadding, equals(verticalPadding));
      });

      test('should accept key parameter', () {
        const key = Key('single_pane_key');
        const child = Text('Test Child');
        
        final layout = SinglePaneLayout(
          key: key,
          child: child,
        );

        expect(layout.key, equals(key));
      });

      test('should implement Layout interface', () {
        const child = Text('Test Child');
        final layout = SinglePaneLayout(child: child);

        expect(layout, isA<Layout>());
        expect(layout, isA<StatelessWidget>());
      });
    });

    group('Compact Layout Rendering', () {
      testWidgets('should render as Container for compact screens', (WidgetTester tester) async {
        const child = Text('Compact Content');
        final layout = SinglePaneLayout(child: child);

        // Set screen size to compact (< 600px)
        tester.binding.window.physicalSizeTestValue = const Size(500, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.text('Compact Content'), findsOneWidget);
        expect(find.byType(Container), findsOneWidget);
        expect(find.byType(Material), findsNothing);

        final container = tester.widget<Container>(find.byType(Container));
        expect(container.width, equals(double.infinity));
        expect(container.height, equals(double.infinity));

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should apply correct margins for compact layout', (WidgetTester tester) async {
        const child = Text('Compact Content');
        const verticalPadding = 10.0;
        
        final layout = SinglePaneLayout(
          child: child,
          verticalPadding: verticalPadding,
        );

        tester.binding.window.physicalSizeTestValue = const Size(400, 800);
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
        
        expect(margin.left, equals(16.0)); // compactLayoutMargin
        expect(margin.right, equals(16.0));
        expect(margin.top, equals(verticalPadding));
        expect(margin.bottom, equals(verticalPadding));

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should handle zero vertical padding in compact layout', (WidgetTester tester) async {
        const child = Text('Compact Content');
        final layout = SinglePaneLayout(child: child);

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
    });

    group('Medium Layout Rendering', () {
      testWidgets('should render as Material for medium screens', (WidgetTester tester) async {
        const child = Text('Medium Content');
        final layout = SinglePaneLayout(child: child);

        // Set screen size to medium (600-840px)
        tester.binding.window.physicalSizeTestValue = const Size(700, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.text('Medium Content'), findsOneWidget);
        expect(find.byType(Material), findsOneWidget);
        expect(find.byType(Container), findsOneWidget); // Container inside Material

        final material = tester.widget<Material>(find.byType(Material));
        expect(material.elevation, equals(2));
        expect(material.shadowColor, equals(Colors.transparent));

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should apply theme colors for medium layout', (WidgetTester tester) async {
        const child = Text('Medium Content');
        final layout = SinglePaneLayout(child: child);

        tester.binding.window.physicalSizeTestValue = const Size(700, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: const ColorScheme.light(
                surface: Colors.blue,
                surfaceTint: Colors.red,
              ),
            ),
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        final material = tester.widget<Material>(find.byType(Material));
        expect(material.color, equals(Colors.blue));
        expect(material.surfaceTintColor, equals(Colors.red));

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should apply correct margins for medium layout', (WidgetTester tester) async {
        const child = Text('Medium Content');
        const verticalPadding = 15.0;
        
        final layout = SinglePaneLayout(
          child: child,
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
        
        expect(margin.left, equals(24.0)); // mediumLayoutMargin
        expect(margin.right, equals(24.0));
        expect(margin.top, equals(verticalPadding));
        expect(margin.bottom, equals(verticalPadding));

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Extended Layout Rendering', () {
      testWidgets('should render as Material for extended screens', (WidgetTester tester) async {
        const child = Text('Extended Content');
        final layout = SinglePaneLayout(child: child);

        // Set screen size to extended (>= 840px)
        tester.binding.window.physicalSizeTestValue = const Size(1000, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.text('Extended Content'), findsOneWidget);
        expect(find.byType(Material), findsOneWidget);
        expect(find.byType(Container), findsOneWidget);

        final material = tester.widget<Material>(find.byType(Material));
        expect(material.elevation, equals(2));
        expect(material.shadowColor, equals(Colors.transparent));

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should apply correct margins for extended layout', (WidgetTester tester) async {
        const child = Text('Extended Content');
        const verticalPadding = 25.0;
        
        final layout = SinglePaneLayout(
          child: child,
          verticalPadding: verticalPadding,
        );

        tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
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
        
        expect(margin.left, equals(24.0)); // exdendedLayoutMargin
        expect(margin.right, equals(24.0));
        expect(margin.top, equals(verticalPadding));
        expect(margin.bottom, equals(verticalPadding));

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Responsive Behavior', () {
      testWidgets('should change rendering based on screen size', (WidgetTester tester) async {
        const child = Text('Responsive Content');
        final layout = SinglePaneLayout(child: child);

        // Start with compact
        tester.binding.window.physicalSizeTestValue = const Size(500, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.byType(Material), findsNothing);
        expect(find.byType(Container), findsOneWidget);

        // Change to medium
        tester.binding.window.physicalSizeTestValue = const Size(700, 800);
        await tester.pumpAndSettle();

        expect(find.byType(Material), findsOneWidget);
        expect(find.byType(Container), findsOneWidget); // Container inside Material

        // Change to extended
        tester.binding.window.physicalSizeTestValue = const Size(1000, 800);
        await tester.pumpAndSettle();

        expect(find.byType(Material), findsOneWidget);
        expect(find.byType(Container), findsOneWidget);

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should maintain child content across breakpoints', (WidgetTester tester) async {
        const child = Column(
          children: [
            Text('Header'),
            Icon(Icons.star),
            Text('Footer'),
          ],
        );
        final layout = SinglePaneLayout(child: child);

        for (final screenWidth in [400.0, 700.0, 1000.0]) {
          tester.binding.window.physicalSizeTestValue = Size(screenWidth, 800);
          await tester.pumpAndSettle();

          expect(find.text('Header'), findsOneWidget);
          expect(find.byIcon(Icons.star), findsOneWidget);
          expect(find.text('Footer'), findsOneWidget);
        }

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Boundary Cases', () {
      testWidgets('should handle boundary at width = 600', (WidgetTester tester) async {
        const child = Text('Boundary Content');
        final layout = SinglePaneLayout(child: child);

        // Exactly at compact/medium boundary
        tester.binding.window.physicalSizeTestValue = const Size(600, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        // Should be medium layout (Material widget)
        expect(find.byType(Material), findsOneWidget);

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should handle boundary at width = 840', (WidgetTester tester) async {
        const child = Text('Boundary Content');
        final layout = SinglePaneLayout(child: child);

        // Exactly at medium/extended boundary
        tester.binding.window.physicalSizeTestValue = const Size(840, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        // Should be extended layout (Material widget)
        expect(find.byType(Material), findsOneWidget);

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should handle very small screens', (WidgetTester tester) async {
        const child = Text('Small Screen');
        final layout = SinglePaneLayout(child: child);

        tester.binding.window.physicalSizeTestValue = const Size(100, 100);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.text('Small Screen'), findsOneWidget);
        expect(find.byType(Material), findsNothing); // Should be compact

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should handle very large screens', (WidgetTester tester) async {
        const child = Text('Large Screen');
        final layout = SinglePaneLayout(child: child);

        tester.binding.window.physicalSizeTestValue = const Size(5000, 3000);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.text('Large Screen'), findsOneWidget);
        expect(find.byType(Material), findsOneWidget); // Should be extended

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Vertical Padding Variations', () {
      testWidgets('should handle negative vertical padding', (WidgetTester tester) async {
        const child = Text('Negative Padding');
        final layout = SinglePaneLayout(
          child: child,
          verticalPadding: -10.0,
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
        
        expect(margin.top, equals(-10.0));
        expect(margin.bottom, equals(-10.0));

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should handle large vertical padding', (WidgetTester tester) async {
        const child = Text('Large Padding');
        final layout = SinglePaneLayout(
          child: child,
          verticalPadding: 100.0,
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

      testWidgets('should handle fractional vertical padding', (WidgetTester tester) async {
        const child = Text('Fractional Padding');
        final layout = SinglePaneLayout(
          child: child,
          verticalPadding: 12.5,
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
        
        expect(margin.top, equals(12.5));
        expect(margin.bottom, equals(12.5));

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Child Widget Handling', () {
      testWidgets('should render complex child widgets', (WidgetTester tester) async {
        final child = Column(
          children: [
            const Text('Title'),
            Container(
              height: 100,
              color: Colors.blue,
              child: const Center(child: Text('Content')),
            ),
            Row(
              children: [
                const Icon(Icons.star),
                const Text('Rating'),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Action'),
                ),
              ],
            ),
          ],
        );

        final layout = SinglePaneLayout(child: child);

        tester.binding.window.physicalSizeTestValue = const Size(700, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.text('Title'), findsOneWidget);
        expect(find.text('Content'), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
        expect(find.text('Rating'), findsOneWidget);
        expect(find.text('Action'), findsOneWidget);
        expect(find.byType(ElevatedButton), findsOneWidget);

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should handle scrollable child widgets', (WidgetTester tester) async {
        final child = ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => ListTile(
            title: Text('Item $index'),
            leading: const Icon(Icons.list),
          ),
        );

        final layout = SinglePaneLayout(child: child);

        tester.binding.window.physicalSizeTestValue = const Size(500, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.text('Item 0'), findsOneWidget);
        expect(find.byType(ListView), findsOneWidget);

        // Test scrolling
        await tester.drag(find.byType(ListView), const Offset(0, -300));
        await tester.pumpAndSettle();

        expect(find.text('Item 5'), findsOneWidget);

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Widget Tree Integration', () {
      testWidgets('should integrate properly in complex layouts', (WidgetTester tester) async {
        const child = Text('Integrated Content');
        final layout = SinglePaneLayout(child: child);

        tester.binding.window.physicalSizeTestValue = const Size(700, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              appBar: AppBar(title: const Text('Test App')),
              body: Column(
                children: [
                  const Text('Header'),
                  Expanded(child: layout),
                  const Text('Footer'),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.add),
              ),
            ),
          ),
        );

        expect(find.text('Test App'), findsOneWidget);
        expect(find.text('Header'), findsOneWidget);
        expect(find.text('Integrated Content'), findsOneWidget);
        expect(find.text('Footer'), findsOneWidget);
        expect(find.byType(FloatingActionButton), findsOneWidget);

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Performance and Memory', () {
      testWidgets('should not cause memory leaks with repeated builds', (WidgetTester tester) async {
        const child = Text('Performance Test');
        final layout = SinglePaneLayout(child: child);

        tester.binding.window.physicalSizeTestValue = const Size(700, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        // Build multiple times
        for (int i = 0; i < 10; i++) {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: layout,
              ),
            ),
          );
        }

        expect(find.text('Performance Test'), findsOneWidget);

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Accessibility', () {
      testWidgets('should maintain accessibility properties', (WidgetTester tester) async {
        const child = Text(
          'Accessible Content',
          semanticsLabel: 'Accessible content for screen readers',
        );
        final layout = SinglePaneLayout(child: child);

        tester.binding.window.physicalSizeTestValue = const Size(700, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.bySemanticsLabel('Accessible content for screen readers'), findsOneWidget);

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });
  });
}