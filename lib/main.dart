// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  
  
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<String> _measure = [
    'metros',
    'kilometros',
    'gramos',
    'kilogramos',
    'pies',
    'millas',
    'onzas',
    
  ];
  late String _startM;
  late String _endM;

  late String endValue = "0";

  late int _startI;
  late int _endI;

  final _formulas = [
    [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    [0, 0, 1, 0.0001, 0, 0, 0, 0022, 0.035274],
    [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    [0, 0, 28.3495, 0, 02835, 3.28084, 0, 0.0625, 1],
  ];

  final valueController = TextEditingController();


  @override
  void initState() {

    this._startI = 0;
    this._endI = 1;

    this._startM = this._measure[this._startI];
    this._endM = this._measure[this._endI];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final labelStyle = TextStyle(color: Colors.blueAccent, fontSize: 18);
    final measureStyle = TextStyle(color: Colors.purple, fontSize: 18);

     return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Medidor app 2"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          child: Column(
            children: [
              Text("Valor", style: labelStyle),
              SizedBox(height: 8,
              ),
             TextField(
               controller: valueController,
               decoration: InputDecoration(
                 hintText: "Valor inicial", 
                 contentPadding: EdgeInsets.all(8),),
                
              ),
              SizedBox(height: 8,
              ),
              Text("De", style: labelStyle),
              SizedBox(height: 8,
              ),
              DropdownButton<String>(
                isExpanded: true,
                value: _startM,
                items : _measure.map((m){
                return DropdownMenuItem<String>(
                  value: m,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(m, style:measureStyle),
                  ));
              }).toList(), 
              onChanged: (value){
                
                
                setState(() {
                  _startM = value!;
                  _startI = _measure.indexOf(_startM);
                  
                });
                }),
              SizedBox(height: 8,
              ),
              Text("Para", style: labelStyle),
              SizedBox(height: 8,
              ),
              DropdownButton<String>(
                value: _endM,
                isExpanded: true,
                items : _measure.map((m){
                return DropdownMenuItem<String>(
                  value: m,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(m, style:measureStyle),
                  ));
              }).toList(), 
              onChanged: (value){
                setState(() {
                  _endM = value!;
                  _endI = _measure.indexOf(_endM);
                });
               }),
               SizedBox(height: 8,
              ),
              ElevatedButton(
                onPressed: (){
                  
                  try {
                    final value = double.parse(valueController.text.trim());
                    setState(() {
                      
                      this.endValue = "${value * _formulas[_startI][_endI]}";
                    });

                    FocusScope.of(context).requestFocus(FocusNode());
                  } catch (e) {
                    print("Problemas con la conversion");
                  }
                }, 
                child: Text("Convertir"),),
               //Spacer(),
                SizedBox(height: 20,
              ),
              Text("res: $endValue", style: labelStyle),
            ],
      
        ),
        ),
      ),
      ),
      );
  }
}



