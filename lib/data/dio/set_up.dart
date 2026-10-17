
// Подключаем логгер Talker
import 'package:talker_dio_logger/talker_dio_logger.dart';
// Подключаем НАШ экземпляр dio (из data/dio/dio.dart)
import 'dio.dart';
// Подключаем talker (из di.dart)
import '../../di/di.dart';

// Настройка HTTP-клиента
void setUpDio() {
  // Базовый URL OMDb API
  dio.options.baseUrl = 'https://www.omdbapi.com/';

  // API-ключ
  dio.options.queryParameters.addAll({
    'apikey': '4799d0b4',
  });

  // Таймауты
  dio.options.connectTimeout = const Duration(seconds: 15);
  dio.options.receiveTimeout = const Duration(seconds: 15);

  // Логирование запросов
  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printRequestData: true,
        printRequestHeaders: true,
      ),
    ),
  );
}