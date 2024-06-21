import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';

class SearchBarContainer extends StatefulWidget {
  const SearchBarContainer({
    required this.isFocused,
    super.key,
  });

  final bool isFocused;

  @override
  State<SearchBarContainer> createState() => _SearchBarContainerState();
}

class _SearchBarContainerState extends State<SearchBarContainer> {
  final _searchBarTextController = TextEditingController();
  final _searchBarFocusNode = FocusNode();

  var _isEmptyString = true;

  @override
  void initState() {
    super.initState();

    if (widget.isFocused) {
      _searchBarFocusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    super.dispose();

    _searchBarTextController.dispose();
    _searchBarFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: TextField(
        maxLines: 1,
        focusNode: _searchBarFocusNode,
        controller: _searchBarTextController,
        onChanged: (value) {
          _searchBarTextController.text = StringUtils.capitalize(
            value.trim(),
          );

          if (value.trim().isEmpty) return;

          setState(() {
            _isEmptyString = value.trim().isEmpty ? true : false;
          });
        },
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Container(
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
            child: const Icon(
              Icons.search,
              color: Colors.white,
              size: 25,
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _searchBarTextController.text = "";
                _isEmptyString = true;
              });
            },
            icon: Icon(
              Icons.close,
              color: _isEmptyString ? Colors.grey : Colors.white,
              size: 27,
            ),
          ),
        ),
      ),
    );
  }
}
