import 'package:expenses_manager/main.dart';
import 'package:expenses_manager/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [HomeScreen(), MyHomePage(title: 'pruebis')];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ColorScheme.of(context).onSurface,
        unselectedItemColor: ColorScheme.of(context).primary,

        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.database),
            label: "Insights",
          )
        ],
      ),
      body: Center(child: screens[selectedIndex]),
    );
  }
}
