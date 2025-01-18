import 'package:flutter/material.dart';

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
