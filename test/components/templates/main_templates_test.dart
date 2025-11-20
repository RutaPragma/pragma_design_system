import 'ds_auth_template_test.dart' as auth_template;
import 'ds_cart_template_test.dart' as cart_template;
import 'ds_checkout_template_test.dart' as checkout_template;
import 'ds_home_template_test.dart' as home_template;
import 'ds_profile_template_test.dart' as profile_template;
import 'ds_product_detail_page_test.dart' as product_detail;

/// Punto de entrada de pruebas para la capa de templates.
void main() {
  auth_template.main();
  cart_template.main();
  checkout_template.main();
  home_template.main();
  profile_template.main();
  product_detail.main();
}
