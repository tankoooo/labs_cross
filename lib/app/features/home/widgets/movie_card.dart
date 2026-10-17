// Подключаем Material Design
import 'package:flutter/material.dart';
// Подключаем GoRouter
import 'package:go_router/go_router.dart';
// Подключаем цвета темы
import '../../../theme/theme.dart';
// Подключаем модель
import '../../../../domain/models/movie/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Переход на детальный экран по IMDb ID
      onTap: () => context.push('/movie/${movie.id}'),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ThemeColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: ThemeColors.accent.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Постер из сети (OMDb)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                movie.poster,
                width: 90,
                height: 130,
                fit: BoxFit.cover,
                // Пока грузится — показываем прогресс
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    width: 90,
                    height: 130,
                    color: ThemeColors.surface,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: ThemeColors.accent,
                        strokeWidth: 2,
                      ),
                    ),
                  );
                },
                // Если ошибка — иконка
                errorBuilder: (_, _, _) => Container(
                  width: 90,
                  height: 130,
                  color: ThemeColors.surface,
                  child: const Icon(Icons.movie, color: ThemeColors.grey),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Правая колонка
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Название
                  Text(
                    movie.title,
                    style: const TextStyle(
                      color: ThemeColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Год
                  Text(
                    movie.year,
                    style: const TextStyle(
                      color: ThemeColors.grey,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Подпись
                  const Text(
                    'Моё мнение',
                    style: TextStyle(color: ThemeColors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  // Прогресс-бар + число
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: movie.myOpinion / 21,
                            minHeight: 8,
                            backgroundColor: const Color(0xFF2A2A2A),
                            valueColor: const AlwaysStoppedAnimation(
                              ThemeColors.accent,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${movie.myOpinion} / 21',
                        style: const TextStyle(
                          color: ThemeColors.accent,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}