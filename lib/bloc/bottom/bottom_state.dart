part of 'bottom_bloc.dart';

@immutable
sealed class BottomState {}

final class BottomInitial extends BottomState {}

final class BottomInc extends BottomState {}

final class BottomExp extends BottomState {}

final class BottomStats extends BottomState {}
