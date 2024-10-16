import 'package:flutter/material.dart';

import '../common/navigation.dart';
import 'article_web_view.dart';
import '../data/model/article_result.dart';

class ArticleDetailPage extends StatelessWidget {
  static const routeName = '/article_detail';

  final Article article;
  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(article.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              article.urlToImage == null
                  ? Container(
                      height: 200,
                      child: Icon(Icons.error),
                    )
                  : Hero(
                      tag: article.urlToImage!,
                      child: Image.network(article.urlToImage!),
                    ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(article.description!),
                    const Divider(color: Colors.grey),
                    Text(
                      article.title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    const Divider(color: Colors.grey),
                    Text('Date : ${article.publishedAt}'),
                    const SizedBox(height: 10),
                    Text('Author : ${article.author}'),
                    const Divider(color: Colors.grey),
                    Text(
                      article.content!,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      child: const Text('Read more'),
                      onPressed: () {
                        // Navigator.pushNamed(context, ArticleWebView.routeName,
                        //     arguments: article.url);
                        Navigation.intentWithData(
                            ArticleWebView.routeName, article.url);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
