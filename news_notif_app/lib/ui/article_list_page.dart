import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_notif_app/provider/news_provider.dart';
import 'package:provider/provider.dart';
import '../common/styles.dart';
import '../widgets/card_article.dart';
import '../widgets/platform_widget.dart';

class ArticleListPage extends StatefulWidget {
  const ArticleListPage({super.key});

  @override
  State<ArticleListPage> createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  @override
  void initState() {
    super.initState();
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
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("News App"),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<NewsProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
              child: CircularProgressIndicator(color: secondaryColor));
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.articles.length,
            itemBuilder: (context, index) {
              var article = state.result.articles[index];
              return CardArticle(article: article);
            },
          );
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text(''),
            ),
          );
        }
      },
    );
  }

  // FutureBuilder<ArticlesResult> _buildList(BuildContext context) {
  //   return FutureBuilder<ArticlesResult>(
  //     future: _articles,
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState != ConnectionState.done) {
  //         return const Center(
  //             child: CircularProgressIndicator(
  //           color: secondaryColor,
  //         ));
  //       } else {
  //         if (snapshot.hasData) {
  //           return ListView.builder(
  //             shrinkWrap: true,
  //             itemCount: snapshot.data?.articles.length,
  //             itemBuilder: (context, index) {
  //               var article = snapshot.data!.articles[index];
  //               return CardArticle(article: article);
  //             },
  //           );
  //         } else if (snapshot.hasError) {
  //           return Center(
  //             child: Material(
  //               child: Text(snapshot.error.toString()),
  //             ),
  //           );
  //         } else {
  //           return const Material(
  //             child: Text(''),
  //           );
  //         }
  //       }
  //     },
  //   );
  // }
}
