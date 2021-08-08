export 'routes.gr.dart';

import 'package:auto_route/annotations.dart';
import 'package:movie_app/app/ui/pages/home.dart';
import 'package:movie_app/app/ui/pages/movie_detail.dart';

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
  ],
)
class $RootRouter {}