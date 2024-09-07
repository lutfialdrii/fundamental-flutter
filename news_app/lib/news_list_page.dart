import 'package:flutter/material.dart';
import 'package:news_app/data/article.dart';
import 'package:news_app/detail_page.dart';

class NewsListPage extends StatelessWidget {
  static const routeName = '/article_list';
  const NewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News List Page"),
      ),
      body: FutureBuilder(
        future:
            DefaultAssetBundle.of(context).loadString('assets/articles.json'),
        builder: (context, snapshot) {
          final List<Article> articles = parseArticles(snapshot.data);
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return _buildArticleItem(context, articles[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildArticleItem(BuildContext context, Article article) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Image.network(
        article.urlToImage,
        width: 100,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(Icons.error),
          );
        },
      ),
      title: Text(article.title),
      subtitle: Text(article.author),
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName, arguments: article);
      },
    );
  }
}
