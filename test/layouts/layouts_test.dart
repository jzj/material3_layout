/// Comprehensive test suite for all layout classes in the material3_layout package.
/// 
/// This file imports and runs all layout-related tests to ensure complete coverage
/// of the layouts folder functionality.

import 'package:flutter_test/flutter_test.dart';

// Import all layout test files
import 'enum/fixed_pane_position_enum_test.dart' as fixed_pane_position_enum_tests;
import 'enum/layouts_enum_test.dart' as layouts_enum_tests;
import 'layout_test.dart' as layout_tests;
import 'layout_utils_test.dart' as layout_utils_tests;
import 'page_layout_test.dart' as page_layout_tests;
import 'single_pane_layout_test.dart' as single_pane_layout_tests;
import 'split_pane_layout_test.dart' as split_pane_layout_tests;
import 'two_pane_layout_test.dart' as two_pane_layout_tests;

void main() {
  group('Material3 Layout - Layouts Package Tests', () {
    group('Enum Tests', () {
      fixed_pane_position_enum_tests.main();
      layouts_enum_tests.main();
    });

    group('Core Layout Tests', () {
      layout_tests.main();
      layout_utils_tests.main();
    });

    group('Layout Implementation Tests', () {
      page_layout_tests.main();
      single_pane_layout_tests.main();
      split_pane_layout_tests.main();
      two_pane_layout_tests.main();
    });
  });
}