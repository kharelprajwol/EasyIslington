import 'package:easy_islington/features/timetable/widgets/schedule_tile.dart';
import 'package:flutter/material.dart';

import '../models/schedule.dart';

class ScheduleList extends StatelessWidget {
  final List<Schedule> schedules;
  final String weekday;

  ScheduleList({
    required this.schedules,
    required this.weekday,
  });

  @override
  Widget build(BuildContext context) {
    List<Schedule> filteredSchedules = schedules
        .where((schedule) => schedule.day.compareTo(weekday) == 0)
        .toList();

    if (filteredSchedules.isEmpty) {
      return Text('No classes today');
    }

    return ListView.separated(
      separatorBuilder: (context, index) => Divider(),
      shrinkWrap: true,
      itemCount: filteredSchedules.length,
      itemBuilder: (context, index) {
        return ScheduleTile(schedule: filteredSchedules[index]);
      },
    );
  }
}
