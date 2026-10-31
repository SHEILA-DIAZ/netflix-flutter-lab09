import 'package:flutter/material.dart';
import '../models/catalog.dart';
import '../widgets/catalog_widgets.dart';

class DetailsScreen extends StatelessWidget {
  final Movie movie;
  final Favorites favorites;
  const DetailsScreen(this.movie, this.favorites, {super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Acerca de esta historia')),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: SizedBox(height: 310, child: MovieImage(movie)),
            ),
            const SizedBox(height: 24),
            Text(
              movie.isSeries ? 'SERIE · NETFLIX' : 'PELÍCULA · NETFLIX',
              style: const TextStyle(
                color: Color(0xFFE50914),
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              movie.title,
              style: const TextStyle(fontFamily: 'Lora', fontSize: 34),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                Chip(label: Text(movie.genre)),
                Chip(label: Text('${movie.year}')),
                Chip(label: Text('Clasificación ${movie.rating}')),
              ],
            ),
            const SizedBox(height: 20),
            Text('Sinopsis', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            Text(
              movie.description,
              style: const TextStyle(height: 1.7, color: Colors.white70),
            ),
            const SizedBox(height: 24),
            ListenableBuilder(
              listenable: favorites,
              builder: (context, child) {
                final saved = favorites.contains(movie);
                return FilledButton.icon(
                  key: const ValueKey('toggle-favorite'),
                  onPressed: () => favorites.toggle(movie),
                  icon: Icon(
                    saved ? Icons.bookmark : Icons.bookmark_add_outlined,
                  ),
                  label: Text(
                    saved ? 'Quitar de mi lista' : 'Agregar a mi lista',
                  ),
                );
              },
            ),
            const SizedBox(height: 18),
            const Text(
              'Título ficticio del catálogo educativo. Fotografía ilustrativa. No incluye reproducción.',
              style: TextStyle(fontSize: 12, color: Colors.white38),
            ),
          ],
        ),
      ),
    ),
  );
}
