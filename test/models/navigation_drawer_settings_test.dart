import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material3_layout/src/models/navigation_drawer_settings.dart';
import 'package:material3_layout/src/models/navigation_type_enum.dart';

void main() {
  group('DrawerSettings', () {
    group('Constructor', () {
      test('should create instance with valid NavigationDrawerDestination list', () {
        final pages = [
          const Text('Page 1'),
          const Text('Page 2'),
        ];
        final destinations = [
          const NavigationDrawerDestination(
            icon: Icon(Icons.home),
            label: Text('Home'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.settings),
            label: Text('Settings'),
          ),
        ];
        const type = NavigationTypeEnum.drawer;

        final settings = DrawerSettings(
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
        final destinations = <NavigationDrawerDestination>[];
        const type = NavigationTypeEnum.modalDrawer;

        final settings = DrawerSettings(
          pages: pages,
          destinations: destinations,
          type: type,
        );

        expect(settings.pages, isEmpty);
        expect(settings.destinations, isEmpty);
        expect(settings.type, equals(type));
      });

      test('should create instance with single destination and page', () {
        final pages = [const Text('Single Page')];
        final destinations = [
          const NavigationDrawerDestination(
            icon: Icon(Icons.home),
            label: Text('Home'),
          ),
        ];
        const type = NavigationTypeEnum.drawer;

        final settings = DrawerSettings(
          pages: pages,
          destinations: destinations,
          type: type,
        );

        expect(settings.pages.length, equals(1));
        expect(settings.destinations.length, equals(1));
        expect(settings.type, equals(type));
      });

      test('should work with different NavigationTypeEnum values', () {
        final pages = [const Text('Page')];
        final destinations = [
          const NavigationDrawerDestination(
            icon: Icon(Icons.home),
            label: Text('Home'),
          ),
        ];

        final drawerSettings = DrawerSettings(
          pages: pages,
          destinations: destinations,
          type: NavigationTypeEnum.drawer,
        );

        final modalDrawerSettings = DrawerSettings(
          pages: pages,
          destinations: destinations,
          type: NavigationTypeEnum.modalDrawer,
        );

        expect(drawerSettings.type, equals(NavigationTypeEnum.drawer));
        expect(modalDrawerSettings.type, equals(NavigationTypeEnum.modalDrawer));
      });
    });

    group('Assertion Tests', () {
      test('should throw assertion error when destinations and pages length mismatch', () {
        final pages = [
          const Text('Page 1'),
          const Text('Page 2'),
        ];
        final destinations = [
          const NavigationDrawerDestination(
            icon: Icon(Icons.home),
            label: Text('Home'),
          ),
        ];
        const type = NavigationTypeEnum.drawer;

        expect(
          () => DrawerSettings(
            pages: pages,
            destinations: destinations,
            type: type,
          ),
          throwsA(isA<AssertionError>()),
        );
      });

      test('should throw assertion error when destinations contain non-NavigationDrawerDestination widgets', () {
        final pages = [const Text('Page 1')];
        final destinations = [
          const Text('Not a NavigationDrawerDestination'), // This should cause assertion error
        ];
        const type = NavigationTypeEnum.drawer;

        expect(
          () => DrawerSettings(
            pages: pages,
            destinations: destinations,
            type: type,
          ),
          throwsA(isA<AssertionError>()),
        );
      });

      test('should handle mixed widget types in destinations list', () {
        final pages = [const Text('Page 1')];
        final destinations = [
          const NavigationDrawerDestination(
            icon: Icon(Icons.home),
            label: Text('Home'),
          ),
          const Icon(Icons.settings), // Non-NavigationDrawerDestination widget
        ];
        const type = NavigationTypeEnum.drawer;

        expect(
          () => DrawerSettings(
            pages: pages,
            destinations: destinations,
            type: type,
          ),
          throwsA(isA<AssertionError>()),
        );
      });
    });

    group('NavigationDrawerDestination Properties', () {
      test('should preserve NavigationDrawerDestination properties', () {
        final pages = [const Text('Page')];
        const destination = NavigationDrawerDestination(
          icon: Icon(Icons.home),
          label: Text('Home'),
          selectedIcon: Icon(Icons.home_filled),
          backgroundColor: Colors.blue,
        );
        final destinations = [destination];
        const type = NavigationTypeEnum.drawer;

        final settings = DrawerSettings(
          pages: pages,
          destinations: destinations,
          type: type,
        );

        final retrievedDestination = settings.destinations.first;
        expect(retrievedDestination.icon, isA<Icon>());
        expect(retrievedDestination.label, isA<Text>());
        expect(retrievedDestination.selectedIcon, isA<Icon>());
        expect(retrievedDestination.backgroundColor, equals(Colors.blue));
      });

      test('should handle NavigationDrawerDestination with minimal properties', () {
        final pages = [const Text('Page')];
        const destination = NavigationDrawerDestination(
          icon: Icon(Icons.home),
          label: Text('Home'),
        );
        final destinations = [destination];
        const type = NavigationTypeEnum.modalDrawer;

        final settings = DrawerSettings(
          pages: pages,
          destinations: destinations,
          type: type,
        );

        final retrievedDestination = settings.destinations.first;
        expect(retrievedDestination.icon, isA<Icon>());
        expect(retrievedDestination.label, isA<Text>());
        expect(retrievedDestination.selectedIcon, isNull);
        expect(retrievedDestination.backgroundColor, isNull);
      });
    });

    group('Inheritance', () {
      test('should inherit from NavigationSettings', () {
        final pages = [const Text('Page')];
        final destinations = [
          const NavigationDrawerDestination(
            icon: Icon(Icons.home),
            label: Text('Home'),
          ),
        ];
        const type = NavigationTypeEnum.drawer;

        final settings = DrawerSettings(
          pages: pages,
          destinations: destinations,
          type: type,
        );

        expect(settings, isA<DrawerSettings>());
        expect(settings.pages, isA<List<Widget>>());
        expect(settings.destinations, isA<List<Widget>>());
        expect(settings.type, isA<NavigationTypeEnum>());
      });
    });

    group('Edge Cases', () {
      test('should handle large number of destinations and pages', () {
        final pages = List.generate(50, (index) => Text('Page $index'));
        final destinations = List.generate(
          50,
          (index) => NavigationDrawerDestination(
            icon: Icon(Icons.home),
            label: Text('Destination $index'),
          ),
        );
        const type = NavigationTypeEnum.drawer;

        final settings = DrawerSettings(
          pages: pages,
          destinations: destinations,
          type: type,
        );

        expect(settings.pages.length, equals(50));
        expect(settings.destinations.length, equals(50));
        expect((settings.pages.first as Text).data, equals('Page 0'));
        expect((settings.pages.last as Text).data, equals('Page 49'));
      });

      test('should handle destinations with complex widgets', () {
        final pages = [const Text('Page')];
        final destinations = [
          NavigationDrawerDestination(
            icon: Container(
              width: 24,
              height: 24,
              color: Colors.red,
              child: const Icon(Icons.home),
            ),
            label: const Row(
              children: [
                Icon(Icons.star),
                Text('Complex Label'),
              ],
            ),
            selectedIcon: const Badge(
              label: Text('New'),
              child: Icon(Icons.home_filled),
            ),
          ),
        ];
        const type = NavigationTypeEnum.modalDrawer;

        final settings = DrawerSettings(
          pages: pages,
          destinations: destinations,
          type: type,
        );

        expect(settings.destinations.length, equals(1));
        final destination = settings.destinations.first;
        expect(destination.icon, isA<Container>());
        expect(destination.label, isA<Row>());
        expect(destination.selectedIcon, isA<Badge>());
      });
    });
  });
}