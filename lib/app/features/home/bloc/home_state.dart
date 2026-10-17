// Подключаем equatable
import 'package:equatable/equatable.dart';
// Подключаем модель
import '../../../../domain/models/movie/movie.dart';

// Базовый класс состояний
sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

// Начальное состояние
final class HomeInitial extends HomeState {}

// Идёт загрузка
final class HomeLoadInProgress extends HomeState {}

// Успешная загрузка
final class HomeLoadSuccess extends HomeState {
  const HomeLoadSuccess({required this.content});

  final List<Movie> content;

  @override
  List<Object> get props => [content];
}

// Ошибка загрузки
final class HomeLoadFailure extends HomeState {
  const HomeLoadFailure({required this.exception});

  final Object? exception;

  @override
  List<Object> get props => [];
}