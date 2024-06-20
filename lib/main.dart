import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "DEL") {
      _output = _output.substring(0, _output.length - 1);
      if (_output.isEmpty) {
        _output = "0";
      }
    } else if (buttonText == "C") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+/-") {
      if (_output.startsWith("-")) {
        _output = _output.substring(1);
      } else {
        _output = "-" + _output;
      }
    } else if (buttonText == "%") {
      num1 = double.parse(_output.replaceAll("-", ""));
      if (_output.startsWith("-")) {
        num1 = -num1;
      }
      _output = (num1 / 100).toString();
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "×" ||
        buttonText == "÷") {
      num1 = double.parse(_output.replaceAll("-", ""));
      if (_output.startsWith("-")) {
        num1 = -num1;
      }
      operand = buttonText;
      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(_output.replaceAll("-", ""));
      if (_output.startsWith("-")) {
        num2 = -num2;
      }

      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "×") {
        _output = (num1 * num2).toString();
      }
      if (operand == "÷") {
        _output = (num1 / num2).toString();
      }

      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      _output = _output + buttonText;
    }

    setState(() {
      output = double.parse(_output.replaceAll("-", "")).toStringAsFixed(2);
      if (_output.startsWith("-")) {
        output = "-" + output;
      }
    });
  }

  Widget buildButton(String buttonText, Color color, Color textColor) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.all(20.0),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          onPressed: () => buttonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      output,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                buildButton("C", Colors.grey, Colors.black),
                buildButton("+/-", Colors.grey, Colors.black),
                buildButton("%", Colors.grey, Colors.black),
                buildButton("÷", Colors.orange, Colors.white),
              ],
            ),
            Row(
              children: [
                buildButton("7", Colors.grey[850]!, Colors.white),
                buildButton("8", Colors.grey[850]!, Colors.white),
                buildButton("9", Colors.grey[850]!, Colors.white),
                buildButton("×", Colors.orange, Colors.white),
              ],
            ),
            Row(
              children: [
                buildButton("4", Colors.grey[850]!, Colors.white),
                buildButton("5", Colors.grey[850]!, Colors.white),
                buildButton("6", Colors.grey[850]!, Colors.white),
                buildButton("-", Colors.orange, Colors.white),
              ],
            ),
            Row(
              children: [
                buildButton("1", Colors.grey[850]!, Colors.white),
                buildButton("2", Colors.grey[850]!, Colors.white),
                buildButton("3", Colors.grey[850]!, Colors.white),
                buildButton("+", Colors.orange, Colors.white),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: buildButton("0", Colors.grey[850]!, Colors.white),
                ),
                buildButton(".", Colors.grey[850]!, Colors.white),
                buildButton("=", Colors.orange, Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
