import 'package:flutter/material.dart';
import 'dart:convert';
// import 'dart:io';
import 'file_manager.dart';



class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<HistoryData> historyData = [];

  @override
  void initState() {
    super.initState();
    loadHistoryData();
  }

  Future<void> loadHistoryData() async {
      final Future<String> tmp = FileManager().readJsonFile();
      String jsonData = await tmp;
      final jsonMap = json.decode(jsonData) as Map<String, dynamic>;
      historyData = jsonMap.entries
          .map((entry) => HistoryData.fromJson(entry.value as Map<String, dynamic>))
          .toList();

      setState(() {});
  }

  Future<void> deleteEntry(int index) async {
    // Remove the entry from the list
    if (index >= 0 && index < historyData.length) {
      historyData.removeAt(index);

      // Save the updated list to the JSON file
      await saveHistoryData();

      // Trigger a rebuild to reflect the changes
      setState(() {});
    }
  }

  Future<void> saveHistoryData() async {
    final jsonMap = {
      for (var i = 0; i < historyData.length; i++)
        '$i': historyData[i].toJson(),
    };
    FileManager().writeJsonFile(jsonMap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: Colors.grey[600],
      ),
      body: ListView.builder(
        itemCount: historyData.length,
        itemBuilder: (context, index) {
          final entry = historyData[historyData.length - 1 - index];
          return Card(
            // set color for each card to ash
            color: Colors.grey[200],
            elevation: 3,
            margin: const EdgeInsets.all(8),
            child: ListTile(

              // title: Text('Total Footprint: ${entry.totalFootprint.toString()}'),
              // make title size 20 and bold
              title: Text(
                'Total Footprint (kgCO2e): ${entry.totalCarbon.toStringAsFixed(2)} ',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('Timestamp: ${entry.time}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () => deleteEntry(index),
              ),
            ),
          );
        },
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