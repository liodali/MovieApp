import 'package:flutter/material.dart';

class SearchTextMovie extends StatelessWidget {
  final TextEditingController textController;
  final Function(String)? onSubmit;
  final Function()? onEditingComplete;
  final Function(String)? onChange;
  final Function()? onTap;
  final String hint;
  final double radius;

  const SearchTextMovie({
    Key? key,
    required this.textController,
    this.onSubmit,
    this.onChange,
    this.onEditingComplete,
    this.onTap,
    this.hint = "search",
    this.radius = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: true,
      expands: false,
      scrollPadding: EdgeInsets.zero,
      controller: textController,
      maxLines: 1,
      onChanged: onChange,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmit,
      onTap: onTap,
      cursorColor: Colors.black45,
      cursorWidth: 3.0,
      decoration: InputDecoration(
        fillColor: Colors.grey[400],
        hintText: hint,
        filled: true,
        prefixIcon: Icon(
          Icons.search,
          size: 24,
          color: Colors.black38,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.all(3.0),
      ),
    );
  }
}
