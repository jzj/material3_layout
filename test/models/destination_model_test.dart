import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material3_layout/src/models/destination_model.dart';

void main() {
  group('DestinationModel', () {
    group('Constructor', () {
      test('should create instance with required label', () {
        const label = 'Home';
        final destination = DestinationModel(label: label);
        
        expect(destination.label, equals(label));
        expect(destination.icon, isNull);
        expect(destination.selectedIcon, isNull);
        expect(destination.tooltip, isNull);
        expect(destination.badge, isNull);
      });

      test('should create instance with all parameters', () {
        const label = 'Home';
        const icon = Icon(Icons.home);
        const selectedIcon = Icon(Icons.home_filled);
        const tooltip = 'Home page';
        
        final destination = DestinationModel(
          label: label,
          icon: icon,
          selectedIcon: selectedIcon,
          tooltip: tooltip,
        );
        
        expect(destination.label, equals(label));
        expect(destination.icon, equals(icon));
        expect(destination.selectedIcon, equals(selectedIcon));
        expect(destination.tooltip, equals(tooltip));
        expect(destination.badge, isNull);
      });

      test('should create instance with badge', () {
        const label = 'Messages';
        const badge = Badge(label: Text('5'));
        
        final destination = DestinationModel(
          label: label,
          badge: badge,
        );
        
        expect(destination.label, equals(label));
        expect(destination.badge, equals(badge));
        expect(destination.icon, isNull);
        expect(destination.selectedIcon, isNull);
      });

      test('should throw assertion error when both icon and badge are provided', () {
        expect(
          () => DestinationModel(
            label: 'Test',
            icon: const Icon(Icons.home),
            badge: const Badge(label: Text('1')),
          ),
          throwsA(isA<AssertionError>()),
        );
      });
    });

    group('toNavigationRailDestination', () {
      test('should convert to NavigationRailDestination with icon', () {
        const label = 'Home';
        const icon = Icon(Icons.home);
        const selectedIcon = Icon(Icons.home_filled);
        const padding = EdgeInsets.all(8.0);
        
        final destination = DestinationModel(
          label: label,
          icon: icon,
          selectedIcon: selectedIcon,
        );
        
        final railDestination = destination.toNavigationRailDestination(padding);
        
        expect(railDestination.icon, equals(icon));
        expect(railDestination.selectedIcon, equals(selectedIcon));
        expect(railDestination.padding, equals(padding));
        expect((railDestination.label as Text).data, equals(label));
      });

      test('should convert to NavigationRailDestination with badge', () {
        const label = 'Messages';
        const badge = Badge(label: Text('5'));
        const padding = EdgeInsets.all(8.0);
        
        final destination = DestinationModel(
          label: label,
          badge: badge,
        );
        
        final railDestination = destination.toNavigationRailDestination(padding);
        
        expect(railDestination.icon, equals(badge));
        expect(railDestination.selectedIcon, equals(badge));
        expect(railDestination.padding, equals(padding));
        expect((railDestination.label as Text).data, equals(label));
      });

      test('should convert to NavigationRailDestination without padding', () {
        const label = 'Home';
        const icon = Icon(Icons.home);
        
        final destination = DestinationModel(
          label: label,
          icon: icon,
        );
        
        final railDestination = destination.toNavigationRailDestination(null);
        
        expect(railDestination.icon, equals(icon));
        expect(railDestination.padding, isNull);
        expect((railDestination.label as Text).data, equals(label));
      });
    });

    group('toNavigationDestination', () {
      test('should convert to NavigationDestination with icon', () {
        const label = 'Home';
        const icon = Icon(Icons.home);
        const selectedIcon = Icon(Icons.home_filled);
        const tooltip = 'Home page';
        
        final destination = DestinationModel(
          label: label,
          icon: icon,
          selectedIcon: selectedIcon,
          tooltip: tooltip,
        );
        
        final navDestination = destination.toNavigationDestination();
        
        expect(navDestination.icon, equals(icon));
        expect(navDestination.selectedIcon, equals(selectedIcon));
        expect(navDestination.label, equals(label));
        expect(navDestination.tooltip, equals(tooltip));
      });

      test('should convert to NavigationDestination with badge', () {
        const label = 'Messages';
        const badge = Badge(label: Text('5'));
        
        final destination = DestinationModel(
          label: label,
          badge: badge,
        );
        
        final navDestination = destination.toNavigationDestination();
        
        expect(navDestination.icon, equals(badge));
        expect(navDestination.selectedIcon, equals(badge));
        expect(navDestination.label, equals(label));
      });

      test('should convert to NavigationDestination without optional parameters', () {
        const label = 'Home';
        const icon = Icon(Icons.home);
        
        final destination = DestinationModel(
          label: label,
          icon: icon,
        );
        
        final navDestination = destination.toNavigationDestination();
        
        expect(navDestination.icon, equals(icon));
        expect(navDestination.selectedIcon, isNull);
        expect(navDestination.label, equals(label));
        expect(navDestination.tooltip, isNull);
      });
    });

    group('Edge Cases', () {
      test('should handle empty label', () {
        final destination = DestinationModel(label: '');
        expect(destination.label, equals(''));
      });

      test('should handle very long label', () {
        const longLabel = 'This is a very long label that might be used in some edge cases';
        final destination = DestinationModel(label: longLabel);
        expect(destination.label, equals(longLabel));
      });
    });
  });
}