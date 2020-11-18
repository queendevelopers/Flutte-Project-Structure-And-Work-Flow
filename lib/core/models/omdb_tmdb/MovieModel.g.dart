// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MovieModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) {
  return MovieModel(
    (json['results'] as List)
        ?.map((e) => e == null ? null : MovieResults.fromJson(e))
        ?.toList(),
  );
}

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
