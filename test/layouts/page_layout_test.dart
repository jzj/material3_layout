import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material3_layout/src/layouts/layout.dart';
import 'package:material3_layout/src/layouts/page_layout.dart';

// Test implementations of Layout for testing
class TestCompactLayout extends StatelessWidget implements Layout {
  final String identifier;
  
  const TestCompactLayout({Key? key, this.identifier = 'compact'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('${identifier}_layout'),
      child: Text('${identifier.toUpperCase()} Layout'),
    );
  }
}

class TestMediumLayout extends StatelessWidget implements Layout {
  final String identifier;
  
  const TestMediumLayout({Key? key, this.identifier = 'medium'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('${identifier}_layout'),
      child: Text('${identifier.toUpperCase()} Layout'),
    );
  }
}

class TestExpandedLayout extends StatelessWidget implements Layout {
  final String identifier;
  
  const TestExpandedLayout({Key? key, this.identifier = 'expanded'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('${identifier}_layout'),
      child: Text('${identifier.toUpperCase()} Layout'),
    );
  }
}

void main() {
  group('PageLayout', () {
    group('Constructor', () {
      test('should create PageLayout with required parameters', () {
        const compactLayout = TestCompactLayout();
        const mediumLayout = TestMediumLayout();
        const expandedLayout = TestExpandedLayout();

        final pageLayout = PageLayout(
          compactLayout: compactLayout,
          mediumLayout: mediumLayout,
          expandedLayout: expandedLayout,
        );

        expect(pageLayout, isA<PageLayout>());
        expect(pageLayout.compactLayout, equals(compactLayout));
        expect(pageLayout.mediumLayout, equals(mediumLayout));
        expect(pageLayout.expandedLayout, equals(expandedLayout));
      });

      test('should create PageLayout with null medium and expanded layouts', () {
        const compactLayout = TestCompactLayout();

        const pageLayout = PageLayout(
          compactLayout: compactLayout,
          mediumLayout: null,
          expandedLayout: null,
        );

        expect(pageLayout.compactLayout, equals(compactLayout));
        expect(pageLayout.mediumLayout, isNull);
        expect(pageLayout.expandedLayout, isNull);
      });

      test('should accept key parameter', () {
        const key = Key('page_layout_key');
        const compactLayout = TestCompactLayout();

        const pageLayout = PageLayout(
          key: key,
          compactLayout: compactLayout,
          mediumLayout: null,
          expandedLayout: null,
        );

        expect(pageLayout.key, equals(key));
      });
    });

    group('Compact Layout Rendering', () {
      testWidgets('should render compact layout for small screens', (WidgetTester tester) async {
        const compactLayout = TestCompactLayout();
        const mediumLayout = TestMediumLayout();
        const expandedLayout = TestExpandedLayout();

        final pageLayout = PageLayout(
          compactLayout: compactLayout,
          mediumLayout: mediumLayout,
          expandedLayout: expandedLayout,
        );

        // Set screen size to compact (< 600px)
        tester.binding.window.physicalSizeTestValue = const Size(500, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: pageLayout,
            ),
          ),
        );

        expect(find.text('COMPACT Layout'), findsOneWidget);
        expect(find.byKey(const Key('compact_layout')), findsOneWidget);
        expect(find.text('MEDIUM Layout'), findsNothing);
        expect(find.text('EXPANDED Layout'), findsNothing);

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should render compact layout when medium and expanded are null', (WidgetTester tester) async {
        const compactLayout = TestCompactLayout();

        const pageLayout = PageLayout(
          compactLayout: compactLayout,
          mediumLayout: null,
          expandedLayout: null,
        );

        // Set screen size to medium (600-840px)
        tester.binding.window.physicalSizeTestValue = const Size(700, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: pageLayout,
            ),
          ),
        );

        // Should fall back to compact layout
        expect(find.text('COMPACT Layout'), findsOneWidget);
        expect(find.byKey(const Key('compact_layout')), findsOneWidget);

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Medium Layout Rendering', () {
      testWidgets('should render medium layout for medium screens', (WidgetTester tester) async {
        const compactLayout = TestCompactLayout();
        const mediumLayout = TestMediumLayout();
        const expandedLayout = TestExpandedLayout();

        final pageLayout = PageLayout(
          compactLayout: compactLayout,
          mediumLayout: mediumLayout,
          expandedLayout: expandedLayout,
        );

        // Set screen size to medium (600-840px)
        tester.binding.window.physicalSizeTestValue = const Size(700, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: pageLayout,
            ),
          ),
        );

        expect(find.text('MEDIUM Layout'), findsOneWidget);
        expect(find.byKey(const Key('medium_layout')), findsOneWidget);
        expect(find.text('COMPACT Layout'), findsNothing);
        expect(find.text('EXPANDED Layout'), findsNothing);

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should render medium layout at boundary (width = 600)', (WidgetTester tester) async {
        const compactLayout = TestCompactLayout();
        const mediumLayout = TestMediumLayout();
        const expandedLayout = TestExpandedLayout();

        final pageLayout = PageLayout(
          compactLayout: compactLayout,
          mediumLayout: mediumLayout,
          expandedLayout: expandedLayout,
        );

        // Set screen size exactly at medium boundary
        tester.binding.window.physicalSizeTestValue = const Size(600, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: pageLayout,
            ),
          ),
        );

        expect(find.text('MEDIUM Layout'), findsOneWidget);
        expect(find.byKey(const Key('medium_layout')), findsOneWidget);

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should fall back to compact when medium layout is null', (WidgetTester tester) async {
        const compactLayout = TestCompactLayout();
        const expandedLayout = TestExpandedLayout();

        const pageLayout = PageLayout(
          compactLayout: compactLayout,
          mediumLayout: null,
          expandedLayout: expandedLayout,
        );

        // Set screen size to medium
        tester.binding.window.physicalSizeTestValue = const Size(700, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: pageLayout,
            ),
          ),
        );

        // Should fall back to compact layout
        expect(find.text('COMPACT Layout'), findsOneWidget);
        expect(find.byKey(const Key('compact_layout')), findsOneWidget);
        expect(find.text('EXPANDED Layout'), findsNothing);

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Expanded Layout Rendering', () {
      testWidgets('should render expanded layout for large screens', (WidgetTester tester) async {
        const compactLayout = TestCompactLayout();
        const mediumLayout = TestMediumLayout();
        const expandedLayout = TestExpandedLayout();

        final pageLayout = PageLayout(
          compactLayout: compactLayout,
          mediumLayout: mediumLayout,
          expandedLayout: expandedLayout,
        );

        // Set screen size to expanded (>= 840px)
        tester.binding.window.physicalSizeTestValue = const Size(1000, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: pageLayout,
            ),
          ),
        );

        expect(find.text('EXPANDED Layout'), findsOneWidget);
        expect(find.byKey(const Key('expanded_layout')), findsOneWidget);
        expect(find.text('COMPACT Layout'), findsNothing);
        expect(find.text('MEDIUM Layout'), findsNothing);

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should render expanded layout at boundary (width = 840)', (WidgetTester tester) async {
        const compactLayout = TestCompactLayout();
        const mediumLayout = TestMediumLayout();
        const expandedLayout = TestExpandedLayout();

        final pageLayout = PageLayout(
          compactLayout: compactLayout,
          mediumLayout: mediumLayout,
          expandedLayout: expandedLayout,
        );

        // Set screen size exactly at expanded boundary
        tester.binding.window.physicalSizeTestValue = const Size(840, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: pageLayout,
            ),
          ),
        );

        expect(find.text('EXPANDED Layout'), findsOneWidget);
        expect(find.byKey(const Key('expanded_layout')), findsOneWidget);

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should fall back to medium when expanded layout is null', (WidgetTester tester) async {
        const compactLayout = TestCompactLayout();
        const mediumLayout = TestMediumLayout();

        const pageLayout = PageLayout(
          compactLayout: compactLayout,
          mediumLayout: mediumLayout,
          expandedLayout: null,
        );

        // Set screen size to expanded
        tester.binding.window.physicalSizeTestValue = const Size(1000, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: pageLayout,
            ),
          ),
        );

        // Should fall back to medium layout
        expect(find.text('MEDIUM Layout'), findsOneWidget);
        expect(find.byKey(const Key('medium_layout')), findsOneWidget);
        expect(find.text('EXPANDED Layout'), findsNothing);

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should render SizedBox.shrink when both medium and expanded are null', (WidgetTester tester) async {
        const compactLayout = TestCompactLayout();

        const pageLayout = PageLayout(
          compactLayout: compactLayout,
          mediumLayout: null,
          expandedLayout: null,
        );

        // Set screen size to expanded
        tester.binding.window.physicalSizeTestValue = const Size(1000, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: pageLayout,
            ),
          ),
        );

        // Should render SizedBox.shrink
        expect(find.byType(SizedBox), findsOneWidget);
        expect(find.text('COMPACT Layout'), findsNothing);

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, equals(0.0));
        expect(sizedBox.height, equals(0.0));

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Responsive Behavior', () {
      testWidgets('should respond to screen size changes', (WidgetTester tester) async {
        const compactLayout = TestCompactLayout();
        const mediumLayout = TestMediumLayout();
        const expandedLayout = TestExpandedLayout();

        final pageLayout = PageLayout(
          compactLayout: compactLayout,
          mediumLayout: mediumLayout,
          expandedLayout: expandedLayout,
        );

        // Start with compact size
        tester.binding.window.physicalSizeTestValue = const Size(500, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: pageLayout,
            ),
          ),
        );

        expect(find.text('COMPACT Layout'), findsOneWidget);

        // Change to medium size
        tester.binding.window.physicalSizeTestValue = const Size(700, 800);
        await tester.pumpAndSettle();

        expect(find.text('MEDIUM Layout'), findsOneWidget);
        expect(find.text('COMPACT Layout'), findsNothing);

        // Change to expanded size
        tester.binding.window.physicalSizeTestValue = const Size(1000, 800);
        await tester.pumpAndSettle();

        expect(find.text('EXPANDED Layout'), findsOneWidget);
        expect(find.text('MEDIUM Layout'), findsNothing);

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Edge Cases and Error Handling', () {
      testWidgets('should handle very small screen sizes', (WidgetTester tester) async {
        const compactLayout = TestCompactLayout();
        const mediumLayout = TestMediumLayout();
        const expandedLayout = TestExpandedLayout();

        final pageLayout = PageLayout(
          compactLayout: compactLayout,
          mediumLayout: mediumLayout,
          expandedLayout: expandedLayout,
        );

        // Very small screen
        tester.binding.window.physicalSizeTestValue = const Size(100, 100);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: pageLayout,
            ),
          ),
        );

        expect(find.text('COMPACT Layout'), findsOneWidget);

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should handle very large screen sizes', (WidgetTester tester) async {
        const compactLayout = TestCompactLayout();
        const mediumLayout = TestMediumLayout();
        const expandedLayout = TestExpandedLayout();

        final pageLayout = PageLayout(
          compactLayout: compactLayout,
          mediumLayout: mediumLayout,
          expandedLayout: expandedLayout,
        );

        // Very large screen
        tester.binding.window.physicalSizeTestValue = const Size(5000, 3000);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: pageLayout,
            ),
          ),
        );

        expect(find.text('EXPANDED Layout'), findsOneWidget);

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should handle different device pixel ratios', (WidgetTester tester) async {
        const compactLayout = TestCompactLayout();
        const mediumLayout = TestMediumLayout();
        const expandedLayout = TestExpandedLayout();

        final pageLayout = PageLayout(
          compactLayout: compactLayout,
          mediumLayout: mediumLayout,
          expandedLayout: expandedLayout,
        );

        // Test with high DPI
        tester.binding.window.physicalSizeTestValue = const Size(1400, 1600); // 700x800 logical
        tester.binding.window.devicePixelRatioTestValue = 2.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: pageLayout,
            ),
          ),
        );

        expect(find.text('MEDIUM Layout'), findsOneWidget);

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Widget Tree Integration', () {
      testWidgets('should integrate properly in complex widget trees', (WidgetTester tester) async {
        const compactLayout = TestCompactLayout(identifier: 'nested_compact');
        const mediumLayout = TestMediumLayout(identifier: 'nested_medium');
        const expandedLayout = TestExpandedLayout(identifier: 'nested_expanded');

        final pageLayout = PageLayout(
          compactLayout: compactLayout,
          mediumLayout: mediumLayout,
          expandedLayout: expandedLayout,
        );

        tester.binding.window.physicalSizeTestValue = const Size(700, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              appBar: AppBar(title: const Text('Test App')),
              body: Column(
                children: [
                  const Text('Header'),
                  Expanded(child: pageLayout),
                  const Text('Footer'),
                ],
              ),
            ),
          ),
        );

        expect(find.text('Test App'), findsOneWidget);
        expect(find.text('Header'), findsOneWidget);
        expect(find.text('NESTED_MEDIUM Layout'), findsOneWidget);
        expect(find.text('Footer'), findsOneWidget);

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should work with nested PageLayouts', (WidgetTester tester) async {
        final innerPageLayout = PageLayout(
          compactLayout: const TestCompactLayout(identifier: 'inner_compact'),
          mediumLayout: const TestMediumLayout(identifier: 'inner_medium'),
          expandedLayout: const TestExpandedLayout(identifier: 'inner_expanded'),
        );

        final outerPageLayout = PageLayout(
          compactLayout: const TestCompactLayout(identifier: 'outer_compact'),
          mediumLayout: innerPageLayout,
          expandedLayout: const TestExpandedLayout(identifier: 'outer_expanded'),
        );

        tester.binding.window.physicalSizeTestValue = const Size(700, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: outerPageLayout,
            ),
          ),
        );

        // Should render the inner medium layout
        expect(find.text('INNER_MEDIUM Layout'), findsOneWidget);
        expect(find.text('OUTER_COMPACT Layout'), findsNothing);
        expect(find.text('OUTER_EXPANDED Layout'), findsNothing);

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Performance Considerations', () {
      testWidgets('should not rebuild unnecessarily', (WidgetTester tester) async {
        int compactBuildCount = 0;
        int mediumBuildCount = 0;
        int expandedBuildCount = 0;

        final compactLayout = TestLayoutWithCounter(
          identifier: 'compact',
          onBuild: () => compactBuildCount++,
        );
        final mediumLayout = TestLayoutWithCounter(
          identifier: 'medium',
          onBuild: () => mediumBuildCount++,
        );
        final expandedLayout = TestLayoutWithCounter(
          identifier: 'expanded',
          onBuild: () => expandedBuildCount++,
        );

        final pageLayout = PageLayout(
          compactLayout: compactLayout,
          mediumLayout: mediumLayout,
          expandedLayout: expandedLayout,
        );

        // Start with medium size
        tester.binding.window.physicalSizeTestValue = const Size(700, 800);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: pageLayout,
            ),
          ),
        );

        expect(compactBuildCount, equals(0));
        expect(mediumBuildCount, equals(1));
        expect(expandedBuildCount, equals(0));

        // Pump again without changing screen size
        await tester.pump();

        expect(compactBuildCount, equals(0));
        expect(mediumBuildCount, equals(2)); // PageLayout rebuilds, so medium layout rebuilds
        expect(expandedBuildCount, equals(0));

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Type Safety', () {
      test('should maintain type safety with Layout interface', () {
        const compactLayout = TestCompactLayout();
        const mediumLayout = TestMediumLayout();
        const expandedLayout = TestExpandedLayout();

        final pageLayout = PageLayout(
          compactLayout: compactLayout,
          mediumLayout: mediumLayout,
          expandedLayout: expandedLayout,
        );

        expect(pageLayout.compactLayout, isA<Layout>());
        expect(pageLayout.mediumLayout, isA<Layout?>());
        expect(pageLayout.expandedLayout, isA<Layout?>());
      });
    });
  });
}

// Helper class for testing build counts
class TestLayoutWithCounter extends StatelessWidget implements Layout {
  final String identifier;
  final VoidCallback onBuild;

  const TestLayoutWithCounter({
    Key? key,
    required this.identifier,
    required this.onBuild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    onBuild();
    return Container(
      key: Key('${identifier}_layout'),
      child: Text('${identifier.toUpperCase()} Layout'),
    );
  }
}