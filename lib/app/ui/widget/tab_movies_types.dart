import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_app/app/viewmodel/movies_view_model.dart';
import 'package:provider/provider.dart';

class TabMoviesTypes extends HookWidget {
  final Map<String, String> tabs;
  final Function(String) selectedCategory;

  const TabMoviesTypes({
    Key? key,
    required this.tabs,
    required this.selectedCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieViewModel = context.read<MoviesViewModel>();
    String category = movieViewModel.typeMovieSelected;
    final tabsSelected =
        useState(category != tabs.values.first ? category : tabs.values.first);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabs.keys
            .map((key) => GestureDetector(
                  onTap: () {
                    tabsSelected.value = tabs[key]!;
                    selectedCategory(tabsSelected.value);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 3.0,
                      horizontal: 8.0,
                    ),
                    child: Tab(
                      child: Text(
                        key,
                        style: TextStyle(
                          fontSize: tabs[key] == tabsSelected.value ? 16 : 14,
                          color: tabs[key] == tabsSelected.value
                              ? Colors.white
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
