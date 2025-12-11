import 'package:flutter_test/flutter_test.dart';

import 'models/destination_model_test.dart' as destination_model_test;
import 'models/navigation_drawer_settings_test.dart' as navigation_drawer_settings_test;
import 'models/navigation_settings_test.dart' as navigation_settings_test;
import 'models/navigation_type_enum_test.dart' as navigation_type_enum_test;
import 'models/rail_and_bottom_navigation_settings_test.dart' as rail_and_bottom_navigation_settings_test;

void main() {
  group('Models Tests', () {
    destination_model_test.main();
    navigation_drawer_settings_test.main();
    navigation_settings_test.main();
    navigation_type_enum_test.main();
    rail_and_bottom_navigation_settings_test.main();
  });
}