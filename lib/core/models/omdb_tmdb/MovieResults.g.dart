// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MovieResults.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieResults _$MovieResultsFromJson(Map<String, dynamic> json) {
  return MovieResults(
    (json['popularity'] as num)?.toDouble(),
    json['vote_count'] as int,
    json['video'] as bool,
    json['poster_path'] as String,
    json['id'] as int,
    json['adult'] as bool,
    json['backdrop_path'] as String,
    json['orginal_language'] as String,
    json['original_title'] as String,
    (json['genre_ids'] as List)?.map((e) => e as int)?.toList(),
    json['title'] as String,
    (json['vote_average'] as num)?.toDouble(),
    json['overview'] as String,
    json['release_date'] == null
        ? null
        : DateTime.parse(json['release_date'] as String),
    json['imdb_rating'] as String,
    (json['imdbRating'] as num)?.toDouble(),
    json['trailer'] as String,
  );
}

Map<String, dynamic> _$MovieResultsToJson(MovieResults instance) =>
    <String, dynamic>{
      'popularity': instance.popularity,
      'vote_count': instance.vote_count,
      'video': instance.video,
      'poster_path': instance.poster_path,
      'id': instance.id,
      'adult': instance.adult,
      'backdrop_path': instance.backdrop_path,
      'orginal_language': instance.orginal_language,
      'original_title': instance.original_title,
      'genre_ids': instance.genre_ids,
      'title': instance.title,
      'vote_average': instance.vote_average,
      'overview': instance.overview,
      'release_date': instance.release_date?.toIso8601String(),
      'imdb_rating': instance.imdb_rating,
      'imdbRating': instance.imdbRating,
      'trailer': instance.trailer,
    };
