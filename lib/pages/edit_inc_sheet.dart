import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/inc/inc_bloc.dart';
import '../core/colors.dart';
import '../models/inc.dart';
import '../widgets/button.dart';
import '../widgets/dialog_widget.dart';
import '../widgets/field_widget.dart';
import '../widgets/main_button.dart';
import '../widgets/tag.dart';

class EditIncSheet extends StatefulWidget {
  const EditIncSheet({super.key, required this.inc});

  final Inc inc;

  @override
  State<EditIncSheet> createState() => _EditIncSheetState();
}

class _EditIncSheetState extends State<EditIncSheet> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  int tag = 0;
  bool active = true;

  void onChanged() {
    setState(() {
      active = controller1.text.isNotEmpty &&
          controller2.text.isNotEmpty &&
          tag != 0;
    });
  }

  void onTag(int id) {
    id == tag ? tag = 0 : tag = id;
    onChanged();
  }

  void onEdit() {
    final inc = Inc(
      id: widget.inc.id,
      title: controller1.text,
      amount: double.tryParse(controller2.text) ?? 0,
      tag: tag,
      income: widget.inc.income,
    );
    context.read<IncBloc>().add(UpdateInc(inc: inc, edit: true));
    Navigator.pop(context);
  }

  void onDelete() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogWidget(
          title: 'Delete?',
          onYes: () {
            context
                .read<IncBloc>()
                .add(UpdateInc(inc: widget.inc, delete: true));
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    controller1.text = widget.inc.title;
    controller2.text = widget.inc.amount.toString();
    tag = widget.inc.tag;
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 250,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                Text(
                  widget.inc.income ? 'Income' : 'Expense',
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
                Text(
                  'Tags',
                  style: TextStyle(
                    color: Colors.black.withValues(alpha: 0.3),
                    fontSize: 18,
                    fontFamily: 'w600',
                  ),
                ),
                SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Tag(id: 1, tag: tag, onPressed: onTag),
                    Tag(id: 2, tag: tag, onPressed: onTag),
                    Tag(id: 3, tag: tag, onPressed: onTag),
                    Tag(id: 4, tag: tag, onPressed: onTag),
                    Tag(id: 5, tag: tag, onPressed: onTag),
                    Tag(id: 6, tag: tag, onPressed: onTag),
                    Tag(id: 7, tag: tag, onPressed: onTag),
                    Tag(id: 8, tag: tag, onPressed: onTag),
                  ],
                ),
                SizedBox(height: 20),
                MainButton(
                  title: 'Edit',
                  active: active,
                  onPressed: onEdit,
                ),
                SizedBox(height: 20),
                MainButton(
                  title: 'Delete',
                  color: redColor,
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: Button(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close_rounded,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
