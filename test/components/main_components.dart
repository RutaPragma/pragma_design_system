import 'atoms/main_atoms_test.dart' as atoms;
import 'molecules/main_molecules_test.dart' as molecules;
import 'organisms/main_organisms_test.dart' as organisms;
import 'pages/main_pages_test.dart' as pages;
import 'templates/main_templates_test.dart' as templates;

/// Centraliza la ejecución de pruebas para todas las capas de componentes.
void main() {
  atoms.main();
  molecules.main();
  organisms.main();
  templates.main();
  pages.main();
}
