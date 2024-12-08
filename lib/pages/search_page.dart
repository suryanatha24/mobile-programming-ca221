import 'package:flutter/material.dart';
import 'package:flutter_application_1/search/post_title.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = List.generate(
        30,
        (index) => const PostTitle(
              title: 'Surya Natha',
            ));
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white24,
          leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                hintStyle: TextStyle(color: Colors.grey[600]),
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(19.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.black87),
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Latest'),
              Tab(text: 'See All'),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: items,
          ),
        ),
      ),
    );
  }
}
