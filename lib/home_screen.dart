import 'package:final_proj/screens/areacalc.dart';
import 'package:final_proj/screens/counter.dart';
import 'package:final_proj/screens/volumecalc.dart';
import 'package:final_proj/login_register/login_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const CounterScreen(),
    const AreaCalculatorScreen(),
    const VolumeCalculatorScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Disable back button
      child: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.exposure_plus_1),
              label: 'Counter',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.square_foot),
              label: 'Area Calc',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.straighten),
              label: 'Volume Calc',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _signOut(context),
          child: const Icon(Icons.logout),
        ),
      ),
    );
  }

  void _signOut(BuildContext context) {
    // Navigate back to the login screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false, // Remove all previous routes
    );
  }
}
