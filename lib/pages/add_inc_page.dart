import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bottom/bottom_bloc.dart';
import '../bloc/inc/inc_bloc.dart';
import '../models/inc.dart';
import '../widgets/field_widget.dart';
import '../widgets/main_button.dart';

class AddIncPage extends StatefulWidget {
  const AddIncPage({super.key, required this.income});

  final bool income;

  @override
  State<AddIncPage> createState() => _AddIncPageState();
}

class _AddIncPageState extends State<AddIncPage> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();

  void onChanged() {
    setState(() {});
  }

  void onAdd() {
    final inc = Inc(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000 - 86400,
      title: controller1.text,
      amount: double.tryParse(controller2.text) ?? 0,
      income: widget.income,
    );
    context.read<IncBloc>().add(UpdateInc(inc: inc, add: true));
    context.read<BottomBloc>().add(SwitchBottom(bottom: 1));
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        SizedBox(
          height: MediaQuery.of(context).viewPadding.top,
        ),
        Text(
          widget.income ? 'Income' : 'Expense',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'w700',
          ),
        ),
        SizedBox(height: 20),
        FieldWidget(
          controller: controller1,
          hintText: 'Title',
          onChanged: onChanged,
        ),
        SizedBox(height: 20),
        FieldWidget(
          controller: controller2,
          hintText: 'Amount',
          number: true,
          onChanged: onChanged,
        ),
        SizedBox(height: 20),
        MainButton(
          title: 'Add',
          active: controller1.text.isNotEmpty && controller2.text.isNotEmpty,
          onPressed: onAdd,
        ),
      ],
    );
  }
}
