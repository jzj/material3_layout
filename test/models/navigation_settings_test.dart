import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material3_layout/src/models/navigation_settings.dart';
import 'package:material3_layout/src/models/navigation_type_enum.dart';

// Concrete implementation of NavigationSettings for testing
class TestNavigationSettings extends NavigationSettings<String> {
  TestNavigationSettings({
    required super.pages,
    required super.destinations,
    required super.type,
  });
}

void main() {
  group('NavigationSettings', () {
    group('Constructor', () {
      test('should create instance with required parameters', () {
        final pages = [
          const Text('Page 1'),
          const Text('Page 2'),
        ];
        final destinations = ['Destination 1', 'Destination 2'];
        const type = NavigationTypeEnum.railAndBottomNavBar;

        final settings = TestNavigationSettings(
          pages: pages,
          destinations: destinations,
          type: type,
        );

        expect(settings.pages, equals(pages));
        expect(settings.destinations, equals(destinations));
        expect(settings.type, equals(type));
      });

      test('should create instance with empty lists', () {
        final pages = <Widget>[];
        final destinations = <String>[];
        const type = NavigationTypeEnum.drawer;

        final settings = TestNavigationSettings(
          pages: pages,
          destinations: destinations,
          type: type,
        );

        expect(settings.pages, isEmpty);
        expect(settings.destinations, isEmpty);
        expect(settings.type, equals(type));
      });

      test('should create instance with different navigation types', () {
        final pages = [const Text('Page')];
        final destinations = ['Destination'];

        final railSettings = TestNavigationSettings(
          pages: pages,
          destinations: destinations,
          type: NavigationTypeEnum.railAndBottomNavBar,
        );

        final drawerSettings = TestNavigationSettings(
          pages: pages,
          destinations: destinations,
          type: NavigationTypeEnum.drawer,
        );

        final modalDrawerSettings = TestNavigationSettings(
          pages: pages,
          destinations: destinations,
          type: NavigationTypeEnum.modalDrawer,
        );

        expect(railSettings.type, equals(NavigationTypeEnum.railAndBottomNavBar));
        expect(drawerSettings.type, equals(NavigationTypeEnum.drawer));
        expect(modalDrawerSettings.type, equals(NavigationTypeEnum.modalDrawer));
      });
    });

    group('Properties', () {
      test('should maintain immutable properties', () {
        final pages = [
          const Text('Page 1'),
          const Text('Page 2'),
        ];
        final destinations = ['Destination 1', 'Destination 2'];
        const type = NavigationTypeEnum.railAndBottomNavBar;

        final settings = TestNavigationSettings(
          pages: pages,
          destinations: destinations,
          type: type,
        );

        // Verify that the properties are the same references
        expect(identical(settings.pages, pages), isTrue);
        expect(identical(settings.destinations, destinations), isTrue);
        expect(settings.type, equals(type));
      });

      test('should handle different widget types in pages', () {
        final pages = [
          const Text('Text Widget'),
          const Icon(Icons.home),
          Container(color: Colors.red),
          const SizedBox(width: 100, height: 100),
        ];
        final destinations = ['Dest1', 'Dest2', 'Dest3', 'Dest4'];
        const type = NavigationTypeEnum.modalDrawer;

        final settings = TestNavigationSettings(
          pages: pages,
          destinations: destinations,
          type: type,
        );

        expect(settings.pages.length, equals(4));
        expect(settings.pages[0], isA<Text>());
        expect(settings.pages[1], isA<Icon>());
        expect(settings.pages[2], isA<Container>());
        expect(settings.pages[3], isA<SizedBox>());
      });

      test('should handle different destination types', () {
        final pages = [const Text('Page')];
        final intDestinations = [1, 2, 3];
        const type = NavigationTypeEnum.drawer;

        final intSettings = NavigationSettings<int>(
          pages: pages,
          destinations: intDestinations,
          type: type,
        );

        expect(intSettings.destinations, equals([1, 2, 3]));
        expect(intSettings.destinations, isA<List<int>>());
      });
    });

    group('Generic Type Handling', () {
      test('should work with different generic types', () {
        final pages = [const Text('Page')];
        const type = NavigationTypeEnum.railAndBottomNavBar;

        // Test with String
        final stringSettings = NavigationSettings<String>(
          pages: pages,
          destinations: ['String Destination'],
          type: type,
        );

        // Test with int
        final intSettings = NavigationSettings<int>(
          pages: pages,
          destinations: [42],
          type: type,
        );

        // Test with Widget
        final widgetSettings = NavigationSettings<Widget>(
          pages: pages,
          destinations: [const Icon(Icons.home)],
          type: type,
        );

        expect(stringSettings.destinations.first, isA<String>());
        expect(intSettings.destinations.first, isA<int>());
        expect(widgetSettings.destinations.first, isA<Widget>());
      });
    });

    group('Edge Cases', () {
      test('should handle large number of pages and destinations', () {
        final pages = List.generate(100, (index) => Text('Page $index'));
        final destinations = List.generate(100, (index) => 'Destination $index');
        const type = NavigationTypeEnum.drawer;

        final settings = TestNavigationSettings(
          pages: pages,
          destinations: destinations,
          type: type,
        );

        expect(settings.pages.length, equals(100));
        expect(settings.destinations.length, equals(100));
        expect((settings.pages.first as Text).data, equals('Page 0'));
        expect((settings.pages.last as Text).data, equals('Page 99'));
        expect(settings.destinations.first, equals('Destination 0'));
        expect(settings.destinations.last, equals('Destination 99'));
      });

      test('should handle mismatched pages and destinations lengths', () {
        final pages = [const Text('Page 1')];
        final destinations = ['Dest 1', 'Dest 2', 'Dest 3'];
        const type = NavigationTypeEnum.modalDrawer;

        final settings = TestNavigationSettings(
          pages: pages,
          destinations: destinations,
          type: type,
        );

        expect(settings.pages.length, equals(1));
        expect(settings.destinations.length, equals(3));
      });
    });
  });
}