import 'package:connectivity/connectivity.dart';
import 'package:entry_assignment/core/enum/viewstate.dart';
import 'package:entry_assignment/core/models/github/github_model.dart';
import 'package:entry_assignment/core/service/api_service.dart';
import 'package:entry_assignment/core/service/connectivity_service.dart';
import 'package:entry_assignment/core/service/db_service.dart';
import 'package:entry_assignment/core/viewmodels/basemodel.dart';
import 'package:entry_assignment/helper/keys.dart';
import 'package:entry_assignment/helper/web_address.dart';
import 'package:http/http.dart' as http;

class GitHubViewModel extends BaseModel {
  List<GitHubModel> gitHubModel;

  Future<List<GitHubModel>> getGitHubRepos() async {
    setState(ViewState.Busy);
    if (await ConnectivityService().getCurrentNetworkState() ==
        ConnectivityResult.none) {
      print('loading offline data for GitHub');
      gitHubModel = await DBService.db.readData(Keys.GitHub, 5);
      setState(ViewState.Idle);
      return gitHubModel;
    } else {
      Uri getGitRepos = ApiService.rebuildUrl(
          WebAddress.githubApiBaseUrl, WebAddress.githubGetRepos, null);
      await ApiService.getData(http.Client(), getGitRepos, Keys.GitHub);
      gitHubModel = await DBService.db.readData(Keys.GitHub, null);
      setState(ViewState.Idle);
      return gitHubModel;
    }
  }
}
