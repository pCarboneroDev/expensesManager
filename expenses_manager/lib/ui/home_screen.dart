import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
        child: ListView(children: [
          Text('Month balance', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black45)),
          _BalanceCard(),

          SizedBox(height: 40),

          Row(
            children: [
              Text('Last movements', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black45)),
              Spacer(),
              Icon(Icons.keyboard_arrow_right, color: Colors.black45)
            ],
          ),
          // aqui probablemente ira un bucle con un listView para que aparezcan las cosas

          _MovementHome(),
          SizedBox(height: 20,),
          _MovementHome(),
          SizedBox(height: 20,),
          _MovementHome(),
          SizedBox(height: 20,),
          _MovementHome(),
          SizedBox(height: 20,),
          _MovementHome(),
          
          
          // Container(
          //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //     color: Colors.blueAccent,
          //     borderRadius: BorderRadius.all(Radius.circular(15))
          //   ),

          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text('19/02/2026')
          //     ],
          //   ),
          // )
        ]),
      ),
    );
  }
}

class _MovementHome extends StatelessWidget {
  const _MovementHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('19/02/2026', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 15),

        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(FontAwesomeIcons.bowlFood),
                Text('Food and restaurants'),
                Text('-50.43€')
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(FontAwesomeIcons.bowlFood),
                Text('Food and restaurants'),
                Text('-50.43€')
              ],
            ),
          ],
        )
      ],
    );
  }
}

class _BalanceCard extends StatelessWidget {
  const _BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      // margin: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Color.fromARGB(255, 243, 237, 247),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(31, 0, 0, 0),
            offset: Offset(0, 3),
            blurRadius: BorderSide.strokeAlignOutside,
            spreadRadius: BorderSide.strokeAlignOutside,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '+528.98€',
            style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '-254.36€',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text(
                '+705.18€',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Spacer(), Text('Details'), Icon(Icons.arrow_right)],
          ),
        ],
      ),
    );
  }
}
