// Подключаем Dio
import 'package:dio/dio.dart';
// Подключаем модель
import '../../models/movie/movie.dart';
// Подключаем интерфейс
import 'movie_repository_interface.dart';
// Подключаем локальные оценки
import '../../../app/features/home/movie_opinions.dart';

// Реализация репозитория фильмов
class MovieRepository implements MovieRepositoryInterface {
  MovieRepository({required this.dio});

  final Dio dio;

  // IMDb ID наших фильмов
  static const List<String> _movieIds = [
    'tt0137523', // Бойцовский клуб
    'tt2884206', // Я — начало
    'tt1130884', // Остров проклятых
    'tt4731136', // Лекарство от здоровья
  ];

  @override
  Future<List<Movie>> getMovies() async {
    try {
      // Делаем все запросы параллельно
      final futures = _movieIds.map(
        (id) => dio.get('', queryParameters: {'i': id}),
      );
      final responses = await Future.wait(futures);

      // Парсим каждый ответ и мержим с локальными оценками
      return responses.map((response) {
        final movie = Movie.fromJson(response.data as Map<String, dynamic>);
        final opinion = movieOpinions[movie.id];
        return movie.copyWith(
          myOpinion: opinion?.myOpinion ?? 0,
          myNotes: opinion?.myNotes ?? 'Нет заметок',
        );
      }).toList();
    } on DioException catch (e) {
      // Пробрасываем ошибку наверх — её поймает BLoC
      throw e.message ?? 'Ошибка загрузки фильмов';
    }
  }
}