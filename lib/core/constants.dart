import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'colors.dart';
import 'font.dart';

const projectId='raya-68237';
const baseUrl='https://firestore.googleapis.com/v1/projects/$projectId/databases/(default)/documents';

//const baseUrl='http://souqcom.alahlih-antibugs.com/api/';
const internetError='تأكد من الأتصال بالأنترنت';
bool enableNotification=true;
bool enableRate=true;


setDefaultStatusBar() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xff58595b),
    statusBarBrightness: Brightness.light, //ios bar icons
    statusBarIconBrightness: Brightness.dark, //ios bar icons
  ));
}

String convertDate(DateTime dateTime){
  DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
  String formattedDate = formatter.format(dateTime);
  return formattedDate;
}




