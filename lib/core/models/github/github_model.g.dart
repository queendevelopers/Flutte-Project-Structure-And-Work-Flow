// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitHubModel _$GitHubModelFromJson(Map<String, dynamic> json) {
  return GitHubModel(
    json['id'] as int,
    json['name'] as String,
    json['html_url'] as String,
    json['description'] as String,
  );
}

Map<String, dynamic> _$GitHubModelToJson(GitHubModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'html_url': instance.html_url,
      'description': instance.description,
    };
