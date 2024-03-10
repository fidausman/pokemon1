part of 'daily_checkin_bloc_bloc.dart';

sealed class DailyCheckinBlocEvent extends Equatable {
  const DailyCheckinBlocEvent();

  @override
  List<Object> get props => [];
}

// Create an event to fetch Daily Checkin History
class FetchDailyCheckinHistory extends DailyCheckinBlocEvent {}

// Create event to checkin
class CheckIn extends DailyCheckinBlocEvent {}
