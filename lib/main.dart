import 'package:flutter/material.dart';
import 'package:negara_apps/views/home_page.dart';


void main() {
  
  runApp(NegaraApps());
}

class NegaraApps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Negara Apps',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}
