// Подключаем Material Design
import 'package:flutter/material.dart';
// Подключаем BlocBuilder
import 'package:flutter_bloc/flutter_bloc.dart';
// Подключаем getIt
import '../../../di/di.dart';
// Подключаем BLoC
import 'bloc/home.dart';
// Подключаем виджеты
import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Получаем BLoC из DI
  final _homeBloc = getIt<HomeBloc>();

  // Отправляем событие загрузки
  void loadHome() => _homeBloc.add(const HomeLoad());

  @override
  void initState() {
    super.initState();
    loadHome(); // при старте — грузим фильмы
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Моё кино')),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: _homeBloc,
        builder: (context, state) {
          // Переключаем UI по состоянию
          return switch (state) {
            HomeInitial() => const SizedBox.shrink(),
            HomeLoadInProgress() => const Center(
                child: CircularProgressIndicator(),
              ),
            HomeLoadSuccess() => _buildSuccess(state),
            HomeLoadFailure() => _buildFailure(state),
          };
        },
      ),
    );
  }

  // Успех — список фильмов
  Widget _buildSuccess(HomeLoadSuccess state) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: state.content.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) => MovieCard(movie: state.content[index]),
    );
  }

  // Ошибка — сообщение + кнопка "Повторить"
  Widget _buildFailure(HomeLoadFailure state) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.white70),
          const SizedBox(height: 16),
          Text(
            'Ошибка загрузки:\n${state.exception}',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: loadHome,
            child: const Text('Повторить'),
          ),
        ],
      ),
    );
  }
}