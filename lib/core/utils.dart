import 'dart:developer' as developer;

import 'package:hive_flutter/hive_flutter.dart';

import '../models/inc.dart';

void logger(Object message) => developer.log(message.toString());

List<Inc> incList = [];

Future<void> initHive() async {
  await Hive.initFlutter();
  // await Hive.deleteBoxFromDisk('bar_chart_fi_box');
  Hive.registerAdapter(IncAdapter());
}

Future<void> getIncs() async {
  final box = await Hive.openBox('bar_chart_fi_box');
  List data = box.get('incs') ?? [];
  incList = data.cast<Inc>();
}

Future<void> updateIncs() async {
  final box = await Hive.openBox('bar_chart_fi_box');
  box.put('incs', incList);
  incList = await box.get('incs');
}

bool isToday(int timestamp) {
  final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  final now = DateTime.now();
  return date.year == now.year &&
      date.month == now.month &&
      date.day == now.day;
}
