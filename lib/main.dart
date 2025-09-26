import 'package:dayline/screens/HomePage.dart';
import 'package:dayline/screens/OverviewPage.dart';
import 'package:dayline/screens/AnalyticsPage.dart';
import 'package:dayline/screens/SettingsPage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    OverviewPage(),
    AnalyticsPage(),
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.black87,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Container(
            child: GNav(
              backgroundColor: Colors.transparent,
              color: Colors.white70,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.deepPurple.shade700,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              gap: 12,
              onTabChange: (index) => {
                setState(() {
                  _selectedIndex = index; // Update selected tab
                })
              },
              tabs: [
                GButton(
                    icon: Icons.home,
                    text: 'Home'
                ),
                GButton(
                    icon: Icons.calendar_month,
                    text: 'Overview'
                ),
                GButton(
                    icon: Icons.analytics,
                    text: 'Analytics'
                ),

                GButton(
                    icon: Icons.settings,
                    text: 'Settings'
                )
              ],
            ),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF3366FF),
              const Color(0xFF00CCFF)
            ]
          ),
        ),
        child: SafeArea(child: _pages[_selectedIndex]),
      ),
    );
  }
}