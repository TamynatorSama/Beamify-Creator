
import 'package:beamify_creator/shared/utils/app_theme.dart';
import 'package:flutter/material.dart';

Widget emptyPod({String? message}) => Container(
      height: 150,
      decoration: BoxDecoration(
          color: AppTheme.backgroundColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          message??"No Active Pods",
          style: AppTheme.headerStyle
              .copyWith(color: Colors.white.withOpacity(0.3)),
        ),
      ),
    );