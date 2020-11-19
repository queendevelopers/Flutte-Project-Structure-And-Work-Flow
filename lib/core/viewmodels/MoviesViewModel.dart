import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:entry_assignment/core/api_keys.dart';
import 'package:entry_assignment/core/enum/viewstate.dart';
import 'package:entry_assignment/core/models/omdb_tmdb/MovieModel.dart';
import 'package:entry_assignment/core/service/api_service.dart';
import 'package:entry_assignment/core/service/connectivity_service.dart';
import 'package:entry_assignment/core/service/db_service.dart';
import 'package:entry_assignment/core/viewmodels/basemodel.dart';
import 'package:entry_assignment/helper/keys.dart';
import 'package:entry_assignment/helper/web_address.dart';
import 'package:entry_assignment/ui/shared/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MoviesViewModel extends BaseModel {
  MovieModel movieModel;

  Future<MovieModel> getNowShowingMovies() async {
    setState(ViewState.Busy);
    await DBService.db.readData(Keys.Movies, 5);
    if (await ConnectivityService().getCurrentNetworkState() ==
        ConnectivityResult.none) {
      print('loading offline data for Movies');
      movieModel = await DBService.db.readData(Keys.News, 5);
      setState(ViewState.Idle);
      return movieModel;
    } else {
      Uri nowShowingMoviesUri = ApiService.rebuildUrl(WebAddress.tmdbApiBaseUrl,
          WebAddress.tmdbApiNowShowingMovies, {'api_key': APIKeys.tmdpAPI});
      movieModel = await ApiService.getData(
          http.Client(), nowShowingMoviesUri, Keys.Movies);
      movieModel = await DBService.db.readData(Keys.Movies, 5);
      setState(ViewState.Idle);
      return movieModel;
    }
  }

  Widget getMoviesDisplayWidget(context, imageUrl, movieName, imdbRating) {
    SizeConfig().init(context);
    return Container(
      child: Expanded(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          clipBehavior: Clip.antiAlias,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    color: Theme.of(context).backgroundColor,
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Text(movieName)),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star_rate_outlined),
                            Flexible(child: Text(imdbRating))
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  playVideo(String id) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'iLnmTe5Q2Qw',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
  }
}
