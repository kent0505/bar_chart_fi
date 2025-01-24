import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils.dart';
import '../../models/inc.dart';

part 'inc_event.dart';
part 'inc_state.dart';

class IncBloc extends Bloc<IncEvent, IncState> {
  IncBloc() : super(IncInitial()) {
    on<LoadInc>((event, emit) async {
      emit(IncLoading());
      await initHive();
      await getIncs();
      final prefs = await SharedPreferences.getInstance();
      tag = prefs.getInt('tag') ?? 0;
      await Future.delayed(
        Duration(seconds: 2),
        () {
          if (tag == 0) {
            emit(IncLoaded(incList: incList, tag: tag));
          } else {
            final sorted =
                incList.where((element) => element.tag == tag).toList();
            emit(IncLoaded(incList: sorted, tag: tag));
          }
        },
      );
    });

    on<UpdateInc>((event, emit) async {
      if (event.add) {
        incList.insert(0, event.inc);
      } else if (event.edit) {
        final inc = incList.firstWhere((element) => element.id == event.inc.id);
        inc.title = event.inc.title;
        inc.amount = event.inc.amount;
        inc.tag = event.inc.tag;
      } else if (event.delete) {
        incList.removeWhere((element) => element.id == event.inc.id);
      }
      await updateIncs();
      emit(IncLoaded(incList: incList, tag: tag));
    });

    on<SortInc>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      tag = event.tag;
      await prefs.setInt('tag', tag);
      if (tag == 0) {
        emit(IncLoaded(incList: incList, tag: tag));
      } else {
        final sorted = incList.where((element) => element.tag == tag).toList();
        emit(IncLoaded(incList: sorted, tag: tag));
      }
    });
  }
}
