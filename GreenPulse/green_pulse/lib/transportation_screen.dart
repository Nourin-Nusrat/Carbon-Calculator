import 'package:flutter/material.dart';

class TransportationScreen extends StatefulWidget {
  final void Function(double) updateValue;

  const TransportationScreen(this.updateValue, {super.key});

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
              'Transportation Calculator',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text('Choose a mode of transportation:'),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _buildTransportCards(context),
              ),
            ),
            const SizedBox(height: 16),
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
        child: SizedBox(
          width: 100,
          child: Card(
            color: mode == selectedMode
                ? const Color.fromARGB(255, 209, 99, 35)
                : Colors.orange.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.directions_car, color: Colors.white, size: 36.0),
                Text(
                  mode,
                  style: const TextStyle(
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$mode Transportation Calculator',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          if (mode == 'Car')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Distance (Km):'),
                    const SizedBox(width: 1),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: distanceController,
                        decoration: const InputDecoration(
                          hintText: 'Distance',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16), // Add some spacing
                    ElevatedButton(
                      onPressed: () {
                        double distance = double.tryParse(distanceController.text) ?? 0;
                        double result = distance * 0.0227;
                        widget.updateValue(result);
                        setState(() {
                          calculatedResult = result;
                        });
                      },
                      child: const Text('Calculate'),
                    ),
                  ],
                ),
                const SizedBox(height: 1),
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
                    const Text('Distance (Km):'),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: distanceController,
                        decoration: const InputDecoration(
                          hintText: 'Distance',
                        ),
                      ),
                    ),
                    const SizedBox(width: 1), // Add some spacing
                    ElevatedButton(
                      onPressed: () {
                        double distance = double.tryParse(distanceController.text) ?? 0;
                        double result = distance * 0.04;
                        widget.updateValue(result);
                        setState(() {
                          calculatedResult = result;
                        });
                      },
                      child: const Text('Calculate'),
                    ),
                  ],
                ),
                const SizedBox(height: 1),
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
                    const Text('Distance (Km):'),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: distanceController,
                        decoration: const InputDecoration(
                          hintText: 'Distance',
                        ),
                      ),
                    ),
                    const SizedBox(width: 1), // Add some spacing
                    ElevatedButton(
                      onPressed: () {
                        double distance = double.tryParse(distanceController.text) ?? 0;
                        double result = distance * 0.02;
                        widget.updateValue(result);
                        setState(() {
                          calculatedResult = result;
                        });
                      },
                      child: const Text('Calculate'),
                    ),
                  ],
                ),
                const SizedBox(height: 1),
                if (calculatedResult != -1.0)
                  Text('Result: $calculatedResult!'),
              ],
            ),
            if (mode == 'Motorbike')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Distance (Km):'),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: distanceController,
                        decoration: const InputDecoration(
                          hintText: 'Distance',
                        ),
                      ),
                    ),
                    const SizedBox(width: 1), // Add some spacing
                    ElevatedButton(
                      onPressed: () {
                        double distance = double.tryParse(distanceController.text) ?? 0;
                        double result = distance * 0.01;
                        widget.updateValue(result);
                        setState(() {
                          calculatedResult = result;
                        });
                      },
                      child: const Text('Calculate'),
                    ),
                  ],
                ),
                const SizedBox(height: 1),
                if (calculatedResult != -1.0)
                  Text('Result: $calculatedResult!'),
              ],
            ),
            if (mode == 'Plane')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Distance (Km):'),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: distanceController,
                        decoration: const InputDecoration(
                          hintText: 'Distance',
                        ),
                      ),
                    ),
                    const SizedBox(width: 1), // Add some spacing
                    ElevatedButton(
                      onPressed: () {
                        double distance = double.tryParse(distanceController.text) ?? 0;
                        double result = distance * 0.1;
                        widget.updateValue(result);
                        setState(() {
                          calculatedResult = result;
                        });
                      },
                      child: const Text('Calculate'),
                    ),
                  ],
                ),
                const SizedBox(height: 1),
                if (calculatedResult != -1.0)
                  Text('Result: $calculatedResult!'),
              ],
            ),
            
        ],
      ),
    );
  }
}
