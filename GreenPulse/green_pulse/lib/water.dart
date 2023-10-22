import 'package:flutter/material.dart';

class WaterScreen extends StatefulWidget {
  final void Function(double) updateValue;

  WaterScreen(this.updateValue);

  @override
  _WaterScreenState createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  double calculatedResult = -1.0;
  TextEditingController usageController = TextEditingController();

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
              'Water Calculator',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text('Enter Water Usage (gallons):'),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: usageController,
                    decoration: InputDecoration(
                      hintText: 'Water Usage',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                double usage = double.tryParse(usageController.text) ?? 0;
                double result = usage * 0.01; // Modify the calculation here
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
      ),
    );
  }
}
