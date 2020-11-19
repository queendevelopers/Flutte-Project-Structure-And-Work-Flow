import 'package:entry_assignment/core/enum/viewstate.dart';
import 'package:entry_assignment/core/viewmodels/news_viewmodel.dart';
import 'package:entry_assignment/ui/views/BaseView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<NewsViewModel>(
      onModelReady: (model) => model.getLatestNews(),
      builder: (context, model, widget) => Container(
          child: model.state == ViewState.Busy
              ? Center(
                  child: CupertinoActivityIndicator(
                    radius: 16,
                  ),
                )
              : ListView.builder(
                  itemCount: model.newsModel.articles.length,
                  itemBuilder: (context, index) => model.getNewsDisplayWidget(
                      context,
                      model.newsModel.articles[index].urlToImage,
                      model.newsModel.articles[index].title,
                      model.newsModel.articles[index].description))),
    );
  }
}
