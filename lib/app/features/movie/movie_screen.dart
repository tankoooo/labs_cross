// Подключаем Material Design
import 'package:flutter/material.dart';
// Подключаем цвета
import '../../theme/theme.dart';
// Подключаем модель
import '../../../domain/models/movie/movie.dart';
// Подключаем репозиторий
import '../../../domain/repositories/movie/movie_repository_interface.dart';
// Подключаем getIt
import '../../../di/di.dart';

class MovieScreen extends StatelessWidget {
  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    // Получаем фильм через репозиторий (асинхронно)
    return FutureBuilder<List<Movie>>(
      future: getIt<MovieRepositoryInterface>().getMovies(),
      builder: (context, snapshot) {
        // Загрузка
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        // Ошибка
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Ошибка')),
            body: Center(child: Text('${snapshot.error}')),
          );
        }
        // Данные
        final movies = snapshot.data ?? [];
        final movie = movies.firstWhere(
          (m) => m.id == movieId,
          orElse: () => movies.first,
        );

        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: ThemeColors.white),
            title: Text(movie.title),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Постер из сети
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      movie.poster,
                      width: double.infinity,
                      height: 350,
                      fit: BoxFit.contain,
                      errorBuilder: (_, _, _) => Container(
                        height: 350,
                        color: ThemeColors.surface,
                        child: const Icon(
                          Icons.movie,
                          color: ThemeColors.grey,
                          size: 64,
                        ),
                      ),
                    ),
                  ),
                ),
                // Текстовая информация
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: const TextStyle(
                          color: ThemeColors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Text(
                            'Оценка: ',
                            style: TextStyle(
                              color: ThemeColors.grey,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '${movie.myOpinion} / 21',
                            style: const TextStyle(
                              color: ThemeColors.accent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: movie.myOpinion / 21,
                          minHeight: 10,
                          backgroundColor: const Color(0xFF2A2A2A),
                          valueColor: const AlwaysStoppedAnimation(
                            ThemeColors.accent,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Год: ${movie.year}',
                        style: const TextStyle(
                          color: ThemeColors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Жанр: ${movie.genre}',
                        style: const TextStyle(
                          color: ThemeColors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Режиссёр: ${movie.director}',
                        style: const TextStyle(
                          color: ThemeColors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(color: Color(0xFF2A2A2A)),
                      const SizedBox(height: 12),
                      const Text(
                        'Описание',
                        style: TextStyle(
                          color: ThemeColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie.plot,
                        style: const TextStyle(
                          color: ThemeColors.grey,
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Мои заметки',
                        style: TextStyle(
                          color: ThemeColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: ThemeColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: ThemeColors.accent.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          movie.myNotes,
                          style: const TextStyle(
                            color: ThemeColors.white,
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}