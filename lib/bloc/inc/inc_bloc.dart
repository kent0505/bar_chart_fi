import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      await Future.delayed(
        Duration(seconds: 2),
        () {
          logger('LoadInc');
          emit(IncLoaded(incList: incList));
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
      emit(IncLoaded(incList: incList));
    });
  }
}
