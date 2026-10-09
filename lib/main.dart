import 'package:flutter/material.dart';
import 'di/di.dart';
import 'movie_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  FlutterError.onError = (details) {
    talker.handle(details.exception, details.stack);
  };

  runApp(const MovieListApp());
}