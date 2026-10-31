import 'package:flutter/material.dart';
import 'models/catalog.dart';
import 'screens/home_screen.dart';
import 'screens/details_screen.dart';
import 'screens/library_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(const StreamHubApp());

class StreamHubApp extends StatefulWidget {
  const StreamHubApp({super.key});
  @override
  State<StreamHubApp> createState() => _StreamHubAppState();
}

class _StreamHubAppState extends State<StreamHubApp> {
  final favorites = Favorites();
  @override
  void dispose() {
    favorites.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Netflix · Laboratorio',
    debugShowCheckedModeBanner: false,
    theme: appTheme,
    // La demostración en Chrome conserva un ancho de teléfono en todas las rutas.
    // En Android y en ejecución normal se utiliza todo el espacio disponible.
    builder: (context, child) {
      const mobileDemo = bool.fromEnvironment('DEMO_MOVIL');
      if (!mobileDemo) return child!;
      return ColoredBox(
        color: const Color(0xFF202532),
        child: Center(
          child: SizedBox(width: 390, child: ClipRect(child: child!)),
        ),
      );
    },
    initialRoute: '/',
    // Navigator recibe los modelos por argumentos y conserva la pila de regreso.
    onGenerateRoute: (settings) {
      final Widget screen;
      switch (settings.name) {
        case '/details':
          screen = DetailsScreen(settings.arguments! as Movie, favorites);
        case '/favorites':
          screen = FavoritesScreen(favorites);
        case '/search':
          screen = const SearchScreen();
        default:
          screen = const HomeScreen();
      }
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => screen,
      );
    },
  );
}
