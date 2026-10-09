import 'package:flutter/material.dart';
import 'movie_data.dart';       // список фильмов
import 'widgets/widgets.dart';  // MovieCard

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Верхняя панель
      appBar: AppBar(title: const Text('Моё кино')),
      // Список карточек с отступами
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: movies.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) => MovieCard(movie: movies[index]),
      ),
    );
  }
}