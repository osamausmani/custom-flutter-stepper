import 'package:flutter/material.dart';
import 'stepper_data.dart';





class CustomStepper extends StatelessWidget {

  final StepperData data;
  final IncrementCallback onButtonContinue;
  final DecrementCallback onButtonBack;

  final int currentStep;
  final int stepID;
  final int maxSteps;

  const CustomStepper({required this.onButtonContinue, required this.onButtonBack, super.key, required this.data, required this.currentStep, required this.stepID, required this.maxSteps });

  @override
  Widget build(BuildContext context) {
    debugPrint('movieTitle: $stepID $currentStep ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 8, right: 5),
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                  color: stepID <= currentStep ? Colors.blue : Colors.black45,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black26)),
              alignment: Alignment.center,
              // child: Text(stepID.toString(), textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 10)) ,
            child: stepID < currentStep ? const Icon(Icons.check,
                size: 10,
                color: Colors.white
            ) : Text(stepID.toString(), textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 10)) ,
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 0, right: 40, top: 5),
                  child:
                  Text(data.title, textAlign: TextAlign.left, style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
             Visibility(
                  visible: stepID == maxSteps? true : false,
                child:
                Container(
                  margin: const EdgeInsets.only(left: 0, right: 55, top: 5),
                  child:
                    const Text("Last Step  ", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black54, )),
                )
             )
              ],
            ),

          ],
        ),
        Container(
          margin: const EdgeInsets.only(left: 17, top: 5, bottom: 5),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: const BoxDecoration(
              border: Border(
                  left: BorderSide(
                    color: Colors.black26,
                  ))),

          child:
          Visibility(
            visible: currentStep == stepID ? true : false,
          child: Column(
              children: [
                Text(data.description),
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 0, top: 15, bottom: 0),
                        child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue, //Button Background Color
                        ),
                        onPressed: () {onButtonContinue();},
                        child: Text( stepID == maxSteps ? "FINISH" : "CONTINUE"),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 15, bottom: 0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                          foregroundColor: stepID == 1  ? Colors.black45 : Colors.blue
                        ),
                        onPressed: () { stepID == 1 ? "" : onButtonBack();},
                        child: const Text("BACK"),
                      ),
                    ),


                  ],
                ),
              ],
          ),
          )
        ),

      ],
    );
  }
}

typedef IncrementCallback = void Function();
typedef DecrementCallback = void Function();
