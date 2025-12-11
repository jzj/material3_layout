import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material3_layout/src/models/destination_model.dart';
import 'package:material3_layout/src/models/rail_and_bottom_navigation_settings.dart';
import 'package:material3_layout/src/models/navigation_type_enum.dart';

void main() {
  group('RailAndBottomSettings', () {
    group('Constructor', () {
      test('should create instance with required parameters', () {
        final pages = [const Text('Page 1'), const Text('Page 2')];
        final destinations = [
          DestinationModel(label: 'Home', icon: const Icon(Icons.home)),
          DestinationModel(label: 'Settings', icon: const Icon(Icons.settings)),
        ];

        final settings = RailAndBottomSettings(
          pages: pages,
          destinations: destinations,
        );

        expect(settings.pages, equals(pages));
        expect(settings.destinations, equals(destinations));
        expect(settings.type, equals(NavigationTypeEnum.railAndBottomNavBar));
        expect(settings.leading, isNull);
        expect(settings.trailing, isNull);
        expect(settings.showMenuIcon, isFalse);
        expect(settings.groupAlignment, equals(0.0));
        expect(settings.addThemeSwitcherTrailingIcon, isFalse);
        expect(settings.labelType, isNull);
      });

      test('should create instance with all optional parameters', () {
        final pages = [const Text('Page')];
        final destinations = [
          DestinationModel(label: 'Home', icon: const Icon(Icons.home)),
        ];
        const leading = Icon(Icons.menu);
        const trailing = Icon(Icons.more_vert);
        const labelType = NavigationRailLabelType.all;

        final settings = RailAndBottomSettings(
          pages: pages,
          destinations: destinations,
          leading: leading,
          trailing: trailing,
          showMenuIcon: false,
          groupAlignment: -1.0,
          addThemeSwitcherTrailingIcon: false,
          labelType: labelType,
        );

        expect(settings.leading, equals(leading));
        expect(settings.trailing, equals(trailing));
        expect(settings.showMenuIcon, isFalse);
        expect(settings.groupAlignment, equals(-1.0));
        expect(settings.addThemeSwitcherTrailingIcon, isFalse);
        expect(settings.labelType, equals(labelType));
      });

      test('should create instance with showMenuIcon enabled', () {
        final pages = [const Text('Page')];
        final destinations = [
          DestinationModel(label: 'Home', icon: const Icon(Icons.home)),
        ];

        final settings = RailAndBottomSettings(
          pages: pages,
          destinations: destinations,
          showMenuIcon: true,
        );

        expect(settings.showMenuIcon, isTrue);
        expect(settings.leading, isNull);
      });

      test('should create instance with theme switcher trailing icon', () {
        final pages = [const Text('Page')];
        final destinations = [
          DestinationModel(label: 'Home', icon: const Icon(Icons.home)),
        ];

        final settings = RailAndBottomSettings(
          pages: pages,
          destinations: destinations,
          addThemeSwitcherTrailingIcon: true,
          groupAlignment: -1.0,
        );

        expect(settings.addThemeSwitcherTrailingIcon, isTrue);
        expect(settings.trailing, isNull);
        expect(settings.groupAlignment, equals(-1.0));
      });
    });

    group('Assertion Tests', () {
      test('should throw assertion error when destinations and pages length mismatch', () {
        final pages = [const Text('Page 1'), const Text('Page 2')];
        final destinations = [
          DestinationModel(label: 'Home', icon: const Icon(Icons.home)),
        ];

        expect(
          () => RailAndBottomSettings(
            pages: pages,
            destinations: destinations,
          ),
          throwsA(isA<AssertionError>()),
        );
      });

      test('should throw assertion error when both showMenuIcon and leading are provided', () {
        final pages = [const Text('Page')];
        final destinations = [
          DestinationModel(label: 'Home', icon: const Icon(Icons.home)),
        ];

        expect(
          () => RailAndBottomSettings(
            pages: pages,
            destinations: destinations,
            showMenuIcon: true,
            leading: const Icon(Icons.menu),
          ),
          throwsA(isA<AssertionError>()),
        );
      });

      test('should throw assertion error when showMenuIcon is true with incompatible labelType', () {
        final pages = [const Text('Page')];
        final destinations = [
          DestinationModel(label: 'Home', icon: const Icon(Icons.home)),
        ];

        expect(
          () => RailAndBottomSettings(
            pages: pages,
            destinations: destinations,
            showMenuIcon: true,
            labelType: NavigationRailLabelType.all,
          ),
          throwsA(isA<AssertionError>()),
        );

        expect(
          () => RailAndBottomSettings(
            pages: pages,
            destinations: destinations,
            showMenuIcon: true,
            labelType: NavigationRailLabelType.selected,
          ),
          throwsA(isA<AssertionError>()),
        );
      });

      test('should allow showMenuIcon with NavigationRailLabelType.none', () {
        final pages = [const Text('Page')];
        final destinations = [
          DestinationModel(label: 'Home', icon: const Icon(Icons.home)),
        ];

        expect(
          () => RailAndBottomSettings(
            pages: pages,
            destinations: destinations,
            showMenuIcon: true,
            labelType: NavigationRailLabelType.none,
          ),
          returnsNormally,
        );
      });

      test('should throw assertion error when both trailing and addThemeSwitcherTrailingIcon are provided', () {
        final pages = [const Text('Page')];
        final destinations = [
          DestinationModel(label: 'Home', icon: const Icon(Icons.home)),
        ];

        expect(
          () => RailAndBottomSettings(
            pages: pages,
            destinations: destinations,
            trailing: const Icon(Icons.more_vert),
            addThemeSwitcherTrailingIcon: true,
          ),
          throwsA(isA<AssertionError>()),
        );
      });

      test('should throw assertion error when addThemeSwitcherTrailingIcon is true with bottom group alignment', () {
        final pages = [const Text('Page')];
        final destinations = [
          DestinationModel(label: 'Home', icon: const Icon(Icons.home)),
        ];

        expect(
          () => RailAndBottomSettings(
            pages: pages,
            destinations: destinations,
            addThemeSwitcherTrailingIcon: true,
            groupAlignment: 1.0,
          ),
          throwsA(isA<AssertionError>()),
        );
      });
    });

    group('Group Alignment', () {
      test('should accept valid group alignment values', () {
        final pages = [const Text('Page')];
        final destinations = [
          DestinationModel(label: 'Home', icon: const Icon(Icons.home)),
        ];

        final topAlignment = RailAndBottomSettings(
          pages: pages,
          destinations: destinations,
          groupAlignment: -1.0,
        );

        final centerAlignment = RailAndBottomSettings(
          pages: pages,
          destinations: destinations,
          groupAlignment: 0.0,
        );

        final bottomAlignment = RailAndBottomSettings(
          pages: pages,
          destinations: destinations,
          groupAlignment: 1.0,
        );

        expect(topAlignment.groupAlignment, equals(-1.0));
        expect(centerAlignment.groupAlignment, equals(0.0));
        expect(bottomAlignment.groupAlignment, equals(1.0));
      });

      test('should accept fractional group alignment values', () {
        final pages = [const Text('Page')];
        final destinations = [
          DestinationModel(label: 'Home', icon: const Icon(Icons.home)),
        ];

        final settings = RailAndBottomSettings(
          pages: pages,
          destinations: destinations,
          groupAlignment: 0.5,
        );

        expect(settings.groupAlignment, equals(0.5));
      });
    });

    group('Label Types', () {
      test('should work with all NavigationRailLabelType values', () {
        final pages = [const Text('Page')];
        final destinations = [
          DestinationModel(label: 'Home', icon: const Icon(Icons.home)),
        ];

        final noneSettings = RailAndBottomSettings(
          pages: pages,
          destinations: destinations,
          labelType: NavigationRailLabelType.none,
        );

        final selectedSettings = RailAndBottomSettings(
          pages: pages,
          destinations: destinations,
          labelType: NavigationRailLabelType.selected,
        );

        final allSettings = RailAndBottomSettings(
          pages: pages,
          destinations: destinations,
          labelType: NavigationRailLabelType.all,
        );

        expect(noneSettings.labelType, equals(NavigationRailLabelType.none));
        expect(selectedSettings.labelType, equals(NavigationRailLabelType.selected));
        expect(allSettings.labelType, equals(NavigationRailLabelType.all));
      });
    });

    group('Inheritance', () {
      test('should inherit from NavigationSettings', () {
        final pages = [const Text('Page')];
        final destinations = [
          DestinationModel(label: 'Home', icon: const Icon(Icons.home)),
        ];

        final settings = RailAndBottomSettings(
          pages: pages,
          destinations: destinations,
        );

        expect(settings.pages, isA<List<Widget>>());
        expect(settings.destinations, isA<List<DestinationModel>>());
        expect(settings.type, isA<NavigationTypeEnum>());
      });
    });

    group('Edge Cases', () {
      test('should handle empty destinations and pages', () {
        final pages = <Widget>[];
        final destinations = <DestinationModel>[];

        final settings = RailAndBottomSettings(
          pages: pages,
          destinations: destinations,
        );

        expect(settings.pages, isEmpty);
        expect(settings.destinations, isEmpty);
      });

      test('should handle large number of destinations', () {
        final pages = List.generate(20, (index) => Text('Page $index'));
        final destinations = List.generate(
          20,
          (index) => DestinationModel(
            label: 'Destination $index',
            icon: Icon(Icons.home),
          ),
        );

        final settings = RailAndBottomSettings(
          pages: pages,
          destinations: destinations,
        );

        expect(settings.pages.length, equals(20));
        expect(settings.destinations.length, equals(20));
      });

      test('should handle destinations with badges', () {
        final pages = [const Text('Page')];
        final destinations = [
          DestinationModel(
            label: 'Messages',
            badge: const Badge(label: Text('5')),
          ),
        ];

        final settings = RailAndBottomSettings(
          pages: pages,
          destinations: destinations,
        );

        expect(settings.destinations.first.badge, isNotNull);
        expect(settings.destinations.first.icon, isNull);
      });

      test('should handle complex widget configurations', () {
        final pages = [const Text('Page')];
        final destinations = [
          DestinationModel(
            label: 'Home',
            icon: const Icon(Icons.home),
            selectedIcon: const Icon(Icons.home_filled),
            tooltip: 'Home page',
          ),
        ];

        final settings = RailAndBottomSettings(
          pages: pages,
          destinations: destinations,
          leading: Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(Icons.menu),
          ),
          trailing: Column(
            children: [
              const Icon(Icons.settings),
              const Icon(Icons.help),
            ],
          ),
          groupAlignment: -0.5,
          labelType: NavigationRailLabelType.selected,
        );

        expect(settings.leading, isA<Container>());
        expect(settings.trailing, isA<Column>());
        expect(settings.groupAlignment, equals(-0.5));
        expect(settings.destinations.first.tooltip, equals('Home page'));
      });
    });

    group('Valid Combinations', () {
      test('should allow showMenuIcon with null labelType', () {
        final pages = [const Text('Page')];
        final destinations = [
          DestinationModel(label: 'Home', icon: const Icon(Icons.home)),
        ];

        expect(
          () => RailAndBottomSettings(
            pages: pages,
            destinations: destinations,
            showMenuIcon: true,
            labelType: null,
          ),
          returnsNormally,
        );
      });

      test('should allow addThemeSwitcherTrailingIcon with zero or negative groupAlignment', () {
        final pages = [const Text('Page')];
        final destinations = [
          DestinationModel(label: 'Home', icon: const Icon(Icons.home)),
        ];

        expect(
          () => RailAndBottomSettings(
            pages: pages,
            destinations: destinations,
            addThemeSwitcherTrailingIcon: true,
            groupAlignment: 0.0,
          ),
          returnsNormally,
        );

        expect(
          () => RailAndBottomSettings(
            pages: pages,
            destinations: destinations,
            addThemeSwitcherTrailingIcon: true,
            groupAlignment: -0.5,
          ),
          returnsNormally,
        );
      });
    });
  });
}