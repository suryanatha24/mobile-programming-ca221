import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> negara = [];
  List<dynamic> favoriteNegara = [];
  bool isLoading = true;
  String? errorMessage;
  int currentIndex = 0;

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
                    buildNegaraList(),
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

  Widget buildNegaraList() {
    return ListView.builder(
      itemCount: negara.length,
      itemBuilder: (context, index) {
        final negaras = negara[index];
        final name = negaras["name"]?["common"] ?? "Unknown Country";
        final capital = (negaras["capital"]?.isNotEmpty ?? false)
            ? negaras["capital"][0]
            : "No Capital";
        final region = negaras["region"] ?? "No Region";

        return buildNegaraCard(negaras, name, capital, region);
      },
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

        return buildNegaraCard(negaras, name, capital, region);
      },
    );
  }

  Widget buildNegaraCard(
      Map<String, dynamic> negara, String name, String capital, String region) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Text(
            name[0],
            style: const TextStyle(color: Colors.white),
          ),
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

class DetailNegaraPage extends StatelessWidget {
  final Map<String, dynamic> negara;

  const DetailNegaraPage({Key? key, required this.negara}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = negara["name"]?["common"] ?? "Unknown Country";
    final capital = (negara["capital"]?.isNotEmpty ?? false)
        ? negara["capital"][0]
        : "No Capital";
    final region = negara["region"] ?? "No Region";
    final population = negara["population"]?.toString() ?? "No Data";
    final languages = negara["languages"] != null
        ? (negara["languages"] as Map<String, dynamic>).values.join(", ")
        : "No Language Info";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Negara: $name',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 12),
            Text('Ibukota: $capital', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Benua: $region', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Populasi: $population', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Bahasa: $languages', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
