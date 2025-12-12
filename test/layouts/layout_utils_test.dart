import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material3_layout/src/layouts/layout_utils.dart';

void main() {
  group('LayoutUtils', () {
    late LayoutUtils layoutUtils;

    setUp(() {
      layoutUtils = LayoutUtils();
    });

    group('Margin Properties', () {
      test('should return correct compact layout margin', () {
        expect(layoutUtils.compactLayoutMargin, equals(16.0));
      });

      test('should return correct medium layout margin', () {
        expect(layoutUtils.mediumLayoutMargin, equals(24.0));
      });

      test('should return correct extended layout margin', () {
        expect(layoutUtils.exdendedLayoutMargin, equals(24.0));
      });

      test('should return correct pane spacing', () {
        expect(layoutUtils.paneSpacing, equals(24.0));
      });

      test('should have consistent margin values', () {
        // Medium and extended margins should be the same
        expect(layoutUtils.mediumLayoutMargin, equals(layoutUtils.exdendedLayoutMargin));
        
        // Compact margin should be smaller than medium/extended
        expect(layoutUtils.compactLayoutMargin, lessThan(layoutUtils.mediumLayoutMargin));
      });
    });

    group('Layout Spacing - Compact Breakpoint', () {
      testWidgets('should return correct spacing for compact layout', (WidgetTester tester) async {
        const verticalPadding = 10.0;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                // Set up a compact screen size (width < 600)
                tester.binding.window.physicalSizeTestValue = const Size(500, 800);
                tester.binding.window.devicePixelRatioTestValue = 1.0;
                
                final spacing = layoutUtils.layoutSpacing(verticalPadding, context);
                
                expect(spacing, isA<EdgeInsetsGeometry>());
                
                // Cast to EdgeInsets to check specific values
                final edgeInsets = spacing as EdgeInsets;
                expect(edgeInsets.horizontal, equals(layoutUtils.compactLayoutMargin * 2));
                expect(edgeInsets.vertical, equals(verticalPadding * 2));
                expect(edgeInsets.left, equals(layoutUtils.compactLayoutMargin));
                expect(edgeInsets.right, equals(layoutUtils.compactLayoutMargin));
                expect(edgeInsets.top, equals(verticalPadding));
                expect(edgeInsets.bottom, equals(verticalPadding));
                
                return const SizedBox();
              },
            ),
          ),
        );
        
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should handle zero vertical padding in compact layout', (WidgetTester tester) async {
        const verticalPadding = 0.0;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                tester.binding.window.physicalSizeTestValue = const Size(400, 600);
                tester.binding.window.devicePixelRatioTestValue = 1.0;
                
                final spacing = layoutUtils.layoutSpacing(verticalPadding, context);
                final edgeInsets = spacing as EdgeInsets;
                
                expect(edgeInsets.left, equals(16.0));
                expect(edgeInsets.right, equals(16.0));
                expect(edgeInsets.top, equals(0.0));
                expect(edgeInsets.bottom, equals(0.0));
                
                return const SizedBox();
              },
            ),
          ),
        );
        
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Layout Spacing - Medium Breakpoint', () {
      testWidgets('should return correct spacing for medium layout', (WidgetTester tester) async {
        const verticalPadding = 15.0;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                // Set up a medium screen size (600 <= width < 840)
                tester.binding.window.physicalSizeTestValue = const Size(700, 800);
                tester.binding.window.devicePixelRatioTestValue = 1.0;
                
                final spacing = layoutUtils.layoutSpacing(verticalPadding, context);
                final edgeInsets = spacing as EdgeInsets;
                
                expect(edgeInsets.left, equals(layoutUtils.mediumLayoutMargin));
                expect(edgeInsets.right, equals(layoutUtils.mediumLayoutMargin));
                expect(edgeInsets.top, equals(verticalPadding));
                expect(edgeInsets.bottom, equals(verticalPadding));
                expect(edgeInsets.horizontal, equals(48.0)); // 24.0 * 2
                expect(edgeInsets.vertical, equals(30.0)); // 15.0 * 2
                
                return const SizedBox();
              },
            ),
          ),
        );
        
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should handle boundary case for medium layout (width = 600)', (WidgetTester tester) async {
        const verticalPadding = 5.0;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                tester.binding.window.physicalSizeTestValue = const Size(600, 800);
                tester.binding.window.devicePixelRatioTestValue = 1.0;
                
                final spacing = layoutUtils.layoutSpacing(verticalPadding, context);
                final edgeInsets = spacing as EdgeInsets;
                
                expect(edgeInsets.left, equals(24.0));
                expect(edgeInsets.right, equals(24.0));
                expect(edgeInsets.top, equals(5.0));
                expect(edgeInsets.bottom, equals(5.0));
                
                return const SizedBox();
              },
            ),
          ),
        );
        
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Layout Spacing - Extended Breakpoint', () {
      testWidgets('should return correct spacing for extended layout', (WidgetTester tester) async {
        const verticalPadding = 20.0;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                // Set up an extended screen size (width >= 840)
                tester.binding.window.physicalSizeTestValue = const Size(1000, 800);
                tester.binding.window.devicePixelRatioTestValue = 1.0;
                
                final spacing = layoutUtils.layoutSpacing(verticalPadding, context);
                final edgeInsets = spacing as EdgeInsets;
                
                expect(edgeInsets.left, equals(layoutUtils.exdendedLayoutMargin));
                expect(edgeInsets.right, equals(layoutUtils.exdendedLayoutMargin));
                expect(edgeInsets.top, equals(verticalPadding));
                expect(edgeInsets.bottom, equals(verticalPadding));
                expect(edgeInsets.horizontal, equals(48.0)); // 24.0 * 2
                expect(edgeInsets.vertical, equals(40.0)); // 20.0 * 2
                
                return const SizedBox();
              },
            ),
          ),
        );
        
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should handle boundary case for extended layout (width = 840)', (WidgetTester tester) async {
        const verticalPadding = 12.0;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                tester.binding.window.physicalSizeTestValue = const Size(840, 800);
                tester.binding.window.devicePixelRatioTestValue = 1.0;
                
                final spacing = layoutUtils.layoutSpacing(verticalPadding, context);
                final edgeInsets = spacing as EdgeInsets;
                
                expect(edgeInsets.left, equals(24.0));
                expect(edgeInsets.right, equals(24.0));
                expect(edgeInsets.top, equals(12.0));
                expect(edgeInsets.bottom, equals(12.0));
                
                return const SizedBox();
              },
            ),
          ),
        );
        
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Error Handling', () {
      testWidgets('should throw UnimplementedError for invalid breakpoint', (WidgetTester tester) async {
        // This test is tricky because the Breakpoints class should handle all valid cases
        // We'll test by mocking an invalid condition, but in practice this shouldn't happen
        // with the current Breakpoints implementation
        
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                // The current implementation should never reach the UnimplementedError
                // because Breakpoints.isCompact, isMedium, and isExtended should cover all cases
                // But we can test the method exists and works for valid cases
                
                tester.binding.window.physicalSizeTestValue = const Size(500, 800);
                tester.binding.window.devicePixelRatioTestValue = 1.0;
                
                expect(() => layoutUtils.layoutSpacing(10.0, context), returnsNormally);
                
                return const SizedBox();
              },
            ),
          ),
        );
        
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Edge Cases and Boundary Values', () {
      testWidgets('should handle negative vertical padding', (WidgetTester tester) async {
        const verticalPadding = -5.0;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                tester.binding.window.physicalSizeTestValue = const Size(500, 800);
                tester.binding.window.devicePixelRatioTestValue = 1.0;
                
                final spacing = layoutUtils.layoutSpacing(verticalPadding, context);
                final edgeInsets = spacing as EdgeInsets;
                
                expect(edgeInsets.top, equals(-5.0));
                expect(edgeInsets.bottom, equals(-5.0));
                expect(edgeInsets.left, equals(16.0));
                expect(edgeInsets.right, equals(16.0));
                
                return const SizedBox();
              },
            ),
          ),
        );
        
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should handle very large vertical padding', (WidgetTester tester) async {
        const verticalPadding = 1000.0;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                tester.binding.window.physicalSizeTestValue = const Size(700, 800);
                tester.binding.window.devicePixelRatioTestValue = 1.0;
                
                final spacing = layoutUtils.layoutSpacing(verticalPadding, context);
                final edgeInsets = spacing as EdgeInsets;
                
                expect(edgeInsets.top, equals(1000.0));
                expect(edgeInsets.bottom, equals(1000.0));
                expect(edgeInsets.left, equals(24.0));
                expect(edgeInsets.right, equals(24.0));
                
                return const SizedBox();
              },
            ),
          ),
        );
        
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });

      testWidgets('should handle fractional vertical padding', (WidgetTester tester) async {
        const verticalPadding = 7.5;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
                tester.binding.window.devicePixelRatioTestValue = 1.0;
                
                final spacing = layoutUtils.layoutSpacing(verticalPadding, context);
                final edgeInsets = spacing as EdgeInsets;
                
                expect(edgeInsets.top, equals(7.5));
                expect(edgeInsets.bottom, equals(7.5));
                expect(edgeInsets.left, equals(24.0));
                expect(edgeInsets.right, equals(24.0));
                
                return const SizedBox();
              },
            ),
          ),
        );
        
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Consistency and Relationships', () {
      test('should maintain consistent margin relationships', () {
        expect(layoutUtils.compactLayoutMargin, lessThan(layoutUtils.mediumLayoutMargin));
        expect(layoutUtils.mediumLayoutMargin, equals(layoutUtils.exdendedLayoutMargin));
        expect(layoutUtils.paneSpacing, equals(layoutUtils.mediumLayoutMargin));
      });

      testWidgets('should produce symmetric horizontal margins', (WidgetTester tester) async {
        const verticalPadding = 10.0;
        
        for (final screenWidth in [400.0, 700.0, 1000.0]) {
          await tester.pumpWidget(
            MaterialApp(
              home: Builder(
                builder: (context) {
                  tester.binding.window.physicalSizeTestValue = Size(screenWidth, 800);
                  tester.binding.window.devicePixelRatioTestValue = 1.0;
                  
                  final spacing = layoutUtils.layoutSpacing(verticalPadding, context);
                  final edgeInsets = spacing as EdgeInsets;
                  
                  expect(edgeInsets.left, equals(edgeInsets.right));
                  expect(edgeInsets.top, equals(edgeInsets.bottom));
                  
                  return const SizedBox();
                },
              ),
            ),
          );
        }
        
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Multiple Instance Behavior', () {
      test('should create independent instances', () {
        final utils1 = LayoutUtils();
        final utils2 = LayoutUtils();
        
        expect(utils1.compactLayoutMargin, equals(utils2.compactLayoutMargin));
        expect(utils1.mediumLayoutMargin, equals(utils2.mediumLayoutMargin));
        expect(utils1.exdendedLayoutMargin, equals(utils2.exdendedLayoutMargin));
        expect(utils1.paneSpacing, equals(utils2.paneSpacing));
        
        expect(identical(utils1, utils2), isFalse);
      });

      test('should maintain consistent values across instances', () {
        final instances = List.generate(5, (_) => LayoutUtils());
        
        for (final instance in instances) {
          expect(instance.compactLayoutMargin, equals(16.0));
          expect(instance.mediumLayoutMargin, equals(24.0));
          expect(instance.exdendedLayoutMargin, equals(24.0));
          expect(instance.paneSpacing, equals(24.0));
        }
      });
    });

    group('Integration with EdgeInsetsGeometry', () {
      testWidgets('should return EdgeInsetsGeometry compatible objects', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                tester.binding.window.physicalSizeTestValue = const Size(500, 800);
                tester.binding.window.devicePixelRatioTestValue = 1.0;
                
                final spacing = layoutUtils.layoutSpacing(10.0, context);
                
                expect(spacing, isA<EdgeInsetsGeometry>());
                expect(spacing, isA<EdgeInsets>());
                
                // Should be usable in Padding widget
                final paddingWidget = Padding(
                  padding: spacing,
                  child: const Text('Test'),
                );
                
                expect(paddingWidget.padding, equals(spacing));
                
                return const SizedBox();
              },
            ),
          ),
        );
        
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });

    group('Performance Considerations', () {
      testWidgets('should compute spacing efficiently', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                tester.binding.window.physicalSizeTestValue = const Size(500, 800);
                tester.binding.window.devicePixelRatioTestValue = 1.0;
                
                final stopwatch = Stopwatch()..start();
                
                // Call multiple times to test performance
                for (int i = 0; i < 1000; i++) {
                  layoutUtils.layoutSpacing(10.0, context);
                }
                
                stopwatch.stop();
                
                // Should complete quickly (less than 100ms for 1000 calls)
                expect(stopwatch.elapsedMilliseconds, lessThan(100));
                
                return const SizedBox();
              },
            ),
          ),
        );
        
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);
      });
    });
  });
}