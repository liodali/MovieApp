export 'routes.gr.dart';

import 'package:auto_route/annotations.dart';
import '../ui/pages/home.dart';
import '../ui/pages/movie_detail.dart';
import '../ui/pages/favorite_movie_list.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(
      path: "detail-movie",
      page: MovieDetail,
    ),
    AutoRoute(
      path: "store",
      page: Home,
      initial: true,
    ),
    AutoRoute(
      path: "favorite",
      page: FavoriteMovieList
    )
  ],
)
class $RootRouter {}