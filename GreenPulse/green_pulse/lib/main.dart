import 'package:flutter/material.dart';
import 'Faq.dart';
import 'carbon_calculator.dart';
import 'Eco_Friendly_Tips_Page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 46, 95, 18)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Green Pulse'),
      routes: {
        '/eco_tips': (context) => EcoFriendlyTipsPage(),
        '/faq': (context) => FAQPage(), // Add the route for the "Eco-Friendly Tips" page
        '/carbon_calculator': (context) => CarbonCalculatorPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  int _selectedIndex = 0;

  final List<Widget> _pages = [
    MyHomePageContent(), // Replace with your home page content
    EcoFriendlyTipsPage(), // Replace with your eco-friendly tips page content
    CarbonCalculatorPage(), // Add the Carbon Calculator page content
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      backgroundColor: Color.fromARGB(255, 236, 243, 234),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              color: Color.fromARGB(255, 218, 131, 74).withOpacity(0.8),
              height: 60,
              alignment: Alignment.center,
              child: Text(
                'Menu',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            ListTile(
              leading: Icon(Icons.lightbulb),
              title: Text('Eco-Friendly Tips'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/eco_tips');
              },
            ),
            ListTile(
              leading: Icon(Icons.help), // You can use a different icon for FAQ
              title: Text('FAQ'),
              onTap: () {
                Navigator.pushNamed(context, '/faq');
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('New Item 1'),
              onTap: () {
                // Handle new item 1 navigation
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('New Item 2'),
              onTap: () {
                // Handle new item 2 navigation
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Eco Tips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate), // Use an appropriate icon for the Carbon Calculator
            label: 'Calculator', // You can customize the label
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),

      // floatingActionButton: FloatingActionButton(
      //   // onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

class MyHomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Page Content'),
    );
  }
}

// class EcoFriendlyTipsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Eco-Friendly Tips Page Content'),
//     );
//   }
// }
