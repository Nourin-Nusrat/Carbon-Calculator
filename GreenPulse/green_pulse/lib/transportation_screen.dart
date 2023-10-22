import 'package:flutter/material.dart';

class TransportationScreen extends StatefulWidget {
  final void Function(double) updateValue;

  TransportationScreen(this.updateValue);

  @override
  _TransportationScreenState createState() => _TransportationScreenState();
}

class _TransportationScreenState extends State<TransportationScreen> {
  double calculatedResult = -1.0;
  String selectedMode = '';
  String selectedFuelType = 'Petrol';
  TextEditingController distanceController = TextEditingController();

  final List<String> transportationModes = [
    'Car',
    'Train',
    'Bus',
    'Motorbike',
    'Plane'
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transportation Calculator',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text('Choose a mode of transportation:'),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _buildTransportCards(context),
              ),
            ),
            SizedBox(height: 16),
            if (selectedMode.isNotEmpty) _buildInputFields(selectedMode),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTransportCards(BuildContext context) {
    return transportationModes.map((mode) {
      return GestureDetector(
        onTap: () {
          setState(() {
            selectedMode = mode;
            calculatedResult = -1.0;
          });
        },
        child: Container(
          width: 100,
          child: Card(
            color: mode == selectedMode
                ? Color.fromARGB(255, 209, 99, 35)
                : Colors.orange.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.directions_car, color: Colors.white, size: 36.0),
                Text(
                  mode,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildInputFields(String mode) {
    distanceController.clear(); // Clear the distance input
    // calculatedResult = -1.0;
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$mode Transportation Calculator',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          if (mode == 'Car')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Enter Distance (miles):'),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: distanceController,
                        decoration: InputDecoration(
                          hintText: 'Distance',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // ElevatedButton(
                //   onPressed: () {
                //     double distance = double.parse(distanceController.text);
                //     double result = distance * 0.005;
                //     widget.updateValue(result);
                //     Navigator.of(context).pop();
                //   },
                //   child: Text('Calculate'),

                // ),
                ElevatedButton(
                  onPressed: () {
                    double distance =
                        double.tryParse(distanceController.text) ?? 0;
                    double result = distance * 0.005;
                    widget.updateValue(result);
                    setState(() {
                      calculatedResult = result;
                    });
                  },
                  child: Text('Calculate'),
                ),
                SizedBox(height: 16),
                if (calculatedResult != -1.0)
                  Text('Result: $calculatedResult!'),
              ],
            ),
          if (mode == 'Train')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Enter Distance (miles):'),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: distanceController,
                        decoration: InputDecoration(
                          hintText: 'Distance',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    double distance =
                        double.tryParse(distanceController.text) ?? 0;
                    double result = distance * 0.01;
                    widget.updateValue(result);
                    setState(() {
                      calculatedResult = result;
                    });
                  },
                  child: Text('Calculate'),
                ),
                SizedBox(height: 16),
                if (calculatedResult != -1.0)
                  Text('Result: $calculatedResult!'),
              ],
            ),
          if (mode == 'Bus')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Enter Distance (miles):'),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: distanceController,
                        decoration: InputDecoration(
                          hintText: 'Distance',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    double distance =
                        double.tryParse(distanceController.text) ?? 0;
                    double result = distance * 0.05;
                    widget.updateValue(result);
                    setState(() {
                      calculatedResult = result;
                    });
                  },
                  child: Text('Calculate'),
                ),
                SizedBox(height: 16),
                if (calculatedResult != -1.0)
                  Text('Result: $calculatedResult!'),
              ],
            ),
        ],
      ),
    );
  }
}
