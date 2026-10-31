import '../models/catalog.dart';

// List guarda el orden del catálogo; Map relaciona géneros con descripciones.
const List<String> titles = [
  'Órbita',
  'La última estación',
  'Ciudad nocturna',
  'Ecos del pasado',
  'Horizonte rojo',
  'Sin retorno',
  'Mar abierto',
  'El explorador',
  'Código azul',
  'Sombras del norte',
  'Tiempo prestado',
  'La frontera',
];
const Map<String, String> genreDescriptions = {
  'Ciencia ficción':
      'Una misión inesperada lleva a sus protagonistas más allá de los límites de lo conocido.',
  'Aventura':
      'Un viaje extraordinario pondrá a prueba el valor y la amistad de un equipo de exploradores.',
  'Drama':
      'Un encuentro transforma la vida de quienes deben elegir entre el pasado y un nuevo comienzo.',
  'Misterio':
      'Una pista olvidada revela secretos que nadie estaba preparado para descubrir.',
  'Fantasía':
      'Un mundo extraordinario guarda la clave para cambiar el destino de sus habitantes.',
  'Documental':
      'Un recorrido por paisajes y relatos que invita a observar nuestro planeta de otra manera.',
};
const photos = [
  'photo-1446776811953-b23d57bd21aa',
  'photo-1470770841072-f978cf4d019e',
  'photo-1519608487953-e999c86e7455',
  'photo-1464822759023-fed622ff2c3b',
  'photo-1500534623283-312aade485b7',
  'photo-1518837695005-2083093ee35b',
];
final List<Movie> movies = [
  for (var i = 0; i < titles.length; i++)
    Movie(
      id: 'movie-$i',
      title: titles[i],
      genre: genreDescriptions.keys.elementAt(i % genreDescriptions.length),
      description:
          '${titles[i]}. ${genreDescriptions.values.elementAt(i % genreDescriptions.length)} Una historia sobre las decisiones que cambian nuestro rumbo.',
      photo: i == 0
          ? 'assets/images/cosmos.jpg'
          : 'https://images.unsplash.com/${photos[i % photos.length]}?w=650&q=80',
      year: 2020 + i % 6,
      rating: i.isEven ? '12+' : '16+',
      local: i == 0,
      isSeries: i >= 8,
    ),
];
final List<Category> categories = [
  Category('Tendencias', movies.take(6).toList()),
  Category('Películas', movies.where((m) => !m.isSeries).toList()),
  Category('Series', movies.where((m) => m.isSeries).toList()),
];
