import 'package:expenses_manager/presentation/home/ui/home_screen.dart';
import 'package:expenses_manager/presentation/insights/ui/insights_screen.dart';
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
    final List<Widget> screens = [HomeScreen(), InsightsScreen()];

    // TODO COMPROBAR SI ES MEJOR QU LAS 2 PANTALLAS PRINCIPALES COMPARTAN SCAFFOLD Y GESTIONAR EL CONTENIDO DE CADA UNA DESDE AQUI :)))
    // LO DIGO POR ESTO: https://stackoverflow.com/questions/64618050/is-it-correct-to-have-nested-scaffold-in-flutter
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        // selectedItemColor: ColorScheme.of(context).onSurface,
        // unselectedItemColor: ColorScheme.of(context).primary,

        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
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
