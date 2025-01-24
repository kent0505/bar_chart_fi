part of 'inc_bloc.dart';

@immutable
sealed class IncState {}

final class IncInitial extends IncState {}

final class IncLoading extends IncState {}

final class IncLoaded extends IncState {
  IncLoaded({
    required this.incList,
    required this.tag,
  });

  final List<Inc> incList;
  final int tag;
}
