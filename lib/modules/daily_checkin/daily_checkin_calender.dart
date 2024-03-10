import 'package:app/shared/models/checkin_model.dart';
import 'package:app/theme/app_theme.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class CheckinCalendar extends StatelessWidget {
  const CheckinCalendar(
    this.data, {
    super.key,
    required this.firstDay,
    required this.lastDay,
    required this.focusedDay,
  });

  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime focusedDay;
  final List<History> data;

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context).colorScheme;
    return TableCalendar(
      calendarStyle: _calStyle(context),
      headerStyle: _headerStyle(context),
      pageAnimationDuration: Durations.long3,
      daysOfWeekStyle: _daysOfWeekStyle(context),
      weekNumbersVisible: false,
      focusedDay: focusedDay,
      firstDay: firstDay,

      lastDay: lastDay,

      enabledDayPredicate: (day) => !day.isAfter(DateTime.now()),

      weekendDays: const [DateTime.sunday],
      // Builders
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, currentDate, events) {
          final History? status = data.firstWhereOrNull(
            (element) =>
                (element.createdAt.year == currentDate.year) &&
                (element.createdAt.month == currentDate.month) &&
                (element.createdAt.day == currentDate.day),
          );
          if (status != null) {
            return status.isCheckedIn == true
                ? Container(
                    decoration:
                        _markerDecoration(context, Colors.teal.shade400),
                    width: 40.w,
                    height: 5.h,
                  )
                : Container(
                    decoration:
                        _markerDecoration(context, Colors.red.withOpacity(0.5)),
                    width: 40.w,
                    height: 5.h,
                  );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

_markerDecoration(BuildContext context, Color color) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(2.5),
  );
}

DaysOfWeekStyle _daysOfWeekStyle(context) {
  return DaysOfWeekStyle(
    weekendStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.red.shade400,
    ),
    weekdayStyle: const TextStyle(
      fontWeight: FontWeight.bold,
    ),
  );
}

CalendarStyle _calStyle(BuildContext context) {
  final theme = Theme.of(context).colorScheme;
  return CalendarStyle(
    tablePadding: EdgeInsets.only(
      top: 10.h,
    ),
    selectedDecoration: BoxDecoration(
      color: theme.primary,
    ),
    defaultTextStyle: TextStyle(
      color: theme.onBackground.withOpacity(0.75),
    ),
    disabledTextStyle: TextStyle(
      color: theme.onBackground.withOpacity(0.15),
    ),
    todayDecoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(7),
    ),
    markerDecoration: BoxDecoration(
      color: theme.primary.withOpacity(0.25),
      borderRadius: BorderRadius.circular(10.r),
    ),
    todayTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
    ),
    weekendTextStyle: TextStyle(
      color: Colors.red.shade400,
    ),
    outsideDaysVisible: false,
  );
}

HeaderStyle _headerStyle(BuildContext context) {
  final theme = Theme.of(context).colorScheme;
  return HeaderStyle(
    leftChevronVisible: false,
    rightChevronVisible: false,
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(15.r),
    ),
    titleCentered: true,
    titleTextStyle: TextStyle(
      color: theme.background,
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
      letterSpacing: 0,
      height: 1,
    ),
    headerPadding: EdgeInsets.symmetric(vertical: 12.5.h),
    leftChevronIcon: Icon(
      CupertinoIcons.left_chevron,
      color: theme.background,
    ),
    rightChevronIcon: Icon(
      CupertinoIcons.right_chevron,
      color: theme.background,
    ),
    formatButtonVisible: false,
  );
}
