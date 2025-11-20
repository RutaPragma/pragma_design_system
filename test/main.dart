import 'components/main_components.dart' as components;
import 'helpers/helpers_test.dart' as helpers;

/// Punto de entrada general de la suite; encadena los tests de todas las capas.
void main() {
  helpers.main();
  components.main();
}
