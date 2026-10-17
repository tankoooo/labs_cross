// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
  id: json['imdbID'] as String,
  title: json['Title'] as String,
  year: json['Year'] as String,
  genre: json['Genre'] as String,
  director: json['Director'] as String,
  plot: json['Plot'] as String,
  poster: json['Poster'] as String,
  imdbRating: json['imdbRating'] as String,
  myOpinion: (json['myOpinion'] as num?)?.toInt() ?? 0,
  myNotes: json['myNotes'] as String? ?? '',
);

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
  'imdbID': instance.id,
  'Title': instance.title,
  'Year': instance.year,
  'Genre': instance.genre,
  'Director': instance.director,
  'Plot': instance.plot,
  'Poster': instance.poster,
  'imdbRating': instance.imdbRating,
  'myOpinion': instance.myOpinion,
  'myNotes': instance.myNotes,
};
