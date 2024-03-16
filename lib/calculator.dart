import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';
import 'calculator_button.dart';
import 'converter/converter_screen.dart';
import 'history/HistoryScreen.dart';
import 'package:calculator/history/database_helper.dart';


class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

DatabaseHelper dbHelper = DatabaseHelper();

class _CalculatorState extends State<Calculator> {
  String _expression = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (_expression.isNotEmpty &&
          _isOperator(buttonText) &&
          _isOperator(_expression[_expression.length - 1])) {
        return;
      }
      _expression += buttonText;
    });
  }

  void _onClearPressed() {
    setState(() {
      _expression = '';
    });
  }

  void _onEvaluatePressed() {
    try {
      Parser parser = Parser();
      Expression expression = parser.parse(_expression);
      ContextModel contextModel = ContextModel();
      double result = expression.evaluate(EvaluationType.REAL, contextModel);

      String timestamp = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());

      String calculation = '$_expression = $result';

      dbHelper.insertCalculation(calculation, timestamp);

      setState(() {
        _expression = result.toString();
      });
    } catch (e) {
      setState(() {
        _expression = 'Error';
      });
    }
  }



  bool _isOperator(String text) {
    return ['+', '-', '*', '/'].contains(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.black,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  _expression,
                  style: const TextStyle(color: Colors.white, fontSize: 50.0),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CalculatorButton(
                            text: '0',
                            onPressed: () => _onButtonPressed('0'),
                            textColor: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: CalculatorButton(
                            text: '.',
                            onPressed: () => _onButtonPressed('.'),
                            textColor: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: CalculatorButton(
                            text: '/',
                            onPressed: () => _onButtonPressed('/'),
                            backgroundColor: Colors.orange,
                            textColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: CalculatorButton(
                            text: '1',
                            onPressed: () => _onButtonPressed('1'),
                            textColor: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: CalculatorButton(
                            text: '2',
                            onPressed: () => _onButtonPressed('2'),
                            textColor: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: CalculatorButton(
                            text: '3',
                            onPressed: () => _onButtonPressed('3'),
                            textColor: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: CalculatorButton(
                            text: '+',
                            onPressed: () => _onButtonPressed('+'),
                            backgroundColor: Colors.orange,
                            textColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: CalculatorButton(
                            text: '4',
                            onPressed: () => _onButtonPressed('4'),
                            textColor: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: CalculatorButton(
                            text: '5',
                            onPressed: () => _onButtonPressed('5'),
                            textColor: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: CalculatorButton(
                            text: '6',
                            onPressed: () => _onButtonPressed('6'),
                            textColor: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: CalculatorButton(
                            text: '-',
                            onPressed: () => _onButtonPressed('-'),
                            backgroundColor: Colors.orange,
                            textColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: CalculatorButton(
                            text: '7',
                            onPressed: () => _onButtonPressed('7'),
                            textColor: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: CalculatorButton(
                            text: '8',
                            onPressed: () => _onButtonPressed('8'),
                            textColor: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: CalculatorButton(
                            text: '9',
                            onPressed: () => _onButtonPressed('9'),
                            textColor: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: CalculatorButton(
                            text: '*',
                            onPressed: () => _onButtonPressed('*'),
                            backgroundColor: Colors.orange,
                            textColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: CalculatorButton(
                            text: 'C',
                            onPressed: _onClearPressed,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: CalculatorButton(
                            text: '=',
                            onPressed: _onEvaluatePressed,
                            backgroundColor: Colors.orange, textColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ConverterScreen()),
                      );
                    },
                    child: const Text('Converter'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HistoryScreen()),
                      );
                    },
                    child: const Text('History'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}