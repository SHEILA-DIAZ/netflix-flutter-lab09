import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:streamhub/main.dart';
import 'package:streamhub/screens/details_screen.dart';
import 'package:streamhub/widgets/catalog_widgets.dart';

void main() {
  testWidgets('El catálogo Netflix abre detalles y permite regresar', (
    tester,
  ) async {
    await tester.pumpWidget(const StreamHubApp());
    expect(find.text('NETFLIX'), findsOneWidget);
    await tester.tap(find.text('Explorar historia'));
    await tester.pumpAndSettle();
    expect(find.byType(DetailsScreen), findsOneWidget);
    expect(find.text('Órbita'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('NETFLIX'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Tendencias'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    expect(find.byType(MovieCard), findsWidgets);
  });
  testWidgets('Agregar, consultar y quitar favoritos actualiza la interfaz', (
    tester,
  ) async {
    await tester.pumpWidget(const StreamHubApp());
    await tester.tap(find.text('Explorar historia'));
    await tester.pumpAndSettle();
    final toggle = find.byKey(const ValueKey('toggle-favorite'));
    await tester.scrollUntilVisible(
      toggle,
      240,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(toggle);
    await tester.pump();
    expect(find.text('Quitar de mi lista'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mi lista'));
    await tester.pumpAndSettle();
    expect(find.byType(MovieRow), findsOneWidget);
    expect(find.text('Órbita'), findsOneWidget);
    await tester.tap(find.byTooltip('Quitar de mi lista'));
    await tester.pumpAndSettle();
    expect(find.byType(MovieRow), findsNothing);
    expect(find.text('Tu próxima historia empieza aquí'), findsOneWidget);
  });
  testWidgets('Buscar por título sin tildes y mostrar cero resultados', (
    tester,
  ) async {
    await tester.pumpWidget(const StreamHubApp());
    await tester.tap(find.byTooltip('Buscar').first);
    await tester.pumpAndSettle();
    final field = find.byKey(const ValueKey('search-field'));
    await tester.enterText(field, 'orbita');
    await tester.pumpAndSettle();
    expect(find.byType(MovieRow), findsOneWidget);
    expect(find.text('Órbita'), findsOneWidget);
    await tester.enterText(field, 'zzzzzz');
    await tester.pumpAndSettle();
    expect(find.byType(MovieRow), findsNothing);
    expect(
      find.text('No encontramos ese título. Intenta con otro.'),
      findsOneWidget,
    );
  });
  testWidgets('Inicio y listas se adaptan a 320 píxeles', (tester) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const StreamHubApp());
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Recomendadas'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.byType(MovieRow), findsWidgets);
  });
}
