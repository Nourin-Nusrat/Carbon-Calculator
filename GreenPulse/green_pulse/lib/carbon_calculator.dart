import 'package:flutter/material.dart';
import 'transportation_screen.dart';
import 'food.dart';
import 'water.dart';
import 'electricity.dart';

class CarbonCalculatorPage extends StatefulWidget {
  @override
  _CarbonCalculatorPageState createState() => _CarbonCalculatorPageState();
}

class _CarbonCalculatorPageState extends State<CarbonCalculatorPage> {
  double transportationValue = 0.0;
  double foodValue = 0.0;
  double electricityValue = 0.0;
  double waterValue = 0.0;

  void _showTransportationCalculator(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return TransportationScreen((value) {
          setState(() {
            transportationValue = value;
          });
        });
      },
    );
  }

  void _showFoodCalculator(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FoodScreen((value) {
          setState(() {
            foodValue = value;
          });
        });
      },
    );
  }

  void _showElectricityCalculator(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return ElectricityScreen((value) {
          setState(() {
            electricityValue = value;
          });
        });
      },
    );
  }

  void _showWaterCalculator(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return WaterScreen((value) {
          setState(() {
            waterValue = value;
          });
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Carbon Calculator'),
      //   backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      // ),
      appBar: AppBar(
        title: Text('Carbon Calculator'),
        // backgroundColor: const Color(0xFF6CCEFF), // Background color
        centerTitle: true, // Center the title
        titleTextStyle: TextStyle(
          color: Color.fromARGB(255, 4, 27, 6), // Title text color
          fontSize: 24, // Title font size
          fontWeight: FontWeight.bold, // Title font weight
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCard(
              title: 'Total Carbon Emissions',
              subtitle: 'The total carbon emissions across all categories',
              value: transportationValue +
                  foodValue +
                  electricityValue +
                  waterValue,
              color: Color.fromARGB(255, 168, 68, 9),
              isTotal: true, // Add a parameter to identify the total card
            ),
            _buildCard(
              title: 'Transportation',
              subtitle: 'Calculate carbon emissions for transportation',
              value: transportationValue,
              onTap: () {
                _showTransportationCalculator(context);
              },
              color: Color.fromARGB(255, 56, 90, 2),
            ),
            _buildCard(
              title: 'Food',
              subtitle: 'Calculate carbon emissions for food consumption',
              value: foodValue,
              onTap: () {
                _showFoodCalculator(context);
              },
              color: Color.fromARGB(255, 56, 90, 2),
            ),
            _buildCard(
              title: 'Electricity',
              subtitle: 'Calculate carbon emissions for electricity usage',
              value: electricityValue,
              onTap: () {
                _showElectricityCalculator(context);
              },
              color: Color.fromARGB(255, 56, 90, 2),
            ),
            _buildCard(
              title: 'Water',
              subtitle: 'Calculate carbon emissions for water usage',
              value: waterValue,
              onTap: () {
                _showWaterCalculator(context);
              },
              color: Color.fromARGB(255, 56, 90, 2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String subtitle,
    required double value,
    VoidCallback? onTap,
    Color color = Colors.blue,
    bool isTotal = false,
  }) {
    return isTotal
        ? Container(
            height: 200,
            width: 200,
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [color, color],
                center: Alignment.center,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 121, 122, 120).withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total Carbon ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '$value',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, color],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            margin: EdgeInsets.all(16),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(
                  title,
                  style: TextStyle(
                    fontFamily: AutofillHints.birthdayDay,
                    color: Color.fromARGB(255, 42, 80, 6),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  subtitle,
                  style: TextStyle(
                    color: Color.fromARGB(255, 114, 52, 23),
                    fontSize: 13,
                  ),
                ),
                trailing: Text(
                  ' $value',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
                onTap: onTap,
              ),
            ),
          );
  }
}
