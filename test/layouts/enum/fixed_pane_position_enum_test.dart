import 'package:flutter_test/flutter_test.dart';
import 'package:material3_layout/src/layouts/enum/fixed_pane_position_enum.dart';

void main() {
  group('FixedPanePositionEnum', () {
    group('Enum Values', () {
      test('should have all expected enum values', () {
        expect(FixedPanePositionEnum.values.length, equals(2));
        expect(FixedPanePositionEnum.values, contains(FixedPanePositionEnum.left));
        expect(FixedPanePositionEnum.values, contains(FixedPanePositionEnum.right));
      });

      test('should have correct enum value names', () {
        expect(FixedPanePositionEnum.left.name, equals('left'));
        expect(FixedPanePositionEnum.right.name, equals('right'));
      });

      test('should have correct enum indices', () {
        expect(FixedPanePositionEnum.left.index, equals(0));
        expect(FixedPanePositionEnum.right.index, equals(1));
      });
    });

    group('Enum Comparison', () {
      test('should compare enum values correctly', () {
        expect(FixedPanePositionEnum.left == FixedPanePositionEnum.left, isTrue);
        expect(FixedPanePositionEnum.right == FixedPanePositionEnum.right, isTrue);
        expect(FixedPanePositionEnum.left == FixedPanePositionEnum.right, isFalse);
        expect(FixedPanePositionEnum.right == FixedPanePositionEnum.left, isFalse);
      });

      test('should have consistent hash codes', () {
        expect(FixedPanePositionEnum.left.hashCode, 
               equals(FixedPanePositionEnum.left.hashCode));
        expect(FixedPanePositionEnum.right.hashCode, 
               equals(FixedPanePositionEnum.right.hashCode));
      });
    });

    group('String Representation', () {
      test('should have correct toString representation', () {
        expect(FixedPanePositionEnum.left.toString(), 
               equals('FixedPanePositionEnum.left'));
        expect(FixedPanePositionEnum.right.toString(), 
               equals('FixedPanePositionEnum.right'));
      });
    });

    group('Enum Iteration', () {
      test('should iterate through all values correctly', () {
        final values = <FixedPanePositionEnum>[];
        for (final value in FixedPanePositionEnum.values) {
          values.add(value);
        }

        expect(values.length, equals(2));
        expect(values[0], equals(FixedPanePositionEnum.left));
        expect(values[1], equals(FixedPanePositionEnum.right));
      });

      test('should work with switch statements', () {
        String getDescription(FixedPanePositionEnum position) {
          switch (position) {
            case FixedPanePositionEnum.left:
              return 'Fixed pane positioned to the left';
            case FixedPanePositionEnum.right:
              return 'Fixed pane positioned to the right';
          }
        }

        expect(getDescription(FixedPanePositionEnum.left), 
               equals('Fixed pane positioned to the left'));
        expect(getDescription(FixedPanePositionEnum.right), 
               equals('Fixed pane positioned to the right'));
      });
    });

    group('Collections and Sets', () {
      test('should work correctly in Lists', () {
        final list = [
          FixedPanePositionEnum.left,
          FixedPanePositionEnum.right,
        ];

        expect(list.length, equals(2));
        expect(list.contains(FixedPanePositionEnum.left), isTrue);
        expect(list.contains(FixedPanePositionEnum.right), isTrue);
      });

      test('should work correctly in Sets', () {
        final set = {
          FixedPanePositionEnum.left,
          FixedPanePositionEnum.right,
          FixedPanePositionEnum.left, // Duplicate should be ignored
        };

        expect(set.length, equals(2));
        expect(set.contains(FixedPanePositionEnum.left), isTrue);
        expect(set.contains(FixedPanePositionEnum.right), isTrue);
      });

      test('should work correctly in Maps', () {
        final map = {
          FixedPanePositionEnum.left: 'Left Position',
          FixedPanePositionEnum.right: 'Right Position',
        };

        expect(map.length, equals(2));
        expect(map[FixedPanePositionEnum.left], equals('Left Position'));
        expect(map[FixedPanePositionEnum.right], equals('Right Position'));
      });
    });

    group('Functional Operations', () {
      test('should work with where clause', () {
        final leftPositions = FixedPanePositionEnum.values
            .where((position) => position.name.contains('left'))
            .toList();

        expect(leftPositions.length, equals(1));
        expect(leftPositions, contains(FixedPanePositionEnum.left));
        expect(leftPositions, isNot(contains(FixedPanePositionEnum.right)));
      });

      test('should work with map operation', () {
        final names = FixedPanePositionEnum.values
            .map((position) => position.name)
            .toList();

        expect(names.length, equals(2));
        expect(names, contains('left'));
        expect(names, contains('right'));
      });

      test('should work with firstWhere', () {
        final rightPosition = FixedPanePositionEnum.values
            .firstWhere((position) => position.name.contains('right'));

        expect(rightPosition, equals(FixedPanePositionEnum.right));
      });
    });

    group('Type Safety', () {
      test('should maintain type safety', () {
        FixedPanePositionEnum position = FixedPanePositionEnum.left;
        
        expect(position, isA<FixedPanePositionEnum>());
        expect(position.runtimeType, equals(FixedPanePositionEnum));
      });

      test('should work with generic collections', () {
        List<FixedPanePositionEnum> positionList = [
          FixedPanePositionEnum.left,
          FixedPanePositionEnum.right,
        ];

        expect(positionList, isA<List<FixedPanePositionEnum>>());
        expect(positionList.first, isA<FixedPanePositionEnum>());
      });
    });

    group('Edge Cases', () {
      test('should handle null comparisons safely', () {
        FixedPanePositionEnum? nullablePosition;
        
        expect(nullablePosition == FixedPanePositionEnum.left, isFalse);
        expect(FixedPanePositionEnum.left == nullablePosition, isFalse);
        
        nullablePosition = FixedPanePositionEnum.right;
        expect(nullablePosition == FixedPanePositionEnum.right, isTrue);
      });

      test('should work with conditional expressions', () {
        final position = FixedPanePositionEnum.left;
        final isLeftPosition = position == FixedPanePositionEnum.left;
        
        expect(isLeftPosition, isTrue);
      });
    });

    group('Documentation Compliance', () {
      test('should match documented behavior for left position', () {
        // Based on the comment: "The fixed pane is positioned to the left."
        final position = FixedPanePositionEnum.left;
        expect(position.name, equals('left'));
        expect(position.index, equals(0));
      });

      test('should match documented behavior for right position', () {
        // Based on the comment: "The fixed pane is positioned to the right."
        final position = FixedPanePositionEnum.right;
        expect(position.name, equals('right'));
        expect(position.index, equals(1));
      });
    });

    group('Use Case Scenarios', () {
      test('should work in layout positioning logic', () {
        bool isLeftAligned(FixedPanePositionEnum position) {
          return position == FixedPanePositionEnum.left;
        }

        expect(isLeftAligned(FixedPanePositionEnum.left), isTrue);
        expect(isLeftAligned(FixedPanePositionEnum.right), isFalse);
      });

      test('should work in UI configuration', () {
        Map<FixedPanePositionEnum, String> getFlexDirection() {
          return {
            FixedPanePositionEnum.left: 'row',
            FixedPanePositionEnum.right: 'row-reverse',
          };
        }

        final directions = getFlexDirection();
        expect(directions[FixedPanePositionEnum.left], equals('row'));
        expect(directions[FixedPanePositionEnum.right], equals('row-reverse'));
      });
    });
  });
}