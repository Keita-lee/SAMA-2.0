import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String) onSearch;
  final double width;
  final Color? backgroundColor;
  final Color? borderColor;
  const CustomSearchBar(
      {Key? key,
      required this.onSearch,
      required this.width,
      this.backgroundColor,
      this.borderColor})
      : super(key: key);

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      child: SizedBox(
        width: widget.width,
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: "Search...",
            hintStyle:
                TextStyle(color: Colors.grey[500]), // Custom hint text color
            prefixIcon:
                Icon(Icons.search, color: Colors.grey), // Custom icon color
            border: widget.borderColor == null
                ? OutlineInputBorder(
                    borderSide: BorderSide.none, // Remove border
                  )
                : OutlineInputBorder(
                    borderSide:
                        BorderSide(color: widget.borderColor!, width: 1.0),
                  ),
            filled: true,
            fillColor: widget.backgroundColor ??
                const Color.fromRGBO(
                    203, 203, 203, 1), // Custom background color
            contentPadding: EdgeInsets.all(15.0),
          ),
          onChanged: (value) {
            widget.onSearch(value);
          },
          onSubmitted: (value) {
            widget.onSearch(value);
          },
        ),
      ),
    );
  }
}
