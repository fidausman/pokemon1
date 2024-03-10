import 'dart:developer';

import 'package:app/modules/news/newsDetailsPage.dart';
import 'package:app/shared/models/article.dart';
import 'package:app/shared/repositories/newsService.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  final Dio dio = Dio();
  final PagingController<int, Article> pageController =
      PagingController(firstPageKey: 1);
  bool loading = false;

  List<Article> articles = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPage(1);
    print(dotenv.env['YOUTUBE_API_KEY']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "News",
        ),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >=
                notification.metrics.maxScrollExtent &&
            !loading &&
            pageController.nextPageKey != null) {
          fetchPage(pageController.nextPageKey as int);
          loading = true;
        }
        return false;
      },
      child: PagedListView(
        pagingController: pageController,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, Article article, index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NewsDetailsScreen(article: article)));
              },
              leading: article.urlToImage != null
                  ? Image.network(article.urlToImage!)
                  : Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcFOPu1YDIeX4wKXG3cI-wgDeS7OznQgdJ5A&usqp=CAU"),
              title: Text(
                article.title,
              ),
              subtitle: Text(article.publishedAt.toString()),
            );
          },
          firstPageProgressIndicatorBuilder: (context) {
            return const Center(child: CircularProgressIndicator());
          },
          newPageProgressIndicatorBuilder: (context) {
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      final List<Article> newsList = await NewsRepo.fetchAllArticles(pageKey);
      newsList.retainWhere((Article e) => e.title != '[Removed]');

      if (newsList.isEmpty) {
        pageController.appendLastPage([]);
      } else {
        final newPageKey = pageKey + 1;
        pageController.appendPage(newsList, newPageKey);
      }
    } catch (e) {
      pageController.error = e;
      print(e);
    } finally {
      loading = false;
    }
  }
}
