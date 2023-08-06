import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class TimeLineView extends StatefulWidget {
  @override
  TimeLineState createState() => TimeLineState();
}

class TimeLineState extends State<TimeLineView> with TickerProviderStateMixin {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Theme(
                data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                  primary: Colors.blue.shade900,
                )),
                child: Stepper(
                  currentStep: _index,
                  onStepCancel: () {
                    if (_index != 0) {
                      setState(() {
                        _index--;
                      });
                    }
                  },
                  onStepContinue: () {
                    if (_index != 2) {
                      setState(() {
                        _index++;
                      });
                    }
                  },
                  onStepTapped: (int index) {
                    setState(() {
                      _index = index;
                    });
                  },
                  steps: <Step>[
                    Step(
                      isActive: _index >= 0,
                      title: const Text('Step 1 title'),
                      content: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text('Content for Step 1'),
                      ),
                    ),
                    Step(
                      isActive: _index >= 1,
                      title: const Text('Step 2 title'),
                      content: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text('Content for Step 2'),
                      ),
                    ),
                    Step(
                      isActive: _index >= 2,
                      title: const Text('Step 3 title'),
                      content: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text('Content for Step 3'),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
