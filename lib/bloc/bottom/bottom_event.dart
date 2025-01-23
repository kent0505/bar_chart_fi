part of 'bottom_bloc.dart';

@immutable
sealed class BottomEvent {}

class SwitchBottom extends BottomEvent {
  SwitchBottom({required this.bottom});

  final int bottom;
}
