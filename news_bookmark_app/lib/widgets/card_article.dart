import 'package:flutter/material.dart';
import 'package:news_bookmark_app/common/navigation.dart';
import 'package:news_bookmark_app/provider/database_provider.dart';
import 'package:provider/provider.dart';

import '../data/model/article_result.dart';
import '../ui/article_detail_page.dart';

class CardArticle extends StatelessWidget {
  final Article article;
  const CardArticle({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
        future: provider.isBookmarked(article.url),
        builder: (context, snapshot) {
          var isBookmarked = snapshot.data ?? false;
          return Material(
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Hero(
                tag: article.urlToImage!,
                child: Image.network(
                  article.urlToImage!,
                  width: 100,
                ),
              ),
              title: Text(article.title),
              subtitle: Text(article.author ?? ''),
              trailing: isBookmarked
                  ? IconButton(
                      onPressed: () {
                        provider.removeBookmark(article.url);
                      },
                      icon: const Icon(Icons.bookmark))
                  : IconButton(
                      onPressed: () {
                        provider.addBookmark(article);
                      },
                      icon: const Icon(Icons.bookmark_border)),
              onTap: () {
                Navigation.intentWithData(ArticleDetailPage.routeName, article);
              },
            ),
          );
        },
      );
    });
  }
}
