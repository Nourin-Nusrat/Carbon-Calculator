import 'package:flutter/material.dart';

class FoodScreen extends StatefulWidget {
  final void Function(double) updateValue;

  FoodScreen(this.updateValue);

  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  double calculatedResult = -1.0;
  TextEditingController foodConsumptionController = TextEditingController();

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
              'Food Consumption Calculator',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _buildInputFields(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputFields() {
    foodConsumptionController.clear(); // Clear the food consumption input

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Food Consumption Calculator',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text('Enter Food Consumption (grams per day):'),
              SizedBox(width: 16),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: foodConsumptionController,
                  decoration: InputDecoration(
                    hintText: 'Food Consumption',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              double foodConsumption =
                  double.tryParse(foodConsumptionController.text) ?? 0;
              double result = foodConsumption * 0.002; // Adjust the multiplier as needed
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
    );
  }
}
