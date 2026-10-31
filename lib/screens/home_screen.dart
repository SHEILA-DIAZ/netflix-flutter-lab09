import 'package:flutter/material.dart';
import '../data/catalog_data.dart';
import '../widgets/catalog_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text(
        'NETFLIX',
        style: TextStyle(
          fontFamily: 'Outfit',
          color: Color(0xFFE50914),
          letterSpacing: 2,
          fontSize: 28,
          fontWeight: FontWeight.w800,
        ),
      ),
      actions: [
        IconButton(
          tooltip: 'Buscar',
          onPressed: () => Navigator.pushNamed(context, '/search'),
          icon: const Icon(Icons.search),
        ),
        IconButton(
          tooltip: 'Mi lista',
          onPressed: () => Navigator.pushNamed(context, '/favorites'),
          icon: const Icon(Icons.bookmark_outline),
        ),
      ],
    ),
    bottomNavigationBar: NavigationBar(
      selectedIndex: 0,
      onDestinationSelected: (i) {
        if (i == 1) Navigator.pushNamed(context, '/search');
        if (i == 2) Navigator.pushNamed(context, '/favorites');
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Inicio',
        ),
        NavigationDestination(icon: Icon(Icons.search), label: 'Buscar'),
        NavigationDestination(
          icon: Icon(Icons.bookmark_outline),
          label: 'Mi lista',
        ),
      ],
    ),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Historias que te atrapan',
              style: TextStyle(fontFamily: 'Lora', fontSize: 22),
            ),
            const SizedBox(height: 8),
            const Text(
              'Descubre tu próxima película o serie.',
              style: TextStyle(color: Colors.white60),
            ),
            const SizedBox(height: 20), FeatureBanner(movies.first),
            // El ListView exterior desplaza la página; cada builder recorre una categoría.
            for (final category in categories) ...[
              const SizedBox(height: 28),
              Text(
                category.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 230,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: category.movies.length,
                  itemBuilder: (context, i) => MovieCard(category.movies[i]),
                ),
              ),
            ],
            const SizedBox(height: 28),
            Row(
              children: [
                const Icon(Icons.recommend_outlined, color: Color(0xFFE50914)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Recomendadas',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (final movie in movies.reversed) MovieRow(movie),
            const SizedBox(height: 20),
            const Text(
              'TECSUP · SEMANA 09\nDiseño académico inspirado en Netflix. Sin reproducción.',
              style: TextStyle(color: Colors.white38, fontSize: 11),
            ),
          ],
        ),
      ),
    ),
  );
}
