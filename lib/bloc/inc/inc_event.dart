part of 'inc_bloc.dart';

@immutable
sealed class IncEvent {}

class LoadInc extends IncEvent {}

class UpdateInc extends IncEvent {
  UpdateInc({
    required this.inc,
    this.add = false,
    this.edit = false,
    this.delete = false,
  });

  final Inc inc;
  final bool add;
  final bool edit;
  final bool delete;
}

class SortInc extends IncEvent {
  SortInc({required this.tag});

  final int tag;
}
