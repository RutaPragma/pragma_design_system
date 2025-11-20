import 'ds_badge_test.dart' as badge;
import 'ds_button_test.dart' as button;
import 'ds_fab_button_test.dart' as fab_button;
import 'ds_icon_button_test.dart' as icon_button;
import 'icons/ds_icon_data_test.dart' as icon_data;
import 'ds_icon_test.dart' as icon;
import 'ds_input_field_test.dart' as input_field;
import 'ds_loader_test.dart' as loader;
import 'ds_rating_stars_test.dart' as rating_stars;
import 'ds_separeted_test.dart' as separated;
import 'ds_toggle_test.dart' as toggle;

/// Agrupa los tests pertenecientes a los átomos del sistema de diseño.
void main() {
  badge.main();
  button.main();
  fab_button.main();
  icon_button.main();
  icon_data.main();
  icon.main();
  input_field.main();
  loader.main();
  rating_stars.main();
  separated.main();
  toggle.main();
}
