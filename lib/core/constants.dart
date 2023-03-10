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
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: defaultColor,
    statusBarBrightness: Brightness.dark, //ios bar icons
    statusBarIconBrightness: Brightness.light, //ios bar icons
  ));
}

setWhiteStatusBar() {
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

void navigateTo(context, widget,{void Function()? onBack }) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    ).then((value) {
  onBack;
});

Future<void> navigateToAndFinish(context, widget) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ), (Route<dynamic> route) {
      return false;
    });

void navigateToAndReplacement(context, widget) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );


Widget searchContainer(
        TextEditingController searchController,
        FocusNode focusNode,
        BuildContext context,
        void Function(String)? onChange) =>
    GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(focusNode);
      },
      child: Container(
         height: 57.h,
        padding: EdgeInsets.symmetric(/*vertical: 4.h,*/ horizontal: 17.w),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(width: 1.r, color: defaultColor)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                style: cairo(16.sp, Colors.black, FontWeight.w400),
                cursorColor: defaultColor,
                controller: searchController,
                focusNode: focusNode,
                decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
               contentPadding: EdgeInsets.zero,
               /*     contentPadding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),*/
                    disabledBorder: InputBorder.none,
                    hintText: 'بحث',
                    hintStyle: cairo(16.sp, darkSilver, FontWeight.w400)),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.search,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).unfocus();
                },
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                },
                onChanged: onChange,
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Icon(
              Icons.search,
              size: 37.r,
              color: defaultColor,
            ),
          ],
        ),
      ),
    );
