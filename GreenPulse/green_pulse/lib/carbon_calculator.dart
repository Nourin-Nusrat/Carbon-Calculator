import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'transportation_screen.dart';
import 'food.dart';
import 'water.dart';
import 'electricity.dart';
import 'history_Page.dart';
import 'file_manager.dart';

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
          // _calculateTotalEmissions();
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
          // _calculateTotalEmissions();
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
          // _calculateTotalEmissions();
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
          // _calculateTotalEmissions();
        });
      },
    );
  }

  void _calculateTotalEmissions() async {
    double totalEmissions = transportationValue + foodValue + electricityValue + waterValue;
    String indexDateandTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    // String indexDateandTime = DateFormat('yyyy-MM-dd').format(DateTime.now());
    // String dateAndTime = DateFormat.yMd().add_jm().format(DateTime.now());
    String dateAndTime = DateFormat('MM-dd').format(DateTime.now());
    final entry = HistoryData(
      totalCarbon: totalEmissions,
      time: dateAndTime,
    );
    Map<String, dynamic> existingEntries = {};
    final Future<String> tmp = FileManager().readJsonFile();
    String jsonData = await tmp;
    existingEntries = json.decode(jsonData);
    existingEntries[indexDateandTime] = entry.toJson();
    FileManager().writeJsonFile(existingEntries);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carbon Calculator'),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Color.fromARGB(255, 4, 27, 6),
          fontSize: 24,
          fontWeight: FontWeight.bold,
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
              isTotal: true,
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
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to the history page
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HistoryPage(),
                ));
              },
              child: Text('View History'),
            ),
            ElevatedButton(
              onPressed: () {
                _calculateTotalEmissions();
              },
              child: Text('Save Data'),
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
                colors: [const Color.fromARGB(255, 255, 255, 255), color],
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

class HistoryData {
  final double totalCarbon;
  final String time;
  HistoryData({
    required this.totalCarbon,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      'totalCarbon': totalCarbon,
      'time': time,
    };
  }

  factory HistoryData.fromJson(Map<String, dynamic> json) {
    return HistoryData(
      totalCarbon: json['totalCarbon'],
      time: json['time'],
    );
  }
}
