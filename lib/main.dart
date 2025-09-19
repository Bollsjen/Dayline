import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Migraine Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MigrainePage(),
    );
  }
}

class MigrainePage extends StatefulWidget {
  @override
  _MigrainePageState createState() => _MigrainePageState();
}

class _MigrainePageState extends State<MigrainePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Migraine Tracker'),
        backgroundColor: Colors.blue[600],
        elevation: 0,
      ),
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          destinations: const <Widget> [
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: 'Home'
            ),

            NavigationDestination(
                selectedIcon: Icon(Icons.home),
                icon: Icon(Icons.calendar_month),
                label: 'Overview'
            ),

            NavigationDestination(
                selectedIcon: Icon(Icons.home),
                icon: Icon(Icons.analytics),
                label: 'Overview'
            )
          ]
      ),
      body: <Widget> [
        SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [

            ],
          )
        ),
        Column(
          children: [

          ],
        ),

        Column(
          children: [

          ],
        )
      ][currentPageIndex],
    );
  }
}