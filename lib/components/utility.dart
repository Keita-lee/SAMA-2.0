import 'package:flutter/material.dart';

class MyUtility {
  BuildContext context;

  MyUtility(this.context) : assert(context != null);

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

//check if date inbetween and call correct election round
  checkDatePeriod(start, end) {
    var validDate = false;

    var startDate = DateTime.parse(start);
    var endDate = DateTime.parse(end);
    final currentDate = DateTime.now();

    final today =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
    final checkDateStart =
        DateTime(startDate.year, startDate.month, startDate.day);
    final checkDateEnd = DateTime(endDate.year, endDate.month, endDate.day);

    if (checkDateStart == today || checkDateEnd == today) {
      validDate = true;
    } else if (currentDate.isAfter(startDate) &&
        currentDate.isBefore(endDate)) {
      validDate = true;
    }
    return validDate;
  }
}
