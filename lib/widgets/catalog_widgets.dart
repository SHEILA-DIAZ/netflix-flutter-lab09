import 'package:flutter/material.dart';
import '../models/catalog.dart';

class MovieImage extends StatelessWidget {
  final Movie movie;
  const MovieImage(this.movie, {super.key});
  @override
  Widget build(BuildContext context) {
    if (movie.local) {
      return Image.asset(movie.photo, fit: BoxFit.cover);
    }
    // Una imagen local respalda los errores de conexión.
    return Image.network(
      movie.photo,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) => progress == null
          ? child
          : const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
      errorBuilder: (context, error, stack) => Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/cosmos.jpg', fit: BoxFit.cover),
          const Center(
            child: Icon(
              Icons.cloud_off_outlined,
              semanticLabel: 'Imagen sin conexión',
            ),
          ),
        ],
      ),
    );
  }
}

void openMovie(BuildContext context, Movie movie) =>
    Navigator.pushNamed(context, '/details', arguments: movie);

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard(this.movie, {super.key});
  @override
  Widget build(BuildContext context) => SizedBox(
    width: 156,
    child: Card(
      margin: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: () => openMovie(context, movie),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(width: double.infinity, child: MovieImage(movie)),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    movie.genre,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11, color: Colors.white60),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class MovieRow extends StatelessWidget {
  final Movie movie;
  final Widget? trailing;
  const MovieRow(this.movie, {super.key, this.trailing});
  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      contentPadding: const EdgeInsets.all(10),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(width: 56, height: 64, child: MovieImage(movie)),
      ),
      title: Text(movie.title),
      subtitle: Text('${movie.genre} • ${movie.year} • ${movie.rating}'),
      isThreeLine: true,
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: () => openMovie(context, movie),
    ),
  );
}

class FeatureBanner extends StatelessWidget {
  final Movie movie;
  final Color accent;
  const FeatureBanner(
    this.movie, {
    super.key,
    this.accent = const Color(0xFFE50914),
  });
  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    child: SizedBox(
      height: 350,
      child: Stack(
        fit: StackFit.expand,
        children: [
          MovieImage(movie),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xF5080808)],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'DESTACADO EN NETFLIX',
                  style: TextStyle(
                    color: accent,
                    letterSpacing: 2,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  movie.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Lora',
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${movie.year}  •  ${movie.genre}  •  ${movie.rating}',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: accent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => openMovie(context, movie),
                  icon: const Icon(Icons.info_outline),
                  label: const Text('Explorar historia'),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
