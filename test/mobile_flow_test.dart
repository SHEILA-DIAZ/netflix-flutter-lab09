import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:streamhub/main.dart';

void main() {
  testWidgets('Recorrido móvil de Netflix sin errores de layout', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const StreamHubApp());
    Future<void> checkScreen(String step) async {
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: step);
    }

    await checkScreen('01-inicio-netflix');
    for (final section in {
      'Tendencias': '02-tendencias',
      'Películas': '03-peliculas',
      'Series': '04-series',
      'Recomendadas': '05-recomendadas-lista-vertical',
    }.entries) {
      await tester.scrollUntilVisible(
        find.text(section.key),
        250,
        scrollable: find.byType(Scrollable).first,
      );
      await checkScreen(section.value);
      if (section.key == 'Tendencias') {
        final horizontal = find.byWidgetPredicate(
          (w) => w is Scrollable && w.axisDirection == AxisDirection.right,
        );
        await tester.drag(horizontal.first, const Offset(-250, 0));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      }
    }
    await tester.scrollUntilVisible(
      find.text('Explorar historia'),
      -300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Explorar historia'));
    await checkScreen('06-detalles');
    final toggle = find.byKey(const ValueKey('toggle-favorite'));
    await tester.scrollUntilVisible(
      toggle,
      250,
      scrollable: find.byType(Scrollable).first,
    );
    await checkScreen('07-detalles-agregar-favorito');
    await tester.tap(toggle);
    await checkScreen('08-detalles-favorito-agregado');
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mi lista'));
    await checkScreen('09-mi-lista');
    await tester.tap(find.byTooltip('Quitar de mi lista'));
    await checkScreen('10-mi-lista-vacia');
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Buscar').first);
    await checkScreen('11-busqueda-catalogo');
    final field = find.byKey(const ValueKey('search-field'));
    await tester.enterText(field, 'orbita');
    await checkScreen('12-busqueda-resultado');
    expect(find.text('Órbita'), findsOneWidget);
    await tester.enterText(field, 'zzzzzz');
    await checkScreen('13-busqueda-sin-resultados');
  });
}
