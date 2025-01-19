import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:negara_apps/model/country.dart';


class DetailNegaraPage extends StatelessWidget {
  final Country country;

  const DetailNegaraPage({Key? key, required this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final population = NumberFormat("#,###").format(country.population);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(country.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: NetworkImage(country.flagUrl), height: 100),
            SizedBox(height: 16),
            Text(
              'Nama Negara: ${country.name}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),
            Text('Ibukota: ${country.capital}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Benua: ${country.region}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Populasi: $population', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Bahasa: ${country.languages.join(", ")}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
