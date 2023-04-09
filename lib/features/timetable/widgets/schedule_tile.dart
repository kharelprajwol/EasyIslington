import 'package:flutter/material.dart';

import '../models/schedule.dart';

class ScheduleTile extends StatelessWidget {
  final Schedule schedule;

  ScheduleTile({required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //const SizedBox(height: 4),
        ListTile(
          title: Text(schedule.courseName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(schedule.classType),
              const SizedBox(height: 4),
              Text('${schedule.classroom}, ${schedule.block}'),
              const SizedBox(height: 4),
              Text(schedule.instructorName),
            ],
          ),
          trailing: Transform.translate(
            offset: const Offset(0, 20), // move it down by 4 pixels
            child: Text(
              '${schedule.startTime} - ${schedule.endTime}',
            ),
          ),
        ),
      ],
    );
  }
}
