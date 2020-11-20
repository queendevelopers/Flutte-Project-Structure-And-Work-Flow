import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:entry_assignment/core/api_keys.dart';
import 'package:entry_assignment/core/enum/viewstate.dart';
import 'package:entry_assignment/core/models/news/NewsModel.dart';
import 'package:entry_assignment/core/service/api_service.dart';
import 'package:entry_assignment/core/service/connectivity_service.dart';
import 'package:entry_assignment/core/service/db_service.dart';
import 'package:entry_assignment/core/viewmodels/basemodel.dart';
import 'package:entry_assignment/helper/keys.dart';
import 'package:entry_assignment/helper/web_address.dart';
import 'package:entry_assignment/ui/shared/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsViewModel extends BaseModel {
  NewsModel newsModel;

  Future<NewsModel> getLatestNews() async {
    setState(ViewState.Busy);
    if (await ConnectivityService().getCurrentNetworkState() ==
        ConnectivityResult.none) {
      print('loading offline data for News');
      newsModel = await DBService.db.readData(Keys.News, 5);
      setState(ViewState.Idle);
      return newsModel;
    } else {
      Uri latestNewsUri = ApiService.rebuildUrl(
          WebAddress.newsApiBaseUrl,
          WebAddress.newsLatest,
          {'q': 'Technology', 'apiKey': APIKeys.newsAPI});
      await ApiService.getData(http.Client(), latestNewsUri, Keys.News);
      newsModel = await DBService.db.readData(Keys.News, 5);
      setState(ViewState.Idle);
      return newsModel;
    }
  }

  Widget getNewsDisplayWidget(
      context, String urlToImage, String title, String description) {
    SizeConfig().init(context);
    return Container(
      child: Card(
          child: Stack(
        fit: StackFit.passthrough,
        alignment: AlignmentDirectional.bottomStart,
        children: [
          CachedNetworkImage(
            width: SizeConfig.safeBlockHorizontal,
            height: SizeConfig.safeBlockVertical * 30,
            imageUrl: urlToImage,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.all(8),
            color: Theme.of(context).backgroundColor,
            child: Column(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.caption,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
