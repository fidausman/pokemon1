import 'dart:async';
import 'dart:developer';

import 'package:app/shared/models/checkin_model.dart';
import 'package:app/shared/repositories/auth_interceptor.dart';
import 'package:app/shared/repositories/daily_checkin_service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'daily_checkin_bloc_event.dart';
part 'daily_checkin_bloc_state.dart';

class DailyCheckinBloc
    extends Bloc<DailyCheckinBlocEvent, DailyCheckinBlocState> {
  DailyCheckinBloc() : super(DailyCheckinBlocInitial()) {
    on<FetchDailyCheckinHistory>(_getHistory);

    // on checkin event
    on<CheckIn>(_markToday);
  }

  FutureOr<void> _getHistory(FetchDailyCheckinHistory event,
      Emitter<DailyCheckinBlocState> emit) async {
    DailyCheckinService.instance
        .addInterceptor(AuthInterceptor(dio: DailyCheckinService.instance.dio));
    try {
      emit(DailyCheckinBlocLoading());
      // get email from sharedpreference
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('email');
      var result = await DailyCheckinService.instance.getHistory(email!);
      log(result.toString());
      if (result.statusCode == 201) {
        final data = DailyCheckin.fromJson(result.toString());
        emit(DailyCheckinBlocLoaded(data: data));
      }
    } on DioException catch (e) {
      log(e.toString());
      emit(DailyCheckinBlocError());
    }

    DailyCheckinService.instance.removeInterceptor();
  }

  FutureOr<void> _markToday(
      CheckIn event, Emitter<DailyCheckinBlocState> emit) async {
    try {
      DailyCheckinService.instance.addInterceptor(
          AuthInterceptor(dio: DailyCheckinService.instance.dio));
      emit(DailyCheckinMarkinLoading());
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('email');
      log('email: $email');
      final response = await DailyCheckinService.instance.checkIn(email!);
      log(response.toString());
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        emit(DailyCheckinMarkinSuccess());
      }
    } on DioException catch (e) {
      log('MarkCatchBloc: ${e.toString()}');
      emit(DailyCheckinMarkinError());
    } catch (e) {
      log(e.toString());
    }
    DailyCheckinService.instance.removeInterceptor();
  }
}
