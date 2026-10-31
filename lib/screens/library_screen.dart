import 'package:flutter/material.dart';
import '../data/catalog_data.dart';
import '../models/catalog.dart';
import '../widgets/catalog_widgets.dart';

class FavoritesScreen extends StatelessWidget {
  final Favorites favorites;
  const FavoritesScreen(this.favorites, {super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Mi lista')),
    body: ListenableBuilder(
      listenable: favorites,
      builder: (context, child) {
        final saved = movies.where(favorites.contains).toList();
        if (saved.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.bookmark_outline,
                    size: 56,
                    color: Color(0xFFE50914),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Tu próxima historia empieza aquí',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Outfit', fontSize: 24),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Abre un título y agrégalo a tu lista.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: saved.length,
          itemBuilder: (context, i) => MovieRow(
            saved[i],
            trailing: IconButton(
              tooltip: 'Quitar de mi lista',
              onPressed: () => favorites.toggle(saved[i]),
              icon: const Icon(Icons.bookmark_remove_outlined),
            ),
          ),
        );
      },
    ),
  );
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  // Buscar sin distinguir mayúsculas ni tildes.
  String normalize(String text) {
    var result = text.toLowerCase();
    const accents = {
      'á': 'a',
      'é': 'e',
      'í': 'i',
      'ó': 'o',
      'ú': 'u',
      'ü': 'u',
    };
    accents.forEach((a, b) => result = result.replaceAll(a, b));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final results = movies
        .where((m) => normalize(m.title).contains(normalize(query.trim())))
        .toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Descubre tu próxima historia')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              key: const ValueKey('search-field'),
              onChanged: (value) => setState(() => query = value),
              decoration: InputDecoration(
                labelText: 'Buscar por título',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${results.length} historias para explorar',
                style: const TextStyle(color: Colors.white54),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: results.isEmpty
                ? const Center(
                    child: Text('No encontramos ese título. Intenta con otro.'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: results.length,
                    itemBuilder: (context, i) => MovieRow(results[i]),
                  ),
          ),
        ],
      ),
    );
  }
}
