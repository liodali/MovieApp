import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/MoviesViewModel.dart';
import '../component/list_movies.dart';

class Home extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    useEffect(() {
      controller.addListener(() async {
        if (controller.offset >  - 56 &&
            !controller.position.outOfRange &&
            controller.position.axisDirection == AxisDirection.down
        ) {
          final viewModel = context.read<MoviesViewModel>();
          print("${controller.offset},${controller.position.maxScrollExtent} : fetch ${viewModel.page}");
          Future.microtask(() async => await viewModel.getMovies("/popular"));
        }
      });
    }, [controller]);
    return Scaffold(
      body: NestedScrollView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
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
    );
  }
}
