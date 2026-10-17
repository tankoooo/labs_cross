// Подключаем модель Movie
import '../../models/movie/movie.dart';

// Интерфейс репозитория фильмов
abstract interface class MovieRepositoryInterface {
  // Получить список фильмов
  Future<List<Movie>> getMovies();
}