// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ArticleModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) {
  return ArticleModel(
      json['author'] as String,
      json['title'] as String,
      json['description'] as String,
      json['url'] as String,
      json['urlToImage'] as String,
      json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
      json['content'] as String,
      json['sourceS'] == null
          ? null
          : SourceModel.fromJson(json['source'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt?.toIso8601String(),
      'content': instance.content,
      'source': instance.source,
    };
