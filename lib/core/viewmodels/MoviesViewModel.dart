import 'package:entry_assignment/core/api_keys.dart';
import 'package:entry_assignment/core/enum/viewstate.dart';
import 'package:entry_assignment/core/models/omdb_tmdb/MovieModel.dart';
import 'package:entry_assignment/core/service/api_service.dart';
import 'package:entry_assignment/core/viewmodels/basemodel.dart';
import 'package:entry_assignment/helper/keys.dart';
import 'package:entry_assignment/helper/web_address.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MoviesViewModel extends BaseModel {
  Future<MovieModel> getNowShowingMovies() async {
    setState(ViewState.Busy);
    Uri nowShowingMoviesUri = ApiService.rebuildUrl(WebAddress.tmdbApiBaseUrl,
        WebAddress.tmdbApiNowShowingMovies, {'api_key': APIKeys.tmdpAPI});
    MovieModel movieModel = await ApiService.getData(
        http.Client(), nowShowingMoviesUri, Keys.Movies);
    setState(ViewState.Idle);
    return movieModel;
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
