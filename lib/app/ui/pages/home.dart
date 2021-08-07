import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_app/app/ui/component/list_movies.dart';
import 'package:movie_app/app/viewmodel/MoviesViewModel.dart';
import 'package:provider/provider.dart';

class Home extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotif) {
          if (scrollNotif.metrics.pixels >
              scrollNotif.metrics.maxScrollExtent - 50) {
            final viewModel = context.read<MoviesViewModel>();
            Future.microtask(() async => await viewModel.getMovies("/popular"));
          }
          return true;
        },
        child: NestedScrollView(
          physics: NeverScrollableScrollPhysics(),
          headerSliverBuilder: (ctx, _) {
            return [
              SliverAppBar(
                title: Text(
                  "Home",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ];
          },
          body: ListMovies(),
        ),
      ),
    );
  }
}
