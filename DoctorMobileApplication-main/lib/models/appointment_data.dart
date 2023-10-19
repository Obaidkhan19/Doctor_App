import 'package:flutter/material.dart';

class AppointmentData {
  final String? statusText;
  final Color? statusColor;
  final String? name;
  final String? date;
  final String? time;
  final String? type;
  final String? rating;
  final bool? showButtons;
  final VoidCallback? onBookAgainPressed;
  final VoidCallback? onLeaveReviewPressed;

  AppointmentData({
     this.statusText,
     this.statusColor,
     this.name,
     this.date,
     this.time,
     this.type,
     this.rating,
     this.showButtons,
     this.onBookAgainPressed,
     this.onLeaveReviewPressed,
  });
}
