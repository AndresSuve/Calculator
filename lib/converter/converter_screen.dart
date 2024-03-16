import 'package:flutter/material.dart';

class ConverterScreen extends StatelessWidget {
  const ConverterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A kilometer to mile'),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: const ConverterBody(),
      backgroundColor: Colors.white,
    );
  }
}

class ConverterBody extends StatefulWidget {
  const ConverterBody({super.key});

  @override
  _ConverterBodyState createState() => _ConverterBodyState();
}

class _ConverterBodyState extends State<ConverterBody> {
  final TextEditingController _kilometerController = TextEditingController();
  final TextEditingController _mileController = TextEditingController();

  void _convertKilometerToMile() {
    double kilometer = double.tryParse(_kilometerController.text) ?? 0;
    double mile = kilometer * 0.621371;
    setState(() {
      _mileController.text = mile.toStringAsFixed(2);
    });
  }

  void _clearFields() {
    setState(() {
      _kilometerController.clear();
      _mileController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.orange),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextField(
              controller: _kilometerController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Kilometer',
                contentPadding: EdgeInsets.all(10.0),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.orange),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextField(
              controller: _mileController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Mile',
                contentPadding: EdgeInsets.all(10.0),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _convertKilometerToMile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                child: const Text('Convert'),
              ),
              ElevatedButton(
                onPressed: _clearFields,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                child: const Text('Clear'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
