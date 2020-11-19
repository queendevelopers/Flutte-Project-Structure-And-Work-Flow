import 'package:entry_assignment/core/enum/viewstate.dart';
import 'package:entry_assignment/core/viewmodels/GitHubViewModel.dart';
import 'package:entry_assignment/ui/views/BaseView.dart';
import 'package:entry_assignment/ui/views/web_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GitHub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<GitHubViewModel>(
      onModelReady: (model) => model.getGitHubRepos(),
      builder: (context, model, child) => model.state == ViewState.Busy
          ? Center(
              child: CupertinoActivityIndicator(
                radius: 16,
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) => Container(
                child: ListTile(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => WebPage(
                            image_url: model.gitHubModel[index].html_url)),
                  ),
                  tileColor: Theme.of(context).backgroundColor,
                  title: Text(model.gitHubModel[index].name),
                  subtitle: Text(model.gitHubModel[index].description == null
                      ? ''
                      : model.gitHubModel[index].description),
                ),
              ),
              itemCount: model.gitHubModel.length,
            ),
    );
  }
}
