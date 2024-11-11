import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Faq.dart';
import 'carbon_calculator.dart';
import 'Eco_Friendly_Tips_Page.dart';
import 'challenges.dart';
import 'news_feed.dart';
import 'weather_model.dart';
import 'repo.dart';
import 'feedback.dart';
// import 'MyHomePageContent.dart';// Import the news feed file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static String defaultCity = 'Rajshahi';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GREEN PULSE',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 46, 95, 18)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Green Pulse'),
      routes: {
        '/eco_tips': (context) => const TermsOfUsePage(),
        '/faq': (context) => const FAQPage(),
        '/carbon_calculator': (context) => const CarbonCalculatorPage(),
        '/challenges': (context) => const ChallengesPage(),
        '/news_feed': (context) => const NewsFeedPage(),
        '/feedback': (context) =>
            const feedback(), // Add the route for the News Feed page
        // '/location' : (context) => const LocationScreen(),
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
    const MyHomePageContent(),
    const ChallengesPage(),
    const CarbonCalculatorPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          // Add an icon button to navigate to the News Feed page
          IconButton(
            icon: const Icon(Icons.article),
            onPressed: () {
              Navigator.pushNamed(context, '/news_feed');
            },
          ),
          const Text('News'),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              color: const Color.fromARGB(255, 218, 131, 74).withOpacity(0.8),
              height: 60,
              alignment: Alignment.center,
              child: const Text(
                'Green Pulse',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.security),
              title: const Text('Terms of Use'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/eco_tips');
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('FAQ'),
              onTap: () {
                Navigator.pushNamed(context, '/faq');
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat_bubble),
              title: const Text('Feedback & Support'),
              onTap: () {
                Navigator.pushNamed(context, '/feedback');
                // Handle new item 1 navigation
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.settings),
            //   title: Text('location'),
            //   onTap: () {
            //     Navigator.pushNamed(context, '/location');
            //     // Handle new item 2 navigation
            //   },
            // ),
          ],
        ),
      ),
      // body: _pages[_selectedIndex],
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/green.png'),
            fit: BoxFit.cover,
          ),
        ),

        child: _pages[_selectedIndex],
        // child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Challenges',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Carbon Tracker',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

// class MyHomePageContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(

//     );
//   }
// }

// Import your actual weather model file

// Import your actual weather model file

class MyHomePageContent extends StatefulWidget {
  const MyHomePageContent({super.key});

  @override
  _MyHomePageContentState createState() => _MyHomePageContentState();
}

class _MyHomePageContentState extends State<MyHomePageContent> {
  final TextEditingController _searchController = TextEditingController();
  WeatherModel? weatherModel;
  // late String defaultCity = 'Rajshahi'; // Default city set to Rajshahi

  late List<String> ecoTips;
  late String currentTip = "null";
  late int randomIndex = 0;

  @override
  void initState() {
    super.initState();
    _searchTemperature(MyApp.defaultCity);
    loadEcoTips();
  }

  Future<void> loadEcoTips() async {
    final String tipsJsonString =
        await rootBundle.loadString('assets/tips.json');
    final List<dynamic> tipsList = json.decode(tipsJsonString);
    ecoTips = tipsList.cast<String>();
    showRandomTip();
  }

  void showRandomTip() {
    final Random random = Random();
    randomIndex = random.nextInt(ecoTips.length);
    setState(() {
      currentTip = ecoTips[randomIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search city...',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
              onSubmitted: (value) {
                _searchTemperature(value);
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Trigger temperature search when the button is pressed
              _searchTemperature(_searchController.text);
            },
            child: const Text('Search'),
          ),
          if (weatherModel != null)
            Column(
              children: [
                const SizedBox(height: 30.0),
                Text(
                  '${weatherModel!.main?.temp}°C',
                  style: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  '${weatherModel!.name}',
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Feels like ${weatherModel!.main?.feelsLike}°C',
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60.0),

                // Add more details if needed

                // Add Card widget with text and button
                Card(
                  margin: const EdgeInsets.all(16.0),
                  elevation: 0,
                  color: Color.fromRGBO(237, 238, 234, 0.4),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          'keep your environment alive',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          currentTip,
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        ElevatedButton(
                          onPressed: () {
                            showRandomTip();
                            // Add button action here
                          },
                          child: const Text('Your tip!'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  void _searchTemperature(String city) async {
    try {
      final WeatherModel result = await Repo().getWeather(city);
      // defaultCity = city;
      setState(() {
        weatherModel = result;
        MyApp.defaultCity = city; // Set the searched city as the default one
      });
    } catch (e) {
      // Handle error, e.g., show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching weather data for $city'),
        ),
      );
    }
  }
}
