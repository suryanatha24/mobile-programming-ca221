import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:negara_apps/model/country.dart';
import 'package:negara_apps/repository/favorites_country_repository.dart';
import 'detail_negara_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FavoritesCountryRepository _repository = FavoritesCountryRepository();
  List<Country> negara = [];
  List<Country> filteredNegara = [];
  List<Country> favoriteNegara = [];
  bool isLoading = true;
  String? errorMessage;
  int currentIndex = 0;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    fetchNegaraList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "images/logo.png",
            width: 200.0,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : errorMessage != null
              ? Center(
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(fontSize: 16, color: Colors.red),
                  ),
                )
              : IndexedStack(
                  index: currentIndex,
                  children: [
                    buildSearchAndList(),
                    buildFavoriteList(),
                  ],
                ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }

  Widget buildSearchAndList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value.toLowerCase();
                filteredNegara = negara
                    .where((country) =>
                        country.name.toLowerCase().contains(searchQuery))
                    .toList();
              });
            },
            decoration: InputDecoration(
              hintText: "Cari negara...",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredNegara.length,
            itemBuilder: (context, index) {
              final country = filteredNegara[index];
              return buildNegaraCard(country);
            },
          ),
        ),
      ],
    );
  }

  Widget buildFavoriteList() {
    return ListView.builder(
      itemCount: favoriteNegara.length,
      itemBuilder: (context, index) {
        final country = favoriteNegara[index];
        return buildNegaraCard(country);
      },
    );
  }

  Widget buildNegaraCard(Country country) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(country.flagUrl),
          radius: 30.0,
        ),
        title: Text(
          country.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Ibukota: ${country.capital}\nBenua: ${country.region}',
          style: const TextStyle(fontSize: 14),
        ),
          trailing: FutureBuilder<bool>(
          future: _repository.isFavorite(country.name),
          builder: (context, snapshot) {
            final isFavorite = snapshot.data ?? false;
            return IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () async {
                if (isFavorite) {
                  await _repository.removeFavorite(country.name);
                } else {
                  await _repository.addFavorite(country);
                }
                fetchFavorites(); // Refresh favorites
              },
            );
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailNegaraPage(country: country),
            ),
          );
        },
      ),
    );
  }

  void toggleFavorite(Country country) {
    setState(() {
      if (favoriteNegara.contains(country)) {
        favoriteNegara.remove(country);
      } else {
        favoriteNegara.add(country);
      }
    });
  }

  Future<void> fetchFavorites() async {
    final favorites = await _repository.getFavorites();
    setState(() {
      favoriteNegara = List.generate(favorites.length, (index) {
        return Country.fromMap(favorites[index]);
      });
    });
  }

  void fetchNegaraList() async {
    const url = 'https://restcountries.com/v3.1/all';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = response.body;
        final List<dynamic> json = jsonDecode(body);

        setState(() {
          negara = json.map((data) => Country.fromJson(data)).toList();
          filteredNegara = negara; // Initialize with the full list
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage =
              "Failed to fetch data: ${response.statusCode}. Please try again.";
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "Something went wrong. Please check your connection.";
      });
    }
  }
}
