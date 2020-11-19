import 'package:entry_assignment/core/enum/viewstate.dart';
import 'package:entry_assignment/core/viewmodels/MoviesViewModel.dart';
import 'package:entry_assignment/ui/views/BaseView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Movies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<MoviesViewModel>(
        onModelReady: (model) => model.getNowShowingMovies(),
        builder: (BuildContext context, model, child) =>
            model.state == ViewState.Busy
                ? Center(
                    child: CupertinoActivityIndicator(
                      radius: 18,
                    ),
                  )
                : GridView.builder(
                    itemCount: model.movieModel.results.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 0.71),
                    itemBuilder: (context, index) =>
                        model.getMoviesDisplayWidget(
                            context,
                            model.movieModel.results[index].Poster,
                            model.movieModel.results[index].title,
                            model.movieModel.results[index].imdbRating,
                            model.movieModel.results[index].trailer),
                  )
        /*        GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    children: List.generate(
                      model.movieModel.results.length,
                      (index) => model.getMoviesDisplayWidget(
                          context,
                          model.movieModel.results[index].Poster,
                          model.movieModel.results[index].title,
                          model.movieModel.results[index].imdbRating),
                    ))
    */
        );
  }
}
