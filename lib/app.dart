import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'screens/home_screen.dart';
import 'screens/guide_screen.dart';
import 'screens/routes_screen.dart';
import 'screens/reminder_screen.dart';

class EvpatoriaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evpatoria Guide',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    GuideScreen(),
    RoutesScreen(),
    ReminderScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: tr('home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: tr('guide'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions),
            label: tr('routes'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: tr('reminder'),
          ),
        ],
      ),
    );
  }
}