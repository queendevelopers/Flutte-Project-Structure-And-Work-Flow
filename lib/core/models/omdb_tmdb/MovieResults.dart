import 'package:json_annotation/json_annotation.dart';

part 'MovieResults.g.dart';

@JsonSerializable()
class MovieResults {
  double popularity;
  int vote_count;
  bool video;
  String poster_path;
  int id;
  bool adult;
  String backdrop_path;
  String orginal_language;
  String original_title;
  List<int> genre_ids;
  String title;
  double vote_average;
  String overview;
  DateTime release_date;
  String imdb_rating;

  double imdbRating;
  String trailer;

  MovieResults(
      this.popularity,
      this.vote_count,
      this.video,
      this.poster_path,
      this.id,
      this.adult,
      this.backdrop_path,
      this.orginal_language,
      this.original_title,
      this.genre_ids,
      this.title,
      this.vote_average,
      this.overview,
      this.release_date,
      this.imdb_rating,
      this.imdbRating,
      this.trailer);

  factory MovieResults.fromJson(json) => _$MovieResultsFromJson(json);
  Map<String, dynamic> toJson() => _$MovieResultsToJson(this);
}
