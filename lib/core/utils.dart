import 'dart:developer' as developer;

import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

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

String getWeekday() {
  return DateFormat('E').format(DateTime.now());
}

double getIncomes() {
  return incList.fold(0, (amount, inc) {
    return inc.income ? amount + inc.amount : amount + 0;
  });
}

double getExpenses() {
  return incList.fold(0, (amount, inc) {
    return inc.income ? amount + 0 : amount + inc.amount;
  });
}

double getTodayAmount(bool income) {
  double incomes = 0;
  double expenses = 0;
  for (Inc inc in incList) {
    final date = DateTime.fromMillisecondsSinceEpoch(inc.id * 1000);
    final now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      inc.income ? incomes += inc.amount : expenses += inc.amount;
    }
  }
  return income ? incomes : expenses;
}

List<double> getCurrentWeekAmounts(bool income) {
  // final now = DateTime.now();
  // final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
  List<double> weeklyAmounts = List.filled(7, 10);
  // for (Inc inc in incList) {
  //   final date = DateTime.fromMillisecondsSinceEpoch(inc.id * 1000);
  //   if (date.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
  //       date.isBefore(startOfWeek.add(Duration(days: 7))) &&
  //       inc.income == income) {
  //     int dayIndex = date.difference(startOfWeek).inDays;
  //     weeklyAmounts[dayIndex] += inc.amount;
  //   }
  // }
  return weeklyAmounts;
}
