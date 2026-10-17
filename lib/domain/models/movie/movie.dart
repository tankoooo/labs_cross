// Подключаем аннотации для json_serializable
import 'package:json_annotation/json_annotation.dart';

// Генерируемый файл (создастся build_runner)
part 'movie.g.dart';

@JsonSerializable()
class Movie {
  // IMDb ID (например, tt0137523)
  @JsonKey(name: 'imdbID')
  final String id;

  // Название фильма
  @JsonKey(name: 'Title')
  final String title;

  // Год выпуска
  @JsonKey(name: 'Year')
  final String year;

  // Жанр
  @JsonKey(name: 'Genre')
  final String genre;

  // Режиссёр
  @JsonKey(name: 'Director')
  final String director;

  // Полное описание
  @JsonKey(name: 'Plot')
  final String plot;

  // URL постера (из OMDb)
  @JsonKey(name: 'Poster')
  final String poster;

  // Рейтинг IMDb (строка "8.8")
  @JsonKey(name: 'imdbRating')
  final String imdbRating;

  // Локальные поля — не из API
  final int myOpinion;
  final String myNotes;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.genre,
    required this.director,
    required this.plot,
    required this.poster,
    required this.imdbRating,
    this.myOpinion = 0,
    this.myNotes = '',
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);

  Movie copyWith({int? myOpinion, String? myNotes}) {
    return Movie(
      id: id,
      title: title,
      year: year,
      genre: genre,
      director: director,
      plot: plot,
      poster: poster,
      imdbRating: imdbRating,
      myOpinion: myOpinion ?? this.myOpinion,
      myNotes: myNotes ?? this.myNotes,
    );
  }
}