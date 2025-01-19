import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> negara = [];
  List<dynamic> filteredNegara = [];
  List<dynamic> favoriteNegara = [];
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
                    .where((negara) => (negara["name"]?["common"] ?? "")
                        .toString()
                        .toLowerCase()
                        .contains(searchQuery))
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
              final negaras = filteredNegara[index];
              final name = negaras["name"]?["common"] ?? "Unknown Country";
              final capital = (negaras["capital"]?.isNotEmpty ?? false)
                  ? negaras["capital"][0]
                  : "No Capital";
              final region = negaras["region"] ?? "No Region";
              final flag = negaras['flags']['png'] ?? "" ;
              return buildNegaraCard(negaras, name, capital, region, flag);
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
        final negaras = favoriteNegara[index];
        final name = negaras["name"]?["common"] ?? "Unknown Country";
        final capital = (negaras["capital"]?.isNotEmpty ?? false)
            ? negaras["capital"][0]
            : "No Capital";
        final region = negaras["region"] ?? "No Region";
        final flag = negaras['flag'] ?? "-";

        return buildNegaraCard(negaras, name, capital, region, flag);
      },
    );
  }

  Widget buildNegaraCard(
      Map<String, dynamic> negara, String name, String capital, String region, String flag) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(flag),
          radius: 30.0,
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Ibukota: $capital\nBenua: $region',
          style: const TextStyle(fontSize: 14),
        ),
        trailing: IconButton(
          icon: Icon(
            favoriteNegara.any((item) =>
                    item["name"]?["common"] == negara["name"]?["common"])
                ? Icons.favorite
                : Icons.favorite_border,
            color: favoriteNegara.any((item) =>
                    item["name"]?["common"] == negara["name"]?["common"])
                ? Colors.red
                : Colors.grey,
          ),
          onPressed: () {
            toggleFavorite(negara);
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailNegaraPage(negara: negara),
            ),
          );
        },
      ),
    );
  }

  void toggleFavorite(Map<String, dynamic> negara) {
    setState(() {
      if (favoriteNegara.any(
          (item) => item["name"]?["common"] == negara["name"]?["common"])) {
        favoriteNegara.removeWhere(
            (item) => item["name"]?["common"] == negara["name"]?["common"]);
      } else {
        favoriteNegara.add(negara);
      }
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
          negara = json;
          filteredNegara = json; // Initialize with the full list
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
