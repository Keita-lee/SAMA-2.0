import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommonService {
//Get amount of days between dates
  getDaysAmount(date1, date2) {
    if (date1 != "" && date2 != "") {
      DateTime d1 = DateTime.parse(date1);
      DateTime d2 = DateTime.parse(date2);

      return "${d2.difference(d1).inDays + 1} days";
    }
    return "";
  }

//Get Month and year from date
  String getDateInText(date) {
    DateTime dateTime = DateTime.parse(date);
    String day = DateFormat('dd').format(dateTime);
    String month = DateFormat('MMMM').format(dateTime);
    String year = DateFormat('yyyy').format(dateTime);
    return '$day $month $year';
  }

  //Check if date started or pased
  checkDateStarted(date) {
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime.parse(date);
    if (now.difference(dateTime).inDays >= 1) {
      return "After";
    } else {
      return "Before";
    }
  }

//Get month of date
  String formatMonth(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String month = DateFormat('MMMM').format(dateTime);
    return '$month';
  }

  String getTodaysDateText() {
    DateTime now = DateTime.now();
    String day = DateFormat('dd').format(now);
    String month = DateFormat('MM').format(now);
    String year = DateFormat('yyyy').format(now);

    return "$year-$month-$day";
  }

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
