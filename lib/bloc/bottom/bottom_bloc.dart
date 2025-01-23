import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_event.dart';
part 'bottom_state.dart';

class BottomBloc extends Bloc<BottomEvent, BottomState> {
  BottomBloc() : super(BottomInitial()) {
    on<SwitchBottom>((event, emit) {
      if (event.bottom == 1) emit(BottomInitial());
      if (event.bottom == 2) emit(BottomInc());
      if (event.bottom == 3) emit(BottomExp());
      if (event.bottom == 4) emit(BottomStats());
    });
  }
}
