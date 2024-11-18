import 'package:flutter/material.dart';
import '../models/plants.dart';
import 'add_plants_screen.dart';
import 'edit_plants_screen.dart';
import '../widgets/plants_item.dart';

class PlantsListScreen extends StatefulWidget {
  const PlantsListScreen({super.key});

  @override
  _PlantsListScreenState createState() => _PlantsListScreenState();
}

class _PlantsListScreenState extends State<PlantsListScreen> {
  List<Plants> plants = [
    Plants(
      speciesName: 'Mangifera indica',
      indonesianName: 'Pohon Mangga',
      description:
          'Mangga adalah salah satu tumbuhan yang memiliki buah yang manis.',
      imagePath:
          'https://th.bing.com/th/id/OIP.MkPBATnWwipCYePfM34eDgHaFA?rs=1&pid=ImgDetMain',
    ),
    Plants(
      speciesName: 'Musa Paradisiaca',
      indonesianName: 'Pohon Pisang',
      description:
          'Pohon Pisang adalah salah satu tumbuhan yang semua bagaiannya dapat dimanfaatkan',
      imagePath:
          'https://i2.wp.com/www.satuharapan.com/uploads/cache/news_60493_1466670618.jpg',
    ),
  ];

  void _editPlants(int index) async {
    final updatedPlants = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPlantsPage(plants: plants[index]),
      ),
    );

    if (updatedPlants != null) {
      setState(() {
        plants[index] = updatedPlants;
      });
    }
  }

  void _deletePlants(int index) {
    setState(() {
      plants.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plants List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final newAnimal = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddPlantsPage(),
                ),
              );
              if (newAnimal != null) {
                setState(() {
                  plants.add(newAnimal);
                });
              }
            },
          ),
        ],
      ),
      body: plants.isEmpty
          ? const Center(child: Text('No animals added yet.'))
          : ListView.builder(
              itemCount: plants.length,
              itemBuilder: (context, index) {
                return PlantsItem(
                  plants: plants[index],
                  onEdit: () => _editPlants(index),
                  onDelete: () => _deletePlants(index),
                );
              },
            ),
    );
  }
}
