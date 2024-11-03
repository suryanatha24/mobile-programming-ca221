import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp Clone',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: WhatsAppHome(),
    );
  }
}

class WhatsAppHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'WhatsApp',
            style: new TextStyle(color: Colors.green),
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(icon: Icon(FontAwesomeIcons.camera), onPressed: () {}),
            IconButton(icon: Icon(FontAwesomeIcons.search), onPressed: () {}),
            IconButton(
                icon: Icon(FontAwesomeIcons.ellipsisV), onPressed: () {}),
          ],
          bottom: TabBar(
            indicatorColor: Colors.green,
            tabs: [
              Tab(text: 'Chats'),
              Tab(text: 'Status'),
              Tab(text: 'Calls'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Chats Tab
            ChatsTab(),

            // Status Tab
            StatusTab(),

            // Calls Tab
            CallsTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Logika Bisa Dibuat nanti ...
          },
          child: Icon(FontAwesomeIcons.comment),
          backgroundColor: Colors.green[600],
        ),
      ),
    );
  }
}

class ChatsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://www.lintasparlemen.com/wp-content/uploads/anies-baswedan-1.jpg',
            ),
          ),
          title: Text('Anies'),
          subtitle: Text('Gimana Kabarnya Bro?'),
          trailing: Text('12:30 PM'),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://www.harapanrakyat.com/wp-content/uploads/2023/10/PDIP-Dukung-Gibran-Rakabuming-Raka-Sebagai-Bacawapres-Prabowo.jpg'),
          ),
          title: Text('Gibran'),
          subtitle: Text('Mau Join Gak?'),
          trailing: Text('Yesterday'),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://dnews.co.id/wp-content/uploads/2022/10/channels4_profile.jpg'),
          ),
          title: Text('Ganjar'),
          subtitle: Text('tetap solid bro'),
          trailing: Text('Yesterday'),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://awsimages.detik.net.id/community/media/visual/2021/08/02/cak-imin-dok-pribadi_43.jpeg?w=700&q=90.jpg'),
          ),
          title: Text('Cak Imin'),
          subtitle: Text('Alhamdulilah Saya masuk kwkwkwk'),
          trailing: Text('Yesterday'),
        ),
      ],
    );
  }
}

class StatusTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.add, color: Colors.black),
          ),
          title: Text('My Status'),
          subtitle: Text('Tap to add status update'),
        ),
        Divider(),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://awsimages.detik.net.id/community/media/visual/2021/08/02/cak-imin-dok-pribadi_43.jpeg?w=700&q=90.jpg'),
          ),
          title: Text('Cak Imin'),
          subtitle: Text('Today, 8:30 AM'),
        ),
      ],
    );
  }
}

class CallsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://www.lintasparlemen.com/wp-content/uploads/anies-baswedan-1.jpg',
            ),
          ),
          title: Text('Anies'),
          subtitle: Row(
            children: [
              Icon(Icons.call_made, color: Colors.green, size: 16),
              SizedBox(width: 4),
              Text('Today, 10:30 AM'),
            ],
          ),
          trailing: Icon(Icons.phone, color: Colors.green),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://dnews.co.id/wp-content/uploads/2022/10/channels4_profile.jpg'),
          ),
          title: Text('Ganjar'),
          subtitle: Row(
            children: [
              Icon(Icons.call_received, color: Colors.red, size: 16),
              SizedBox(width: 4),
              Text('Yesterday, 7:45 PM'),
            ],
          ),
          trailing: Icon(Icons.video_call, color: Colors.green),
        ),
      ],
    );
  }
}
