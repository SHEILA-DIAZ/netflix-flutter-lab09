# StreamHub · Diseño Netflix · Semana 09

Laboratorio de Aplicaciones Móviles Multiplataforma de Tecsup. Proyecto Flutter/Dart centrado únicamente en un catálogo móvil inspirado en Netflix, con negro, rojo, imágenes destacadas y listas de películas y series.

El nombre técnico del proyecto sigue siendo streamhub. La interfaz presenta Netflix. Se trata de una demostración académica: los 12 títulos son ficticios, las fotografías son ilustrativas y no existe afiliación con Netflix, reproducción, autenticación, API ni backend.

## Ejecución en Chrome con ancho móvil

Abrir esta carpeta en Visual Studio Code, instalar las extensiones Flutter y Dart, ejecutar `flutter pub get` y seleccionar **StreamHub · Chrome móvil** en Ejecutar y depurar. Pulsar F5.

También se puede ejecutar:

```sh
flutter run -d chrome --dart-define=DEMO_MOVIL=true
```

En esta computadora, si Flutter no está en PATH:

```powershell
& C:/flutter_windows_3.35.3-stable/flutter/bin/flutter.bat run -d chrome --dart-define=DEMO_MOVIL=true
```

El contenido se limita a 390 píxeles de ancho y su altura depende de la ventana. Es una demostración móvil en Chrome; no emula Android. Para Android, iniciar un emulador o conectar un dispositivo y ejecutar `flutter run` seleccionando su identificador. Sin DEMO_MOVIL la interfaz utiliza el espacio disponible.

Requisitos: Flutter estable, Dart >= 3.9 y < 4.0; Chrome para la demostración web. Android requiere además Android SDK. El permiso INTERNET ya está declarado en el manifiesto principal.

El proyecto incluye únicamente las plataformas Android y web (Chrome).

## Objetivo y tecnologías

Demostrar ListView, ListTile, List y Map, Row y Column, rutas, ThemeData, Card, tres tipografías e imágenes locales/remotas. Se utiliza Flutter, Dart, Material 3, ChangeNotifier y flutter_test.

## Estructura

```text
lib/
  main.dart                     Arranque, rutas y estado compartido
  models/catalog.dart           Movie, Category y Favorites
  data/catalog_data.dart        12 títulos, listas y mapa de géneros
  screens/home_screen.dart      Catálogo Netflix y categorías
  screens/details_screen.dart   Detalles y acción de favoritos
  screens/library_screen.dart   Mi lista y búsqueda
  widgets/catalog_widgets.dart  Imágenes, banner, tarjetas y filas
  theme/app_theme.dart          Tema negro y rojo
assets/
  images/cosmos.jpg             Fotografía local real
  fonts/                        Outfit, DM Sans y Lora con licencias
 test/                          Pruebas de funcionalidad y adaptación móvil
 scripts/empaquetar.py           Generación de labxy.zip
```

## Conceptos del laboratorio

| Concepto | Aplicación |
| --- | --- |
| ListView | Catálogo vertical y página de detalles desplazable. |
| ListView.builder | Carruseles Tendencias, Películas y Series; resultados de búsqueda y favoritos. |
| ListTile | MovieRow muestra una imagen, título, género, año y clasificación en Recomendadas, búsqueda y Mi lista. |
| Row | Icono y encabezado Recomendadas, con Expanded para adaptarse a teléfonos pequeños. |
| Column | Composición del banner, tarjetas y pantalla de búsqueda. |
| List | Colecciones tipadas de películas y categorías; resultados del filtro. |
| Map | genreDescriptions asocia géneros con descripciones; otro mapa normaliza vocales acentuadas en la búsqueda. |
| Navigator y rutas | onGenerateRoute define inicio, detalles, favoritos y búsqueda. pushNamed transporta el modelo Movie a detalles; el botón de regreso usa la pila de navegación. |
| ThemeData | Define el tema global oscuro con rojo Netflix, colores de navegación, fuentes y estilo de tarjetas. |
| Card | Widgets reutilizables para películas, banner y filas. |

Rutas: `/`, `/details`, `/favorites` y `/search`. El catálogo abre directamente al iniciar; no existe selección de otras plataformas.

## Funcionalidad

Inicio presenta un banner local, tres carruseles y Recomendadas en filas verticales. El modelo Movie distingue películas de series. Detalles presenta imagen, sinopsis, género, año y clasificación, y permite agregar/quitar de Mi lista.

Favorites extiende ChangeNotifier. Un Set de IDs evita duplicados y ListenableBuilder actualiza la interfaz en cuanto cambia el estado. Los favoritos duran durante la sesión y se reinician al cerrar la aplicación.

La búsqueda filtra por coincidencia parcial del título, sin distinguir mayúsculas ni tildes y eliminando espacios externos. La búsqueda y los favoritos muestran mensajes cuando sus listas están vacías. Los botones abren vistas, regresan o cambian el estado; no hay botones de reproducción simulada.

## Tres tipos de letra

- **Outfit:** identidad Netflix y encabezados del catálogo.
- **DM Sans:** controles, información y descripciones.
- **Lora:** lema y títulos destacados, con estilo serif.

Se incluyen los TTF en assets/fonts y se declaran en pubspec.yaml. Proceden de Google Fonts y cada familia incluye su licencia SIL Open Font License. No requieren descargar fuentes al iniciar. cupertino_icons complementa las fuentes de iconos del framework; no sustituye las tres familias de texto.

## Autora

Sheila Diaz Rojas

