import 'package:flutter/material.dart';
import 'package:servicemen_customer_app/utils/app_colors.dart';
import 'package:servicemen_customer_app/utils/app_textstyles.dart';

class MonthlyWeeklyCalendar extends StatefulWidget {
  final DateTime startDate;
  final ValueChanged<DateTime> onDateSelected;

  const MonthlyWeeklyCalendar({
    super.key,
    required this.startDate,
    required this.onDateSelected,
  });

  @override
  State<MonthlyWeeklyCalendar> createState() => _MonthlyWeeklyCalendarState();
}

class _MonthlyWeeklyCalendarState extends State<MonthlyWeeklyCalendar> {
  late DateTime selectedDate;
  late List<List<DateTime>> weeks;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    selectedDate = widget.startDate;
    weeks = _generateWeeks(widget.startDate);
  }

  /// Generate weeks for 1 month starting from current week
  List<List<DateTime>> _generateWeeks(DateTime start) {
    final weekStart = start.subtract(Duration(days: start.weekday - 1));

    final endDate = DateTime(start.year, start.month + 1, start.day);

    List<List<DateTime>> result = [];
    DateTime cursor = weekStart;

    while (cursor.isBefore(endDate)) {
      result.add(List.generate(7, (i) => cursor.add(Duration(days: i))));
      cursor = cursor.add(const Duration(days: 7));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: PageView.builder(
        controller: _pageController,
        itemCount: weeks.length,
        itemBuilder: (_, weekIndex) {
          final week = weeks[weekIndex];

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: week.map((date) {
              final isSelected = _sameDay(date, selectedDate);
              final isDisabled = date.isBefore(
                DateTime.now().subtract(const Duration(days: 1)),
              );

              return GestureDetector(
                onTap: isDisabled
                    ? null
                    : () {
                        setState(() => selectedDate = date);
                        widget.onDateSelected(date);
                      },
                child: Container(
                  width: 48,
                  decoration: BoxDecoration(
                    gradient: isSelected? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [

                        AppColors.kPrimaryColor,
                        AppColors.kPrimaryColorLight
                      ],
                      stops: [0.3,1]
                    ):null,
                    // gradient: LinearGradient(
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomCenter,
                    //   colors: [
                    //     Color.fromRGBO(255, 255, 255, 0.12),
                    //     Color.fromRGBO(255, 255, 255, 0),
                    //   ],),
                    color: isSelected
                        ? AppColors.kPrimaryColor
                        : AppColors.kWhite,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.kTransparent
                          : AppColors.kGrey1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _dayLabel(date),
                        style: isSelected
                            ? AppTextStyles.sf12kWhiteW400TextStyle
                            : isDisabled
                            ? AppTextStyles.sf12kGreyW400TextStyle
                            : AppTextStyles.sf12kBlackW400TextStyle,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        date.day.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? AppColors.kWhite
                              : isDisabled
                              ? AppColors.kGrey1
                              : AppColors.kBlack
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _dayLabel(DateTime date) =>
      ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][date.weekday - 1];
}
