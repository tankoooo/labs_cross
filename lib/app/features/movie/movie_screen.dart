import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../home/movie_data.dart';    // список movies

class MovieScreen extends StatelessWidget {
  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    // Находим фильм по id
    final movie = movies.firstWhere(
      (item) => item.id == int.parse(movieId),
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
            // Большой постер
            Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  movie.imagePath,
                  width: double.infinity,
                  height: 350,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => Container(
                    height: 350,
                    color: ThemeColors.surface,
                    child: const Icon(Icons.movie,
                        color: ThemeColors.grey, size: 64),
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
                  // Название
                  Text(
                    movie.title,
                    style: const TextStyle(
                      color: ThemeColors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Оценка + шкала
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
                  // Год
                  Text(
                    'Год: ${movie.year}',
                    style: const TextStyle(
                      color: ThemeColors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Жанр
                  Text(
                    'Жанр: ${movie.genre}',
                    style: const TextStyle(
                      color: ThemeColors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Color(0xFF2A2A2A)),
                  const SizedBox(height: 12),
                  // Описание
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
                    movie.fullDescription,
                    style: const TextStyle(
                      color: ThemeColors.grey,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Мои заметки
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
  }
}