import 'package:flutter/material.dart';
import 'package:myapp/views/moment/widgets/search_item_scrollable.dart';
import 'package:standard_searchbar/new/standard_icons.dart';
import 'package:standard_searchbar/new/standard_search_anchor.dart';
import 'package:standard_searchbar/new/standard_search_bar.dart';
import 'package:standard_searchbar/new/standard_suggestion.dart';
import 'package:standard_searchbar/new/standard_suggestions.dart';

class SearchBarApp extends StatelessWidget {
  const SearchBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(8.0)),
                SizedBox(
                  width: 400,
                  child: StandardSearchAnchor(
                    searchBar: StandardSearchBar(
                      bgColor: Color(0xFFF3E7DF),
                      leading: StandardIcons(icons: [Icon(Icons.search, size: 24, color: Color(0xFF7f593b))],)
                    ),
                    suggestions: StandardSuggestions(
                      suggestions: [
                        StandardSuggestion(text: 'Suggestion 1'),
                        StandardSuggestion(text: 'Suggestion 2'),
                        StandardSuggestion(text: 'Suggestion 3'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SearchItemScrollable()
        ],
      ),
    );
  }
}