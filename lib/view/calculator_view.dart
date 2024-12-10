import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


void main() => runApp(const CalculatorApp());

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator App',
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = "";
  String _input = "";

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        _display = "";
        _input = "";
      } else if (value == "<-") {
        _input = _input.isNotEmpty ? _input.substring(0, _input.length - 1) : "";
      } else if (value == "=") {
        try {
          Parser parser = Parser();
          Expression expression = parser.parse(_input);
          ContextModel contextModel = ContextModel();
          _display = expression.evaluate(EvaluationType.REAL, contextModel).toString();
        } catch (e) {
          _display = "Error";
        }
      } else {
        _input += value;
      }
    });
  }

  Widget _buildButton(String text, Color color) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _onButtonPressed(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.all(20),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator App'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Colors.grey[200],
              child: Text(
                _input.isEmpty ? "0" : _input,
                style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Colors.white,
              child: Text(
                _display,
                style: const TextStyle(fontSize: 24, color: Colors.black),
              ),
            ),
          ),
          const Divider(height: 1),
          Column(
            children: [
              Row(
                children: [
                  _buildButton("C", Colors.white),
                  _buildButton("*", Colors.white),
                  _buildButton("/", Colors.white),
                  _buildButton("<-", Colors.white),
                ],
              ),
              Row(
                children: [
                  _buildButton("7", Colors.white),
                  _buildButton("8", Colors.white),
                  _buildButton("9", Colors.white),
                  _buildButton("+", Colors.white),
                ],
              ),
              Row(
                children: [
                  _buildButton("4", Colors.white),
                  _buildButton("5", Colors.white),
                  _buildButton("6", Colors.white),
                  _buildButton("-", Colors.white),
                ],
              ),
              Row(
                children: [
                  _buildButton("1", Colors.white),
                  _buildButton("2", Colors.white),
                  _buildButton("3", Colors.white),
                  _buildButton("*", Colors.white),
                ],
              ),
              Row(
                children: [
                  _buildButton("%", Colors.white),
                  _buildButton("0", Colors.white),
                  _buildButton(".", Colors.white),
                  _buildButton("=", Colors.white),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
