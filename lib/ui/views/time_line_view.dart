import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class TimeLineView extends StatelessWidget {
  const TimeLineView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Card(
          child: SizedBox(
        height: 50.0,
        child: TimelineNode.simple(),
      )),
    );
  }
}
