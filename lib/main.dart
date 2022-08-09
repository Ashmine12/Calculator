import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String equation = '0';
  String result = "0";
  String expression = "";
  double equationFontSize = 38;
  double resultFontSize = 48;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        equation = "0";
        result = "0";
        equationFontSize = 38;
        resultFontSize = 48;
      } else if (buttonText == "<=") {
        equationFontSize = 38;
        resultFontSize = 48;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38;
        resultFontSize = 48;

        expression = equation;
        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 38;
        resultFontSize = 48;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  buildbutton(String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(
              color: Colors.white, width: 1, style: BorderStyle.solid),
        ),
        padding: EdgeInsets.all(16),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildbutton('C', 1, Colors.redAccent),
                        buildbutton('<=', 1, Colors.blue),
                        buildbutton('/', 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildbutton('7', 1, Colors.black12),
                        buildbutton('8', 1, Colors.black12),
                        buildbutton('9', 1, Colors.black12),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildbutton('4', 1, Colors.black12),
                        buildbutton('5', 1, Colors.black12),
                        buildbutton('6', 1, Colors.black12),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildbutton('1', 1, Colors.black12),
                        buildbutton('2', 1, Colors.black12),
                        buildbutton('3', 1, Colors.black12),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildbutton('.', 1, Colors.black12),
                        buildbutton('0', 1, Colors.black12),
                        buildbutton('00', 1, Colors.black12),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildbutton('*', 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildbutton('+', 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildbutton('-', 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildbutton('=', 2, Colors.blue),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
