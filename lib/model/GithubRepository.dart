import 'package:flutter/material.dart';

class GithubRepository {
  /// Repository full name.
  final String fullName;
  /// Repository description.
  final String description;
  /// Language in use.
  final String language;
  /// Repository html url.
  final String htmlUrl;
  /// Count of stars.
  final int stargazersCount;
  /// Count of watchers.
  final int watchersCount;
  /// Count of forks repository.
  final int forksCount;

  GithubRepository({
    @required this.fullName,
    @required this.description,
    @required this.language,
    @required this.htmlUrl,
    @required this.stargazersCount,
    @required this.watchersCount,
    @required this.forksCount,
  });

  GithubRepository.fromJson(Map<String, dynamic> json) 
    : fullName = json['full_name'],
    description = json['description'],
    language = json['language'],
    htmlUrl = json['html_url'],
    stargazersCount = json['stargazers_count'],
    watchersCount = json['watchers_count'],
    forksCount = json['forks_count'];
}