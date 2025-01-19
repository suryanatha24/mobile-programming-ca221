import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    final population = NumberFormat("#,###").format(negara["population"] ?? 0);
    final languages = negara["languages"] != null
        ? (negara["languages"] as Map<String, dynamic>).values.join(", ")
        : "No Language Info";
    final  flag = negara['flags']['png'] ?? "";

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
            Image(image: NetworkImage(flag), height: 100,),
            SizedBox(height: 16),
            Text(
              'Nama Negara: $name',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),
            Text('Ibukota: $capital', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Benua: $region', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Populasi: $population', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Bahasa: $languages', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
