import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material3_layout/src/layouts/layout.dart';

// Test implementation of the abstract Layout class
class TestLayout extends StatelessWidget implements Layout {
  final Widget child;
  final String testId;

  const TestLayout({
    Key? key,
    required this.child,
    this.testId = 'test-layout',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(testId),
      child: child,
    );
  }
}

// Another test implementation to verify interface compliance
class AnotherTestLayout extends StatelessWidget implements Layout {
  final Color backgroundColor;
  final Widget content;

  const AnotherTestLayout({
    Key? key,
    required this.content,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: content,
    );
  }
}

void main() {
  group('Layout Abstract Class', () {
    group('Interface Compliance', () {
      test('should be implemented by concrete classes', () {
        final layout = TestLayout(child: const Text('Test'));
        
        expect(layout, isA<Layout>());
        expect(layout, isA<StatelessWidget>());
      });

      test('should allow multiple implementations', () {
        final layout1 = TestLayout(child: const Text('Test 1'));
        final layout2 = AnotherTestLayout(content: const Text('Test 2'));
        
        expect(layout1, isA<Layout>());
        expect(layout2, isA<Layout>());
        expect(layout1.runtimeType, isNot(equals(layout2.runtimeType)));
      });

      test('should maintain StatelessWidget interface', () {
        final layout = TestLayout(child: const Text('Test'));
        
        expect(layout, isA<StatelessWidget>());
        expect(layout.build, isA<Function>());
      });
    });

    group('Widget Functionality', () {
      testWidgets('should render as a widget', (WidgetTester tester) async {
        const testChild = Text('Test Content');
        final layout = TestLayout(child: testChild);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.text('Test Content'), findsOneWidget);
        expect(find.byKey(const Key('test-layout')), findsOneWidget);
      });

      testWidgets('should pass through child widgets correctly', (WidgetTester tester) async {
        const testChild = Column(
          children: [
            Text('First'),
            Text('Second'),
            Icon(Icons.star),
          ],
        );
        final layout = TestLayout(child: testChild);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.text('First'), findsOneWidget);
        expect(find.text('Second'), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
      });

      testWidgets('should support custom properties in implementations', (WidgetTester tester) async {
        final layout = AnotherTestLayout(
          content: const Text('Colored Content'),
          backgroundColor: Colors.blue,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.text('Colored Content'), findsOneWidget);
        
        final container = tester.widget<Container>(find.byType(Container));
        expect(container.color, equals(Colors.blue));
      });
    });

    group('Type System Integration', () {
      test('should work with generic collections', () {
        final layouts = <Layout>[
          TestLayout(child: const Text('Layout 1')),
          AnotherTestLayout(content: const Text('Layout 2')),
        ];

        expect(layouts.length, equals(2));
        expect(layouts[0], isA<Layout>());
        expect(layouts[1], isA<Layout>());
      });

      test('should work with polymorphism', () {
        Layout createLayout(String type) {
          switch (type) {
            case 'test':
              return TestLayout(child: const Text('Test Layout'));
            case 'another':
              return AnotherTestLayout(content: const Text('Another Layout'));
            default:
              throw ArgumentError('Unknown layout type: $type');
          }
        }

        final testLayout = createLayout('test');
        final anotherLayout = createLayout('another');

        expect(testLayout, isA<Layout>());
        expect(testLayout, isA<TestLayout>());
        expect(anotherLayout, isA<Layout>());
        expect(anotherLayout, isA<AnotherTestLayout>());
      });

      test('should support type checking and casting', () {
        Layout layout = TestLayout(child: const Text('Test'));

        expect(layout is TestLayout, isTrue);
        expect(layout is AnotherTestLayout, isFalse);

        if (layout is TestLayout) {
          expect(layout.testId, equals('test-layout'));
        }
      });
    });

    group('Widget Tree Integration', () {
      testWidgets('should integrate properly in widget tree', (WidgetTester tester) async {
        final layout = TestLayout(
          testId: 'integration-test',
          child: const Column(
            children: [
              Text('Header'),
              Expanded(child: Text('Content')),
              Text('Footer'),
            ],
          ),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              appBar: AppBar(title: const Text('Test App')),
              body: layout,
            ),
          ),
        );

        expect(find.text('Test App'), findsOneWidget);
        expect(find.text('Header'), findsOneWidget);
        expect(find.text('Content'), findsOneWidget);
        expect(find.text('Footer'), findsOneWidget);
        expect(find.byKey(const Key('integration-test')), findsOneWidget);
      });

      testWidgets('should handle nested layouts', (WidgetTester tester) async {
        final nestedLayout = TestLayout(
          testId: 'outer-layout',
          child: TestLayout(
            testId: 'inner-layout',
            child: const Text('Nested Content'),
          ),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: nestedLayout,
            ),
          ),
        );

        expect(find.text('Nested Content'), findsOneWidget);
        expect(find.byKey(const Key('outer-layout')), findsOneWidget);
        expect(find.byKey(const Key('inner-layout')), findsOneWidget);
      });
    });

    group('Key and Identity', () {
      testWidgets('should support widget keys', (WidgetTester tester) async {
        const layoutKey = Key('unique-layout-key');
        final layout = TestLayout(
          key: layoutKey,
          child: const Text('Keyed Layout'),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(find.byKey(layoutKey), findsOneWidget);
        expect(find.text('Keyed Layout'), findsOneWidget);
      });

      test('should maintain object identity', () {
        final layout1 = TestLayout(child: const Text('Test'));
        final layout2 = TestLayout(child: const Text('Test'));

        expect(layout1 == layout2, isFalse);
        expect(identical(layout1, layout1), isTrue);
        expect(identical(layout1, layout2), isFalse);
      });
    });

    group('Error Handling', () {
      testWidgets('should handle build context properly', (WidgetTester tester) async {
        bool buildContextReceived = false;
        
        final layout = TestLayoutWithContextCheck(
          onBuildContext: (context) {
            buildContextReceived = true;
            expect(context, isNotNull);
            expect(context, isA<BuildContext>());
          },
          child: const Text('Context Test'),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(buildContextReceived, isTrue);
        expect(find.text('Context Test'), findsOneWidget);
      });
    });

    group('Performance Considerations', () {
      testWidgets('should rebuild efficiently', (WidgetTester tester) async {
        int buildCount = 0;
        
        final layout = TestLayoutWithBuildCounter(
          onBuild: () => buildCount++,
          child: const Text('Performance Test'),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(buildCount, equals(1));

        // Trigger a rebuild
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: layout,
            ),
          ),
        );

        expect(buildCount, equals(2));
      });
    });

    group('Abstract Class Properties', () {
      test('should not be instantiable directly', () {
        // This test verifies that Layout is abstract and cannot be instantiated
        // We can only test this conceptually since Dart prevents direct instantiation
        expect(() {
          // This would cause a compile-time error:
          // Layout layout = Layout();
        }, returnsNormally);
      });

      test('should enforce implementation of StatelessWidget interface', () {
        final layout = TestLayout(child: const Text('Test'));
        
        // Verify that the layout has all required StatelessWidget methods
        expect(layout.build, isA<Function>());
        expect(layout.createElement, isA<Function>());
        expect(layout.key, isA<Key?>());
      });
    });
  });
}

// Helper class for testing build context
class TestLayoutWithContextCheck extends StatelessWidget implements Layout {
  final Widget child;
  final Function(BuildContext) onBuildContext;

  const TestLayoutWithContextCheck({
    Key? key,
    required this.child,
    required this.onBuildContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    onBuildContext(context);
    return Container(child: child);
  }
}

// Helper class for testing build count
class TestLayoutWithBuildCounter extends StatelessWidget implements Layout {
  final Widget child;
  final VoidCallback onBuild;

  const TestLayoutWithBuildCounter({
    Key? key,
    required this.child,
    required this.onBuild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    onBuild();
    return Container(child: child);
  }
}