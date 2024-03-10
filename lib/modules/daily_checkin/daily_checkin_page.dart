import 'dart:developer';

import 'package:app/modules/daily_checkin/bloc/daily_checkin_bloc_bloc.dart';
import 'package:app/modules/daily_checkin/daily_checkin_calender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyCheckinPage extends StatefulWidget {
  const DailyCheckinPage({super.key});

  @override
  State<DailyCheckinPage> createState() => _DailyCheckinPageState();
}

class _DailyCheckinPageState extends State<DailyCheckinPage> {
  @override
  void initState() {
    // TODO: implement initState
    bloc.add(FetchDailyCheckinHistory());
    super.initState();
  }

  final bloc = DailyCheckinBloc();
  final markBloc = DailyCheckinBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar with center title
        appBar: AppBar(
          title: const Text('Daily Checkin'),
          centerTitle: true,
        ),
        //Column with mainAxis center
        body: BlocListener<DailyCheckinBloc, DailyCheckinBlocState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is DailyCheckinMarkinError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Error while marking checkin')));
            }
            if (state is DailyCheckinBlocError) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Error while checkin loading error')));
            }
            if (state is DailyCheckinMarkinSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Checkin success')));
            }
          },
          child: BlocBuilder<DailyCheckinBloc, DailyCheckinBlocState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is DailyCheckinBlocLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DailyCheckinBlocLoaded) {
                if (state.data.history.isEmpty) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Text('Welcome to Daily Checkin')),
                        ElevatedButton(
                            onPressed: () {
                              markBloc.add(CheckIn());
                              bloc.add(FetchDailyCheckinHistory());
                            },
                            child: const Text('Checkin'))
                      ]);
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CheckinCalendar(
                      state.data.history,
                      firstDay: state.data.joinDate,
                      lastDay: DateTime(2030, 1, 1),
                      focusedDay: DateTime.now(),
                    ),
                    BlocBuilder<DailyCheckinBloc, DailyCheckinBlocState>(
                      bloc: markBloc,
                      builder: (context, markState) {
                        log(markState.toString());
                        if (markState is DailyCheckinMarkinLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          final bool alreadyCheckin =
                              (state.data.history.last.isCheckedIn);
                          if (alreadyCheckin == false) {
                            return ElevatedButton(
                                onPressed: () {
                                  markBloc.add(CheckIn());
                                  bloc.add(FetchDailyCheckinHistory());
                                },
                                child: const Text('Checkin'));
                          } else {
                            return const Text('Already checkin');
                          }
                        }
                      },
                    ),
                  ],
                );
              } else {
                return const Text('Something went wrong');
              }
            },
          ),
        ));
  }
}
