import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_app/stepper_data.dart';
import 'custom_stepper.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});




  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Stepper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
          title: 'Custom Stepper',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {


  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();



}

class _MyHomePageState extends State<MyHomePage> {

  List<StepperData> sData = <StepperData>[] ;
  static const platform = MethodChannel('samples.flutter.dev/battery');

  bool isStepperLoaded = false;

  Future<void> _getStepperData() async {
    isStepperLoaded = true;

    try {

      final result = await platform.invokeMethod('getStepperData');
      var json = jsonDecode(result);
      List<dynamic> items = json;
      var i = 0;
      items.forEach((item) {
        i++;
        var data = StepperData(item["title"], item["description"], i );
        sData.add(data);
      });

      _maxSteps = sData.length;
      print("StepperCalled");

      print(sData.length.toString());

    } on PlatformException catch (e) {

    }


  }


  int _currentStep = 0;
  int _maxSteps = 3;

  void _incrementStep() {
    isStepperLoaded ? "" : _getStepperData() ;

    print("CurrentStep" + _currentStep.toString());

    setState(() {
      _currentStep++;
    });
  }

  void _decrementStep() {
    setState(() {
      _currentStep--;
    });
  }

  @override
  Widget build(BuildContext context) {




    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[

            if (_currentStep == 0) TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue, //Button Background Color
              ),
              onPressed: () {_incrementStep();},
              child: const Text("Start Stepper"),
            )

             else if (_currentStep !=0 && _currentStep !=4 ) Column(

                children: [
                  for(var item in sData ) CustomStepper( stepID:item.id, onButtonContinue:  _incrementStep, onButtonBack: _decrementStep, currentStep: _currentStep, maxSteps: _maxSteps, data: StepperData(item.title, item.description, item.id)),



                ],
              )

            else if (_currentStep == 4) const Text("Yaay! Stepper Completed")
            else
              const Text("")

          ],

        ),
      ),

    );
  }
}
