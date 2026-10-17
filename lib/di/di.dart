// Подключаем get_it
import 'package:get_it/get_it.dart';
// Подключаем TalkerFlutter
import 'package:talker_flutter/talker_flutter.dart';
// Подключаем Dio (экземпляр живёт в data/dio/dio.dart)
import '../data/dio/dio.dart';
// Подключаем настройку Dio
import '../data/dio/set_up.dart';
// Подключаем репозиторий
import '../domain/repositories/movie/movie_repository.dart';
import '../domain/repositories/movie/movie_repository_interface.dart';
// Подключаем BLoC
import '../app/features/home/bloc/home.dart';

// Глобальные экземпляры
final getIt = GetIt.instance;
final talker = TalkerFlutter.init();
// ⚠️ Строка "final Dio dio = Dio();" УДАЛЕНА — dio теперь только в data/dio/dio.dart

// Регистрация зависимостей
Future<void> setupLocator() async {
  // 1. Регистрируем talker как singleton
  getIt.registerSingleton(talker);

  // 2. Настраиваем Dio (baseUrl, ключ, логгер)
  setUpDio();

  // 3. Регистрируем репозиторий
  getIt.registerSingleton<MovieRepositoryInterface>(
    MovieRepository(dio: dio),
  );

  // 4. Регистрируем BLoC
  getIt.registerSingleton(
    HomeBloc(getIt.get<MovieRepositoryInterface>()),
  );
}