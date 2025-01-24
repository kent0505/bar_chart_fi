import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/inc/inc_bloc.dart';
import '../core/colors.dart';
import '../widgets/button.dart';
import '../widgets/sheet_widget.dart';

class SortSheet extends StatelessWidget {
  const SortSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SheetWidget(
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(
            'Sort',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'w700',
            ),
          ),
          SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Sort(0),
              _Sort(1),
              _Sort(2),
              _Sort(3),
              _Sort(4),
              _Sort(5),
              _Sort(6),
              _Sort(7),
              _Sort(8),
            ],
          ),
        ],
      ),
    );
  }
}

class _Sort extends StatelessWidget {
  const _Sort(this.tag);

  final int tag;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 50,
      child: Button(
        onPressed: () {
          context.read<IncBloc>().add(SortInc(tag: tag));
          // Navigator.pop(context);
        },
        minSize: 40,
        child: BlocBuilder<IncBloc, IncState>(
          builder: (context, state) {
            if (state is IncLoaded) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 200),
                height: tag == state.tag ? 50 : 40,
                width: tag == state.tag ? 50 : 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: getColor(tag),
                ),
                child: tag == 0
                    ? Center(
                        child: Text(
                          'All',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'w700',
                          ),
                        ),
                      )
                    : tag == state.tag
                        ? Center(
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : null,
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
