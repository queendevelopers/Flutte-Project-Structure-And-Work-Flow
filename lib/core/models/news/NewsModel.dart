import 'package:json_annotation/json_annotation.dart';
import 'ArticleModel.dart';
part 'NewsModel.g.dart';

@JsonSerializable()
class NewsModel{
  String status;
  int totalResults;
  List<ArticleModel> articles;

  NewsModel(this.status, this.totalResults, this.articles);
  factory NewsModel.fromJson(Map<String,dynamic> json) => _$NewsModelFromJson(json);
  Map<String,dynamic> toJson()=>_$NewsModelToJson(this);

}