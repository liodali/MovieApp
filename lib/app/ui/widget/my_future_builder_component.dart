import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_app/domain/models/response.dart';

import 'loading_widget.dart';

typedef BikeBuilder<T> = Widget Function(T data);
typedef MapTo<T> = T Function(IResponse data);

class MyFutureBuilderComponent<T> extends HookWidget {
  final BikeBuilder<T> builder;
  final Widget? errorWidget;
  final Widget? loading;
  final Future<IResponse> future;
  final MapTo<T> mapTo;

  MyFutureBuilderComponent({
    required this.future,
    required this.builder,
    required this.mapTo,
    this.loading,
    this.errorWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HookBuilder(
      builder: (ctx) {
        final _hookFuture = useMemoized(() => future, [key]);
        final snap = useFuture(_hookFuture);
        if (snap.connectionState == ConnectionState.waiting) {
          return this.loading ?? LoadingWidget();
        } else if (snap.connectionState == ConnectionState.done) {
          if (snap.hasData) {
            final data = snap.data;
            if ((data is ErrorResponse)) {
              print(data.error);
              return this.errorWidget ?? Text("${data.error}");
            }
            return this.builder(mapTo(snap.data!));
          }
          print(snap.error);
          return this.errorWidget ?? Text("Opps!error");
        }
        return this.errorWidget ?? Text("Opps!error");
      },
    );
  }
}
