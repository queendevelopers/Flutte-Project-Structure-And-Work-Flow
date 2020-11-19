import 'package:json_annotation/json_annotation.dart';

part 'github_model.g.dart';

@JsonSerializable()
class GitHubModel {
  int id;
  String name;
  String html_url;
  String description;

  GitHubModel(this.id, this.name, this.html_url, this.description);
  factory GitHubModel.fromJson(json) => _$GitHubModelFromJson(json);
  Map<String, dynamic> toJson() => _$GitHubModelToJson(this);
}
