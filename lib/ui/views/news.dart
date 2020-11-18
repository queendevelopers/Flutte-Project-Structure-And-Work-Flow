import 'package:entry_assignment/core/enum/viewstate.dart';
import 'package:entry_assignment/core/models/news/NewsModel.dart';
import 'package:entry_assignment/core/viewmodels/news_viewmodel.dart';
import 'package:entry_assignment/ui/views/BaseView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class News extends StatelessWidget {
  NewsModel newsModel;

  @override
  Widget build(BuildContext context) {
    // Uri latestNewsUri = ApiService.rebuildUrl(WebAddress.newsApiBaseUrl,
    //     WebAddress.newsLatest, {'q': 'Bitcoin', 'apiKey': APIKeys.newsAPI});
    // ApiService.getNews(http.Client(), latestNewsUri, Keys.News);

    return BaseView<NewsViewModel>(
      onModelReady: (model) async {
        newsModel = await model.getLatestNews();
      },
      builder: (context, model, widget) => Container(
          child: model.state == ViewState.Busy
              ? Center(
                  child: CupertinoActivityIndicator(
                    radius: 16,
                  ),
                )
              : ListView.builder(
                  itemCount: newsModel.articles.length,
                  itemBuilder: (context, index) => model.getNewsDisplayWidget(
                      context,
                      newsModel.articles[index].urlToImage,
                      newsModel.articles[index].title,
                      newsModel.articles[index].description),
                )),
    );
  }
}
