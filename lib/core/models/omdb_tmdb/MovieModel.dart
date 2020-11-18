import 'package:entry_assignment/core/models/omdb_tmdb/MovieResults.dart';
import 'package:json_annotation/json_annotation.dart';

part 'MovieModel.g.dart';

@JsonSerializable()
class MovieModel {
  List<MovieResults> results;

  MovieModel(this.results);

  factory MovieModel.fromJson(json) => _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}
