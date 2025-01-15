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
  bool isLoading = true; // Menambahkan loading indicator saat data diambil
  String? errorMessage; // Menyimpan pesan error jika ada masalah
  int currentIndex = 0; // Menyimpan index tab yang dipilih

  @override
  void initState() {
    super.initState();
    negaraList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
              child: CircularProgressIndicator()) // Indikator loading
          : errorMessage != null
              ? Center(
                  child: Text(
                    errorMessage!,
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                )
              : currentIndex == 0
                  // Tab Home
                  ? ListView.builder(
                      itemCount: negara.length,
                      itemBuilder: (context, index) {
                        final negaras = negara[index];
                        final name =
                            negaras["name"]?["common"] ?? "Unknown Country";
                        final capital = negaras["capital"]?.isNotEmpty ?? false
                            ? negaras["capital"][0]
                            : "No Capital";
                        final region = negaras["region"] ?? "No Region";

                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              child: Text(
                                name[0],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(
                              name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Ibukota: $capital\nBenua: $region',
                              style: TextStyle(fontSize: 14),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.favorite_border,
                                color: favoriteNegara.contains(negaras)
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (favoriteNegara.contains(negaras)) {
                                    favoriteNegara.remove(negaras);
                                  } else {
                                    favoriteNegara.add(negaras);
                                  }
                                });
                              },
                            ),
                            onTap: () {
                              // Menavigasi ke halaman detail saat diklik
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailNegaraPage(negara: negaras),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    )
                  // Tab Favorite
                  : ListView.builder(
                      itemCount: favoriteNegara.length,
                      itemBuilder: (context, index) {
                        final negaras = favoriteNegara[index];
                        final name =
                            negaras["name"]?["common"] ?? "Unknown Country";
                        final capital = negaras["capital"]?.isNotEmpty ?? false
                            ? negaras["capital"][0]
                            : "No Capital";
                        final region = negaras["region"] ?? "No Region";

                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              child: Text(
                                name[0],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(
                              name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Ibukota: $capital\nBenua: $region',
                              style: TextStyle(fontSize: 14),
                            ),
                            onTap: () {
                              // Menavigasi ke halaman detail saat diklik
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailNegaraPage(negara: negaras),
                                ),
                              );
                            },
                          ),
                        );
                      },
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

  void negaraList() async {
    const url = 'https://restcountries.com/v3.1/all';
    final uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);
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
    final capital = negara["capital"]?.isNotEmpty ?? false
        ? negara["capital"][0]
        : "No Capital";
    final region = negara["region"] ?? "No Region";
    final population = negara["population"]?.toString() ?? "No Data";
    final languages = negara["languages"] != null
        ? negara["languages"].values.join(", ")
        : "No Language Info";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 251, 252, 255),
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Negara: $name',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 109, 186, 249)),
            ),
            SizedBox(height: 12),
            Text('Ibukota: $capital', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Benua: $region', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Populasi: $population', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Bahasa: $languages', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}





// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<dynamic> negara = [];
//   List<dynamic> favoriteNegara = [];
//   bool isLoading = true; // Menambahkan loading indicator saat data diambil
//   String? errorMessage; // Menyimpan pesan error jika ada masalah
//   int currentIndex = 0; // Menyimpan index tab yang dipilih

//   @override
//   void initState() {
//     super.initState();
//     negaraList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: new Image.asset(
//           "images/logo.png",
//           width: 200.0,
//         ),
//       ),
//       body: isLoading
//           ? const Center(
//               child: CircularProgressIndicator()) // Indikator loading
//           : errorMessage != null
//               ? Center(
//                   child: Text(errorMessage!),
//                 )
//               : currentIndex == 0
//                   // Tab Home
//                   ? ListView.builder(
//                       itemCount: negara.length,
//                       itemBuilder: (context, index) {
//                         final negaras = negara[index];
//                         final name =
//                             negaras["name"]?["common"] ?? "Unknown Country";
//                         final capital = negaras["capital"]?.isNotEmpty ?? false
//                             ? negaras["capital"][0]
//                             : "No Capital";
//                         final region = negaras["region"] ?? "No Region";

//                         return Card(
//                           margin: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 5),
//                           child: ListTile(
//                             leading: CircleAvatar(
//                               child: Text(name[0]), // Mengambil huruf pertama
//                             ),
//                             title: Text(name),
//                             subtitle: Text('Ibukota: $capital\nBenua: $region'),
//                             trailing: IconButton(
//                               icon: Icon(
//                                 Icons.favorite,
//                                 color: favoriteNegara.contains(negaras)
//                                     ? Colors.red
//                                     : Colors.grey,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   if (favoriteNegara.contains(negaras)) {
//                                     favoriteNegara.remove(negaras);
//                                   } else {
//                                     favoriteNegara.add(negaras);
//                                   }
//                                 });
//                               },
//                             ),
//                             onTap: () {
//                               // Menavigasi ke halaman detail saat diklik
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       DetailNegaraPage(negara: negaras),
//                                 ),
//                               );
//                             },
//                           ),
//                         );
//                       },
//                     )
//                   // Tab Favorite
//                   : ListView.builder(
//                       itemCount: favoriteNegara.length,
//                       itemBuilder: (context, index) {
//                         final negaras = favoriteNegara[index];
//                         final name =
//                             negaras["name"]?["common"] ?? "Unknown Country";
//                         final capital = negaras["capital"]?.isNotEmpty ?? false
//                             ? negaras["capital"][0]
//                             : "No Capital";
//                         final region = negaras["region"] ?? "No Region";

//                         return Card(
//                           margin: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 5),
//                           child: ListTile(
//                             leading: CircleAvatar(
//                               child: Text(name[0]), // Mengambil huruf pertama
//                             ),
//                             title: Text(name),
//                             subtitle: Text('Ibukota: $capital\nBenua: $region'),
//                             onTap: () {
//                               // Menavigasi ke halaman detail saat diklik
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       DetailNegaraPage(negara: negaras),
//                                 ),
//                               );
//                             },
//                           ),
//                         );
//                       },
//                     ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentIndex,
//         onTap: (index) {
//           setState(() {
//             currentIndex = index;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: 'Favorite',
//           ),
//         ],
//       ),
//     );
//   }

//   void negaraList() async {
//     const url = 'https://restcountries.com/v3.1/all';
//     final uri = Uri.parse(url);
//     try {
//       final response = await http.get(uri);
//       if (response.statusCode == 200) {
//         final body = response.body;
//         final json = jsonDecode(body);
//         setState(() {
//           negara = json;
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           isLoading = false;
//           errorMessage =
//               "Failed to fetch data: ${response.statusCode}. Please try again.";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//         errorMessage = "Something went wrong. Please check your connection.";
//       });
//     }
//   }
// }

// class DetailNegaraPage extends StatelessWidget {
//   final Map<String, dynamic> negara;

//   const DetailNegaraPage({Key? key, required this.negara}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final name = negara["name"]?["common"] ?? "Unknown Country";
//     final capital = negara["capital"]?.isNotEmpty ?? false
//         ? negara["capital"][0]
//         : "No Capital";
//     final region = negara["region"] ?? "No Region";
//     final population = negara["population"]?.toString() ?? "No Data";
//     final languages = negara["languages"] != null
//         ? negara["languages"].values.join(", ")
//         : "No Language Info";

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(name),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Nama Negara: $name',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text('Ibukota: $capital', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 10),
//             Text('Benua: $region', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 10),
//             Text('Populasi: $population', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 10),
//             Text('Bahasa: $languages', style: TextStyle(fontSize: 16)),
//           ],
//         ),
//       ),
//     );
//   }
// }





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
