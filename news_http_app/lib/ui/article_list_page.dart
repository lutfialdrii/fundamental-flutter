import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_http_app/common/styles.dart';
import 'package:news_http_app/data/api/api_service.dart';
import 'package:news_http_app/widgets/card_article.dart';
import '../data/model/article_result.dart';
import '../widgets/platform_widget.dart';

class ArticleListPage extends StatefulWidget {
  const ArticleListPage({super.key});

  @override
  State<ArticleListPage> createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  late Future<ArticlesResult> _articles;

  @override
  void initState() {
    super.initState();
    _articles = ApiService().topHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  Scaffold _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News List Page"),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("News App"),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  FutureBuilder<ArticlesResult> _buildList(BuildContext context) {
    return FutureBuilder<ArticlesResult>(
      future: _articles,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator(color: secondaryColor,));
        } else {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.articles.length,
              itemBuilder: (context, index) {
                var article = snapshot.data!.articles[index];
                return CardArticle(article: article);
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Material(
                child: Text(snapshot.error.toString()),
              ),
            );
          } else {
            return const Material(
              child: Text(''),
            );
          }
        }
      },
    );
  }

  // Widget _buildArticleItem(BuildContext context, Article article) {
  //   return Material(
  //     child: ListTile(
  //       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //       leading: Hero(
  //         tag: article.urlToImage,
  //         child: Image.network(
  //           article.urlToImage,
  //           width: 100,
  //           errorBuilder: (context, error, stackTrace) {
  //             return const Center(
  //               child: Icon(Icons.error),
  //             );
  //           },
  //         ),
  //       ),
  //       title: Text(article.title),
  //       subtitle: Text(article.author),
  //       onTap: () {
  //         Navigator.pushNamed(context, DetailPage.routeName,
  //             arguments: article);
  //       },
  //     ),
  //   );
  // }
}
