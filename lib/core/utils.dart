import 'dart:developer' as developer;

import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../models/inc.dart';

void logger(Object message) => developer.log(message.toString());

List<Inc> incList = [];
int tag = 0;

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
  DateTime now = DateTime.now();
  DateTime monday = now.subtract(Duration(days: now.weekday - 1));
  DateTime nextMonday = monday.add(Duration(days: 7));
  List<Inc> models = incList.where((model) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(model.id * 1000);
    return date.isAfter(monday) && date.isBefore(nextMonday);
  }).toList();
  List<double> incomeAmounts = List.generate(7, (_) => 0.0);
  List<double> expenseAmounts = List.generate(7, (_) => 0.0);
  for (Inc model in models) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(model.id * 1000);
    int weekdayIndex = date.weekday - 1;
    model.income
        ? incomeAmounts[weekdayIndex] += model.amount
        : expenseAmounts[weekdayIndex] += model.amount;
  }
  return income ? incomeAmounts : expenseAmounts;
}

List<double> getCurrentMonthAmounts(bool income) {
  DateTime now = DateTime.now();
  DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
  DateTime startOfFirstWeek = firstDayOfMonth.subtract(
    Duration(days: firstDayOfMonth.weekday - 1),
  );
  List<double> weeklyAmounts = List.generate(4, (_) => 0.0);
  List<Inc> models = incList.where((model) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(model.id * 1000);
    return date.year == now.year && date.month == now.month;
  }).toList();
  for (Inc model in models) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(model.id * 1000);
    int weekIndex = ((date.difference(startOfFirstWeek).inDays) / 7).floor();
    if (weekIndex >= 0 && weekIndex < 4) {
      if (model.income == income) {
        weeklyAmounts[weekIndex] += model.amount;
      }
    }
  }
  return weeklyAmounts;
}
