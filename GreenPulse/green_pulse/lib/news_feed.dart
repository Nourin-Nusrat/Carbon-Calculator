import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsFeed extends StatefulWidget {
  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  List<NewsArticle> newsList = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final apiKey = 'YOUR_GUARDIAN_API_KEY';
    final apiUrl = Uri.parse(
        'https://content.guardianapis.com/search?q=environment&api-key=$apiKey');
    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['response']['results'];

      setState(() {
        newsList = results
            .map<NewsArticle>((article) => NewsArticle.fromJson(article))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        final article = newsList[index];
        return ListTile(
          title: Text(article.webTitle),
          subtitle: Text(article.webPublicationDate),
          onTap: () {
            // Handle the article click event, e.g., open a web page with the article.
          },
        );
      },
    );
  }
}

class NewsArticle {
  final String webTitle;
  final String webPublicationDate;

  NewsArticle({required this.webTitle, required this.webPublicationDate});

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      webTitle: json['webTitle'],
      webPublicationDate: json['webPublicationDate'],
    );
  }
}
