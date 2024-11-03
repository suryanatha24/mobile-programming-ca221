// import 'package:flutter/material.dart';

// void main() {
//   runApp(new MaterialApp(
//     home: new HalamanSatu(),
//   ));
// }

// class HalamanSatu extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       backgroundColor: const Color.fromARGB(255, 237, 220, 63),
//       appBar: new AppBar(
//           backgroundColor: Colors.white,
//           leading: new Container(
//               height: 500.0,
//               child: new Text(
//                 "Whats App",
//                 style: new TextStyle(
//                   color: Colors.green,
//                 ),
//               ))),
//     );
//   }
// }

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Baris Kotak'),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              KotakWarna(warna: Colors.red),
              KotakWarna(warna: Colors.green),
              KotakWarna(warna: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}

class KotakWarna extends StatelessWidget {
  final Color warna;

  KotakWarna({required this.warna});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      color: warna,
    );
  }
}
