import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Reais para Dólares'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final amountReaisInput = TextEditingController();
  final dollarQuoteInput = TextEditingController();
  String answer = "";

  clear() {
    amountReaisInput.clear();
    dollarQuoteInput.clear();
    answer = "";
  }

  tryToCalculate() {
    try {
      final moneyInReais = double.parse(amountReaisInput.text);
      final dollarQuote = double.parse(dollarQuoteInput.text);
      final totalDollars = moneyInReais / dollarQuote;

      setState(() {
        answer =
            '''Com $moneyInReais reais é possível comprar ${totalDollars.toStringAsFixed(2)} dólares a $dollarQuote cada''';
        debugPrint(answer);
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          width: 500,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.attach_money,
                  size: 120,
                  color: Colors.black54,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: amountReaisInput,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Quantidade em Reais'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: dollarQuoteInput,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Cotação do Dólar'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8, left: 8),
                      child: RaisedButton(
                        child: Text('Limpar'),
                        onPressed: () => setState(clear),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: RaisedButton(
                        child: Text('Calcular',),
                        onPressed: () => tryToCalculate(),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.all(8),
                child: Text(
                  answer,
                  style: TextStyle(fontSize: 40),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
