// Подключаем BLoC
import 'package:flutter_bloc/flutter_bloc.dart';
// Подключаем логгер
import '../../../../di/di.dart';
// Подключаем репозиторий
import '../../../../domain/repositories/movie/movie_repository_interface.dart';
// Подключаем события и состояния
import 'home_event.dart';
import 'home_state.dart';

// BLoC главного экрана
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MovieRepositoryInterface movieRepository;

  HomeBloc(this.movieRepository) : super(HomeInitial()) {
    on<HomeLoad>(_homeLoad);
  }

  Future<void> _homeLoad(HomeLoad event, Emitter<HomeState> emit) async {
    try {
      // Если ещё не загружали — показываем прогресс
      if (state is! HomeLoadSuccess) {
        emit(HomeLoadInProgress());
      }

      // Загружаем фильмы через репозиторий
      final movies = await movieRepository.getMovies();

      // Успех
      emit(HomeLoadSuccess(content: movies));
    } catch (exception, stackTrace) {
      // Ошибка — логируем и отправляем состояние
      emit(HomeLoadFailure(exception: exception));
      talker.handle(exception, stackTrace);
    } finally {
      // Завершаем completer, если он был передан
      event.completer?.complete();
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    talker.handle(error, stackTrace);
  }
}