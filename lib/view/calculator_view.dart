import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final _textController = TextEditingController();
  List<String> lstSymbols = [
    "C",
    "*",
    "/",
    "<-",
    "1",
    "2",
    "3",
    "+",
    "4",
    "5",
    "6",
    "-",
    "7",
    "8",
    "9",
    "*",
    "%",
    "0",
    ".",
    "=",
  ];

  double? first;
  double? second;
  String? operator;

  void onSymbolTap(String symbol) {
    setState(() {
      if (symbol == "C") {
        _textController.clear();
        first = null;
        second = null;
        operator = null;
      } else if (symbol == "<-") {
        if (_textController.text.isNotEmpty) {
          _textController.text = _textController.text
              .substring(0, _textController.text.length - 1);
        }
      } else if (symbol == "=") {
        if (first != null &&
            operator != null &&
            _textController.text.isNotEmpty) {
          second = double.tryParse(_textController.text);
          double? result;
          switch (operator) {
            case "+":
              result = first! + second!;
              break;
            case "-":
              result = first! - second!;
              break;
            case "*":
              result = first! * second!;
              break;
            case "/":
              result = second != 0 ? first! / second! : double.nan;
              break;
            case "%":
              result = first! % second!;
              break;
          }
          _textController.text = result?.toString() ?? "Error";
          first = null;
          second = null;
          operator = null;
        }
      } else if ("+-*/%".contains(symbol)) {
        if (_textController.text.isNotEmpty) {
          first = double.tryParse(_textController.text);
          operator = symbol;
          _textController.clear();
        }
      } else {
        _textController.text += symbol;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _textController,
              readOnly: true,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: lstSymbols.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => onSymbolTap(lstSymbols[index]),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          lstSymbols[index],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
