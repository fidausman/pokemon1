part of 'daily_checkin_bloc_bloc.dart';

sealed class DailyCheckinBlocState extends Equatable {
  const DailyCheckinBlocState();

  @override
  List<Object> get props => [];
}

final class DailyCheckinBlocInitial extends DailyCheckinBlocState {}

// create a state to checkinLoaded state
final class DailyCheckinBlocLoaded extends DailyCheckinBlocState {
  final DailyCheckin data;
  const DailyCheckinBlocLoaded({required this.data});
}

//loading state
final class DailyCheckinBlocLoading extends DailyCheckinBlocState {}

// error state
final class DailyCheckinBlocError extends DailyCheckinBlocState {}

//loading state
final class DailyCheckinMarkinLoading extends DailyCheckinBlocState {}

// error state
final class DailyCheckinMarkinError extends DailyCheckinBlocState {}

// success state
final class DailyCheckinMarkinSuccess extends DailyCheckinBlocState {}
