import 'package:entry_assignment/core/enum/viewstate.dart';
import 'package:entry_assignment/core/viewmodels/MoviesViewModel.dart';
import 'package:entry_assignment/ui/views/BaseView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Movies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<MoviesViewModel>(
        onModelReady: (model) async => await model.getNowShowingMovies(),
        builder: (context, model, child) => model.state == ViewState.Busy
            ? Center(
                child: Center(
                  child: CupertinoActivityIndicator(
                    radius: 18,
                  ),
                ),
              )
            : Container(
                child: Center(
                  child: Text('IDLE'),
                ),
              ));
  }
}
