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

  @override
  void initState() {
    super.initState();
    negaraList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Negara"),
      ),
      body: ListView.builder(
        itemCount: negara.length,
        itemBuilder: (context, index) {
          final negaras = negara[index];
          final name =
              (negaras["capital"] != null && negaras["capital"].isNotEmpty)
                  ? negaras["capital"][0]
                  : "No Capital";
          return ListTile(
            title: Text(name),
            subtitle: Text(negaras["name"]["common"] ?? "Unknown Country"),
          );
        },
      ),
    );
  }

  void negaraList() async {
    const url = 'https://restcountries.com/v3.1/all';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      setState(() {
        negara = json;
      });
    } else {
      // Handle error
      print("Failed to fetch data: ${response.statusCode}");
    }
  }
}


// class TabBarScreen extends StatefulWidget {
//   @override
//   _TabBarScreenState createState() => _TabBarScreenState();
// }

// class _TabBarScreenState extends State<TabBarScreen> {
//   final List<Map<String, String>> negaraList = [
//     {'nama': 'Indonesia', 'ibukota': 'Jakarta', 'benua': 'Asia'},
//     {'nama': 'Jepang', 'ibukota': 'Tokyo', 'benua': 'Asia'},
//     {
//       'nama': 'Amerika Serikat',
//       'ibukota': 'Washington, D.C.',
//       'benua': 'Amerika Utara'
//     },
//     {'nama': 'Brazil', 'ibukota': 'Brasília', 'benua': 'Amerika Selatan'},
//     {'nama': 'Australia', 'ibukota': 'Canberra', 'benua': 'Australia'},
//     {'nama': 'Jerman', 'ibukota': 'Berlin', 'benua': 'Eropa'},
//     {'nama': 'Afrika Selatan', 'ibukota': 'Pretoria', 'benua': 'Afrika'},
//   ];

//   final List<Map<String, String>> favoriteList = [];

//   void tambahNegara(BuildContext context) {
//     final namaController = TextEditingController();
//     final ibukotaController = TextEditingController();
//     final benuaController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Tambah Negara'),
//           content: SingleChildScrollView(
//             child: Column(
//               children: [
//                 TextField(
//                   controller: namaController,
//                   decoration: InputDecoration(labelText: 'Nama Negara'),
//                 ),
//                 TextField(
//                   controller: ibukotaController,
//                   decoration: InputDecoration(labelText: 'Ibukota'),
//                 ),
//                 TextField(
//                   controller: benuaController,
//                   decoration: InputDecoration(labelText: 'Benua'),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Batal'),
//             ),
//             TextButton(
//               onPressed: () {
//                 final nama = namaController.text;
//                 final ibukota = ibukotaController.text;
//                 final benua = benuaController.text;

//                 if (nama.isNotEmpty && ibukota.isNotEmpty && benua.isNotEmpty) {
//                   setState(() {
//                     negaraList.add({
//                       'nama': nama,
//                       'ibukota': ibukota,
//                       'benua': benua,
//                     });
//                   });
//                   Navigator.of(context).pop();
//                 }
//               },
//               child: Text('Tambah'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void tambahFavorite(Map<String, String> negara) {
//     if (!favoriteList.contains(negara)) {
//       setState(() {
//         favoriteList.add(negara);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: new Image.asset(
//             "images/logo.png",
//             width: 200.0,
//           ),
//           bottom: TabBar(
//             tabs: [
//               Tab(icon: Icon(Icons.home), text: 'Home'),
//               Tab(icon: Icon(Icons.favorite), text: 'Favorite'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             // Tab Home
//             Scaffold(
//               floatingActionButton: FloatingActionButton(
//                 onPressed: () => tambahNegara(context),
//                 child: Icon(Icons.add),
//                 tooltip: 'Tambah Negara',
//               ),
//               body: ListView.builder(
//                 itemCount: negaraList.length,
//                 itemBuilder: (context, index) {
//                   final negara = negaraList[index];
//                   return Card(
//                     margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         child: Text(negara['nama']![0]),
//                       ),
//                       title: Text(negara['nama']!),
//                       subtitle: Text(
//                           'Ibukota: ${negara['ibukota']} - Benua: ${negara['benua']}'),
//                       trailing: IconButton(
//                         icon: Icon(Icons.favorite,
//                             color: favoriteList.contains(negara)
//                                 ? Colors.red
//                                 : Colors.grey),
//                         onPressed: () {
//                           tambahFavorite(negara);
//                         },
//                       ),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 DetailNegaraPage(negara: negara),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//             // Tab Favorite
//             ListView.builder(
//               itemCount: favoriteList.length,
//               itemBuilder: (context, index) {
//                 final negara = favoriteList[index];
//                 return Card(
//                   margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       child: Text(negara['nama']![0]),
//                     ),
//                     title: Text(negara['nama']!),
//                     subtitle: Text(
//                         'Ibukota: ${negara['ibukota']} - Benua: ${negara['benua']}'),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DetailNegaraPage extends StatelessWidget {
//   final Map<String, String> negara;

//   const DetailNegaraPage({Key? key, required this.negara}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(negara['nama']!),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Nama Negara: ${negara['nama']}',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text('Ibukota: ${negara['ibukota']}',
//                 style: TextStyle(fontSize: 16)),
//             SizedBox(height: 10),
//             Text('Benua: ${negara['benua']}', style: TextStyle(fontSize: 16)),
//           ],
//         ),
//       ),
//     );
//   }
// }
