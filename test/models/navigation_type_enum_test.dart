import 'package:flutter_test/flutter_test.dart';
import 'package:material3_layout/src/models/navigation_type_enum.dart';

void main() {
  group('NavigationTypeEnum', () {
    group('Enum Values', () {
      test('should have all expected enum values', () {
        expect(NavigationTypeEnum.values.length, equals(3));
        expect(NavigationTypeEnum.values, contains(NavigationTypeEnum.railAndBottomNavBar));
        expect(NavigationTypeEnum.values, contains(NavigationTypeEnum.modalDrawer));
        expect(NavigationTypeEnum.values, contains(NavigationTypeEnum.drawer));
      });

      test('should have correct enum value names', () {
        expect(NavigationTypeEnum.railAndBottomNavBar.name, equals('railAndBottomNavBar'));
        expect(NavigationTypeEnum.modalDrawer.name, equals('modalDrawer'));
        expect(NavigationTypeEnum.drawer.name, equals('drawer'));
      });

      test('should have correct enum indices', () {
        expect(NavigationTypeEnum.railAndBottomNavBar.index, equals(0));
        expect(NavigationTypeEnum.modalDrawer.index, equals(1));
        expect(NavigationTypeEnum.drawer.index, equals(2));
      });
    });

    group('Enum Comparison', () {
      test('should compare enum values correctly', () {
        expect(NavigationTypeEnum.railAndBottomNavBar == NavigationTypeEnum.railAndBottomNavBar, isTrue);
        expect(NavigationTypeEnum.modalDrawer == NavigationTypeEnum.modalDrawer, isTrue);
        expect(NavigationTypeEnum.drawer == NavigationTypeEnum.drawer, isTrue);

        expect(NavigationTypeEnum.railAndBottomNavBar == NavigationTypeEnum.modalDrawer, isFalse);
        expect(NavigationTypeEnum.railAndBottomNavBar == NavigationTypeEnum.drawer, isFalse);
        expect(NavigationTypeEnum.modalDrawer == NavigationTypeEnum.drawer, isFalse);
      });

      test('should have consistent hash codes', () {
        expect(NavigationTypeEnum.railAndBottomNavBar.hashCode, 
               equals(NavigationTypeEnum.railAndBottomNavBar.hashCode));
        expect(NavigationTypeEnum.modalDrawer.hashCode, 
               equals(NavigationTypeEnum.modalDrawer.hashCode));
        expect(NavigationTypeEnum.drawer.hashCode, 
               equals(NavigationTypeEnum.drawer.hashCode));
      });
    });

    group('String Representation', () {
      test('should have correct toString representation', () {
        expect(NavigationTypeEnum.railAndBottomNavBar.toString(), 
               equals('NavigationTypeEnum.railAndBottomNavBar'));
        expect(NavigationTypeEnum.modalDrawer.toString(), 
               equals('NavigationTypeEnum.modalDrawer'));
        expect(NavigationTypeEnum.drawer.toString(), 
               equals('NavigationTypeEnum.drawer'));
      });
    });

    group('Enum Iteration', () {
      test('should iterate through all values correctly', () {
        final values = <NavigationTypeEnum>[];
        for (final value in NavigationTypeEnum.values) {
          values.add(value);
        }

        expect(values.length, equals(3));
        expect(values[0], equals(NavigationTypeEnum.railAndBottomNavBar));
        expect(values[1], equals(NavigationTypeEnum.modalDrawer));
        expect(values[2], equals(NavigationTypeEnum.drawer));
      });

      test('should work with switch statements', () {
        String getDescription(NavigationTypeEnum type) {
          switch (type) {
            case NavigationTypeEnum.railAndBottomNavBar:
              return 'Rail and Bottom Navigation Bar';
            case NavigationTypeEnum.modalDrawer:
              return 'Modal Drawer';
            case NavigationTypeEnum.drawer:
              return 'Standard Drawer';
          }
        }

        expect(getDescription(NavigationTypeEnum.railAndBottomNavBar), 
               equals('Rail and Bottom Navigation Bar'));
        expect(getDescription(NavigationTypeEnum.modalDrawer), 
               equals('Modal Drawer'));
        expect(getDescription(NavigationTypeEnum.drawer), 
               equals('Standard Drawer'));
      });
    });

    group('Collections and Sets', () {
      test('should work correctly in Lists', () {
        final list = [
          NavigationTypeEnum.railAndBottomNavBar,
          NavigationTypeEnum.modalDrawer,
          NavigationTypeEnum.drawer,
        ];

        expect(list.length, equals(3));
        expect(list.contains(NavigationTypeEnum.railAndBottomNavBar), isTrue);
        expect(list.contains(NavigationTypeEnum.modalDrawer), isTrue);
        expect(list.contains(NavigationTypeEnum.drawer), isTrue);
      });

      test('should work correctly in Sets', () {
        final set = {
          NavigationTypeEnum.railAndBottomNavBar,
          NavigationTypeEnum.modalDrawer,
          NavigationTypeEnum.drawer,
          NavigationTypeEnum.railAndBottomNavBar, // Duplicate should be ignored
        };

        expect(set.length, equals(3));
        expect(set.contains(NavigationTypeEnum.railAndBottomNavBar), isTrue);
        expect(set.contains(NavigationTypeEnum.modalDrawer), isTrue);
        expect(set.contains(NavigationTypeEnum.drawer), isTrue);
      });

      test('should work correctly in Maps', () {
        final map = {
          NavigationTypeEnum.railAndBottomNavBar: 'Rail and Bottom',
          NavigationTypeEnum.modalDrawer: 'Modal Drawer',
          NavigationTypeEnum.drawer: 'Standard Drawer',
        };

        expect(map.length, equals(3));
        expect(map[NavigationTypeEnum.railAndBottomNavBar], equals('Rail and Bottom'));
        expect(map[NavigationTypeEnum.modalDrawer], equals('Modal Drawer'));
        expect(map[NavigationTypeEnum.drawer], equals('Standard Drawer'));
      });
    });

    group('Functional Operations', () {
      test('should work with where clause', () {
        final drawerTypes = NavigationTypeEnum.values
            .where((type) => type.name.contains('drawer'))
            .toList();

        expect(drawerTypes.length, equals(2));
        expect(drawerTypes, contains(NavigationTypeEnum.modalDrawer));
        expect(drawerTypes, contains(NavigationTypeEnum.drawer));
        expect(drawerTypes, isNot(contains(NavigationTypeEnum.railAndBottomNavBar)));
      });

      test('should work with map operation', () {
        final names = NavigationTypeEnum.values
            .map((type) => type.name)
            .toList();

        expect(names.length, equals(3));
        expect(names, contains('railAndBottomNavBar'));
        expect(names, contains('modalDrawer'));
        expect(names, contains('drawer'));
      });

      test('should work with firstWhere', () {
        final railType = NavigationTypeEnum.values
            .firstWhere((type) => type.name.contains('rail'));

        expect(railType, equals(NavigationTypeEnum.railAndBottomNavBar));
      });
    });

    group('Type Safety', () {
      test('should maintain type safety', () {
        NavigationTypeEnum type = NavigationTypeEnum.railAndBottomNavBar;
        
        expect(type, isA<NavigationTypeEnum>());
        expect(type.runtimeType, equals(NavigationTypeEnum));
      });

      test('should work with generic collections', () {
        List<NavigationTypeEnum> typeList = [
          NavigationTypeEnum.railAndBottomNavBar,
          NavigationTypeEnum.modalDrawer,
        ];

        expect(typeList, isA<List<NavigationTypeEnum>>());
        expect(typeList.first, isA<NavigationTypeEnum>());
      });
    });

    group('Edge Cases', () {
      test('should handle null comparisons safely', () {
        NavigationTypeEnum? nullableType;
        
        expect(nullableType == NavigationTypeEnum.railAndBottomNavBar, isFalse);
        expect(NavigationTypeEnum.railAndBottomNavBar == nullableType, isFalse);
        
        nullableType = NavigationTypeEnum.drawer;
        expect(nullableType == NavigationTypeEnum.drawer, isTrue);
      });

      test('should work with conditional expressions', () {
        final type = NavigationTypeEnum.modalDrawer;
        final isDrawer = type == NavigationTypeEnum.drawer || 
                        type == NavigationTypeEnum.modalDrawer;
        
        expect(isDrawer, isTrue);
      });
    });

    group('Documentation Compliance', () {
      test('should match documented behavior for railAndBottomNavBar', () {
        // Based on the comment: "Shows a navigation rail on medium and extended screens 
        // and a bottom navigation bar on the compact screen"
        final type = NavigationTypeEnum.railAndBottomNavBar;
        expect(type.name, equals('railAndBottomNavBar'));
        expect(type.index, equals(0));
      });

      test('should match documented behavior for modalDrawer', () {
        // Based on the comment: "Shows a material 3 modal drawer"
        final type = NavigationTypeEnum.modalDrawer;
        expect(type.name, equals('modalDrawer'));
        expect(type.index, equals(1));
      });

      test('should match documented behavior for drawer', () {
        // Based on the comment: "Shows a material 3 standard drawer"
        final type = NavigationTypeEnum.drawer;
        expect(type.name, equals('drawer'));
        expect(type.index, equals(2));
      });
    });
  });
}