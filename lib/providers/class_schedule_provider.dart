import 'package:easy_islington/features/class_schedule/models/class_schedule.dart';
import 'package:flutter/material.dart';

class ClassScheduleProvider extends ChangeNotifier {
  Schedule _schedule = Schedule(
    id: '',
    day: '',
    courseName: '',
    instructorName: '',
    block: '',
    classroom: '',
    classType: '',
    startTime: '',
    endTime: '',
  );

  ClassScheduleProvider() {
    _schedules = <Schedule>[];
  }

  List<Schedule> _schedules = <Schedule>[];

  Schedule get schedule => _schedule;

  List<Schedule> get schedules => _schedules;

  void setSchedule(String schedule) {
    _schedule = Schedule.fromJson(schedule);
    notifyListeners();
  }

  void setScheduleFromModel(Schedule schedule) {
    _schedule = schedule;
    notifyListeners();
  }

  void addSchedule(Schedule schedule) {
    _schedules.add(schedule);
    notifyListeners();
  }

  void addSchedules(List<Schedule> schedules) {
    for (Schedule schedule in schedules) {
      _schedules.add(schedule);
    }
    notifyListeners();
  }

  void clearSchedules() {
    _schedules.clear();
    notifyListeners();
  }
}
