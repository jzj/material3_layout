import 'package:flutter_test/flutter_test.dart';
import 'package:material3_layout/src/layouts/enum/layouts_enum.dart';

void main() {
  group('LayoutsEnum', () {
    group('Enum Values', () {
      test('should have all expected enum values', () {
        expect(LayoutsEnum.values.length, equals(3));
        expect(LayoutsEnum.values, contains(LayoutsEnum.singlePane));
        expect(LayoutsEnum.values, contains(LayoutsEnum.twoPane));
        expect(LayoutsEnum.values, contains(LayoutsEnum.splitPane));
      });

      test('should have correct enum value names', () {
        expect(LayoutsEnum.singlePane.name, equals('singlePane'));
        expect(LayoutsEnum.twoPane.name, equals('twoPane'));
        expect(LayoutsEnum.splitPane.name, equals('splitPane'));
      });

      test('should have correct enum indices', () {
        expect(LayoutsEnum.singlePane.index, equals(0));
        expect(LayoutsEnum.twoPane.index, equals(1));
        expect(LayoutsEnum.splitPane.index, equals(2));
      });
    });

    group('Enum Comparison', () {
      test('should compare enum values correctly', () {
        expect(LayoutsEnum.singlePane == LayoutsEnum.singlePane, isTrue);
        expect(LayoutsEnum.twoPane == LayoutsEnum.twoPane, isTrue);
        expect(LayoutsEnum.splitPane == LayoutsEnum.splitPane, isTrue);

        expect(LayoutsEnum.singlePane == LayoutsEnum.twoPane, isFalse);
        expect(LayoutsEnum.singlePane == LayoutsEnum.splitPane, isFalse);
        expect(LayoutsEnum.twoPane == LayoutsEnum.splitPane, isFalse);
      });

      test('should have consistent hash codes', () {
        expect(LayoutsEnum.singlePane.hashCode, 
               equals(LayoutsEnum.singlePane.hashCode));
        expect(LayoutsEnum.twoPane.hashCode, 
               equals(LayoutsEnum.twoPane.hashCode));
        expect(LayoutsEnum.splitPane.hashCode, 
               equals(LayoutsEnum.splitPane.hashCode));
      });
    });

    group('String Representation', () {
      test('should have correct toString representation', () {
        expect(LayoutsEnum.singlePane.toString(), 
               equals('LayoutsEnum.singlePane'));
        expect(LayoutsEnum.twoPane.toString(), 
               equals('LayoutsEnum.twoPane'));
        expect(LayoutsEnum.splitPane.toString(), 
               equals('LayoutsEnum.splitPane'));
      });
    });

    group('Enum Iteration', () {
      test('should iterate through all values correctly', () {
        final values = <LayoutsEnum>[];
        for (final value in LayoutsEnum.values) {
          values.add(value);
        }

        expect(values.length, equals(3));
        expect(values[0], equals(LayoutsEnum.singlePane));
        expect(values[1], equals(LayoutsEnum.twoPane));
        expect(values[2], equals(LayoutsEnum.splitPane));
      });

      test('should work with switch statements', () {
        String getDescription(LayoutsEnum layout) {
          switch (layout) {
            case LayoutsEnum.singlePane:
              return 'Single pane layout where only one page is displayed at a time';
            case LayoutsEnum.twoPane:
              return 'Two pane layout where two pages are displayed side by side';
            case LayoutsEnum.splitPane:
              return 'Split pane layout where two equal pages are displayed with a divider';
          }
        }

        expect(getDescription(LayoutsEnum.singlePane), 
               equals('Single pane layout where only one page is displayed at a time'));
        expect(getDescription(LayoutsEnum.twoPane), 
               equals('Two pane layout where two pages are displayed side by side'));
        expect(getDescription(LayoutsEnum.splitPane), 
               equals('Split pane layout where two equal pages are displayed with a divider'));
      });
    });

    group('Collections and Sets', () {
      test('should work correctly in Lists', () {
        final list = [
          LayoutsEnum.singlePane,
          LayoutsEnum.twoPane,
          LayoutsEnum.splitPane,
        ];

        expect(list.length, equals(3));
        expect(list.contains(LayoutsEnum.singlePane), isTrue);
        expect(list.contains(LayoutsEnum.twoPane), isTrue);
        expect(list.contains(LayoutsEnum.splitPane), isTrue);
      });

      test('should work correctly in Sets', () {
        final set = {
          LayoutsEnum.singlePane,
          LayoutsEnum.twoPane,
          LayoutsEnum.splitPane,
          LayoutsEnum.singlePane, // Duplicate should be ignored
        };

        expect(set.length, equals(3));
        expect(set.contains(LayoutsEnum.singlePane), isTrue);
        expect(set.contains(LayoutsEnum.twoPane), isTrue);
        expect(set.contains(LayoutsEnum.splitPane), isTrue);
      });

      test('should work correctly in Maps', () {
        final map = {
          LayoutsEnum.singlePane: 'Single Pane',
          LayoutsEnum.twoPane: 'Two Pane',
          LayoutsEnum.splitPane: 'Split Pane',
        };

        expect(map.length, equals(3));
        expect(map[LayoutsEnum.singlePane], equals('Single Pane'));
        expect(map[LayoutsEnum.twoPane], equals('Two Pane'));
        expect(map[LayoutsEnum.splitPane], equals('Split Pane'));
      });
    });

    group('Functional Operations', () {
      test('should work with where clause', () {
        final paneLayouts = LayoutsEnum.values
            .where((layout) => layout.name.contains('Pane'))
            .toList();

        expect(paneLayouts.length, equals(3));
        expect(paneLayouts, contains(LayoutsEnum.singlePane));
        expect(paneLayouts, contains(LayoutsEnum.twoPane));
        expect(paneLayouts, contains(LayoutsEnum.splitPane));
      });

      test('should work with map operation', () {
        final names = LayoutsEnum.values
            .map((layout) => layout.name)
            .toList();

        expect(names.length, equals(3));
        expect(names, contains('singlePane'));
        expect(names, contains('twoPane'));
        expect(names, contains('splitPane'));
      });

      test('should work with firstWhere', () {
        final splitLayout = LayoutsEnum.values
            .firstWhere((layout) => layout.name.contains('split'));

        expect(splitLayout, equals(LayoutsEnum.splitPane));
      });
    });

    group('Type Safety', () {
      test('should maintain type safety', () {
        LayoutsEnum layout = LayoutsEnum.singlePane;
        
        expect(layout, isA<LayoutsEnum>());
        expect(layout.runtimeType, equals(LayoutsEnum));
      });

      test('should work with generic collections', () {
        List<LayoutsEnum> layoutList = [
          LayoutsEnum.singlePane,
          LayoutsEnum.twoPane,
        ];

        expect(layoutList, isA<List<LayoutsEnum>>());
        expect(layoutList.first, isA<LayoutsEnum>());
      });
    });

    group('Edge Cases', () {
      test('should handle null comparisons safely', () {
        LayoutsEnum? nullableLayout;
        
        expect(nullableLayout == LayoutsEnum.singlePane, isFalse);
        expect(LayoutsEnum.singlePane == nullableLayout, isFalse);
        
        nullableLayout = LayoutsEnum.twoPane;
        expect(nullableLayout == LayoutsEnum.twoPane, isTrue);
      });

      test('should work with conditional expressions', () {
        final layout = LayoutsEnum.splitPane;
        final isSplitLayout = layout == LayoutsEnum.splitPane;
        
        expect(isSplitLayout, isTrue);
      });
    });

    group('Documentation Compliance', () {
      test('should match documented behavior for singlePane', () {
        // Based on the comment: "Single pane layout where only one page is displayed at a time."
        final layout = LayoutsEnum.singlePane;
        expect(layout.name, equals('singlePane'));
        expect(layout.index, equals(0));
      });

      test('should match documented behavior for twoPane', () {
        // Based on the comment: "Two pane layout where two pages are displayed side by side.
        // First pane is fixed and second pane is flexible"
        final layout = LayoutsEnum.twoPane;
        expect(layout.name, equals('twoPane'));
        expect(layout.index, equals(1));
      });

      test('should match documented behavior for splitPane', () {
        // Based on the comment: "Split pane layout where two equal pages are displayed with a divider between them."
        final layout = LayoutsEnum.splitPane;
        expect(layout.name, equals('splitPane'));
        expect(layout.index, equals(2));
      });
    });

    group('Use Case Scenarios', () {
      test('should work in layout selection logic', () {
        bool isMultiPaneLayout(LayoutsEnum layout) {
          return layout == LayoutsEnum.twoPane || layout == LayoutsEnum.splitPane;
        }

        expect(isMultiPaneLayout(LayoutsEnum.singlePane), isFalse);
        expect(isMultiPaneLayout(LayoutsEnum.twoPane), isTrue);
        expect(isMultiPaneLayout(LayoutsEnum.splitPane), isTrue);
      });

      test('should work in responsive design configuration', () {
        Map<LayoutsEnum, int> getPaneCount() {
          return {
            LayoutsEnum.singlePane: 1,
            LayoutsEnum.twoPane: 2,
            LayoutsEnum.splitPane: 2,
          };
        }

        final paneCounts = getPaneCount();
        expect(paneCounts[LayoutsEnum.singlePane], equals(1));
        expect(paneCounts[LayoutsEnum.twoPane], equals(2));
        expect(paneCounts[LayoutsEnum.splitPane], equals(2));
      });

      test('should work in layout priority ordering', () {
        final layoutsByComplexity = LayoutsEnum.values.toList()
          ..sort((a, b) => a.index.compareTo(b.index));

        expect(layoutsByComplexity[0], equals(LayoutsEnum.singlePane));
        expect(layoutsByComplexity[1], equals(LayoutsEnum.twoPane));
        expect(layoutsByComplexity[2], equals(LayoutsEnum.splitPane));
      });
    });

    group('Layout Characteristics', () {
      test('should identify fixed vs flexible pane layouts', () {
        bool hasFixedPane(LayoutsEnum layout) {
          return layout == LayoutsEnum.twoPane;
        }

        expect(hasFixedPane(LayoutsEnum.singlePane), isFalse);
        expect(hasFixedPane(LayoutsEnum.twoPane), isTrue);
        expect(hasFixedPane(LayoutsEnum.splitPane), isFalse);
      });

      test('should identify equal pane layouts', () {
        bool hasEqualPanes(LayoutsEnum layout) {
          return layout == LayoutsEnum.splitPane;
        }

        expect(hasEqualPanes(LayoutsEnum.singlePane), isFalse);
        expect(hasEqualPanes(LayoutsEnum.twoPane), isFalse);
        expect(hasEqualPanes(LayoutsEnum.splitPane), isTrue);
      });
    });
  });
}