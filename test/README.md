# Unit Tests for Material3 Layout Models

This directory contains comprehensive unit tests for all model classes in the `lib/src/models/` folder.

## Test Files

### 1. `models/destination_model_test.dart`
Tests for the `DestinationModel` class:
- Constructor validation with required and optional parameters
- Assertion error handling for invalid combinations (icon + badge)
- Conversion methods: `toNavigationRailDestination()` and `toNavigationDestination()`
- Edge cases with empty labels and complex widgets

### 2. `models/navigation_settings_test.dart`
Tests for the abstract `NavigationSettings` class:
- Constructor with generic type parameters
- Property immutability and type safety
- Generic type handling with different destination types
- Edge cases with large datasets and mismatched lengths

### 3. `models/navigation_drawer_settings_test.dart`
Tests for the `DrawerSettings` class:
- Constructor with `NavigationDrawerDestination` widgets
- Assertion validation for matching pages and destinations lengths
- Type checking for proper destination widget types
- Complex widget property preservation

### 4. `models/rail_and_bottom_navigation_settings_test.dart`
Tests for the `RailAndBottomSettings` class:
- Constructor with all optional parameters
- Multiple assertion validations:
  - Pages/destinations length matching
  - Mutual exclusivity of `showMenuIcon` and `leading`
  - Label type compatibility with `showMenuIcon`
  - Trailing widget conflicts with theme switcher
  - Group alignment restrictions with theme switcher
- Group alignment and label type variations
- Complex widget configurations

### 5. `models/navigation_type_enum_test.dart`
Tests for the `NavigationTypeEnum`:
- Enum value validation and naming
- Comparison and equality operations
- String representation and iteration
- Collection operations (Lists, Sets, Maps)
- Functional operations (where, map, firstWhere)
- Type safety and null handling
- Documentation compliance verification

## Running Tests

To run all model tests:

```bash
flutter test test/models_test.dart
```

To run individual test files:

```bash
flutter test test/models/destination_model_test.dart
flutter test test/models/navigation_settings_test.dart
flutter test test/models/navigation_drawer_settings_test.dart
flutter test test/models/rail_and_bottom_navigation_settings_test.dart
flutter test test/models/navigation_type_enum_test.dart
```

## Test Coverage

The tests provide comprehensive coverage including:
- ✅ Constructor validation
- ✅ Property access and immutability
- ✅ Method functionality
- ✅ Assertion error handling
- ✅ Edge cases and boundary conditions
- ✅ Type safety and generic handling
- ✅ Complex widget interactions
- ✅ Documentation compliance

## Test Structure

Each test file follows a consistent structure:
- **Constructor tests**: Validate object creation with various parameter combinations
- **Assertion tests**: Verify proper error handling for invalid inputs
- **Method tests**: Test public method functionality and return values
- **Property tests**: Ensure correct property access and immutability
- **Edge cases**: Handle boundary conditions and unusual inputs
- **Type safety**: Verify generic type handling and type constraints

All tests use descriptive names and are organized into logical groups for easy maintenance and understanding.