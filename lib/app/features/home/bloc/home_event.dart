import 'dart:async';
import 'package:equatable/equatable.dart';
// Подключаем equatable для сравнения объектов


// Базовый класс событий
sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

// Событие загрузки фильмов
final class HomeLoad extends HomeEvent {
  const HomeLoad({this.completer});

  final Completer? completer;

  @override
  List<Object> get props => [];
}