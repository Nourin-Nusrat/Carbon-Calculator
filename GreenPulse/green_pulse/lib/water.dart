import 'package:flutter/material.dart';

class WaterScreen extends StatefulWidget {
  final void Function(double) updateValue;

  const WaterScreen(this.updateValue, {super.key});

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
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Water Calculator',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text('Enter Water Usage (litre):'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: usageController,
                    decoration: const InputDecoration(
                      hintText: 'Water Usage',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                double usage = double.tryParse(usageController.text) ?? 0;
                double result = usage * 0.2; // Modify the calculation here
                widget.updateValue(result);
                setState(() {
                  calculatedResult = result;
                });
              },
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 16),
            if (calculatedResult != -1.0)
              Text('Result: $calculatedResult!'),
          ],
        ),
      ),
    );
  }
}
