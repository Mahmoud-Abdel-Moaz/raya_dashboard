import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'colors.dart';
import 'font.dart';

navigateTo(context, widget, {void Function()? than}) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
).then((value) => than);

Future<void> navigateToAndFinish(context, widget) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ), (Route<dynamic> route) {
      return false;
    });


void showToast({
  required String msg,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: _chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

Color _chooseToastColor(ToastStates state) {
  switch (state) {
    case ToastStates.success:
      return Colors.green;
    case ToastStates.warning:
      return Colors.yellow;
    case ToastStates.error:
      return Colors.red;
  }
}

enum ToastStates { success, error, warning }

AppBar defaultAppBar({
  required String title,
  bool centerTitle = true,
  required BuildContext context,
  List<Widget>? actions = const [],
  double? titleSize,
  double? elevation,
  Color? background,
  Color? titleColor,
  Color? iconColor,
  void Function()? onBack,
  bool withBack = false,
  PreferredSizeWidget? bottom,
}) {
  return AppBar(
    actions: actions,
    title: Text(
      title,
      style: openSans(
          titleSize ?? 20.sp, titleColor ?? silverSand, FontWeight.bold),
      textScaleFactor: 1,
    ),
    centerTitle: centerTitle,
    backgroundColor: background ?? const Color(0xff58595b),
    elevation: elevation,
    bottom: bottom,
    leading: withBack
        ? GestureDetector(
        onTap: onBack ??
                () {
              Navigator.of(context).pop();
            },
        child: Icon(
          Icons.arrow_back_ios_rounded,
          color: iconColor ?? silverSand,
          size: 20.r,
        ))
        : null,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20.r),
        bottomRight: Radius.circular(20.r),
      ),
    ),
  );
}

customTextField({
  required TextEditingController controller,
  required BuildContext context,
  required String hint,
  required FocusNode focusNode,
  bool obscureText = false,
  double? height,
  double? verticalPadding,
  TextInputType type = TextInputType.text,
  required void Function() onSubmit,
  String? Function(String?)? validator,
  void Function(String)? onChanged,
}) {
  return GestureDetector(
    onTap: () {
      FocusScope.of(context).requestFocus(focusNode);
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 24.w),
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: lotion,
        border: Border.all(width: 1.r, color: davyIsGrey),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextFormField(
        style: openSans(14, raisinBlack, FontWeight.w600),
        decoration: InputDecoration(
            isDense: true,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            disabledBorder: InputBorder.none,
            hintText: hint,
            hintStyle: openSans(14, spanishGray, FontWeight.w300)),
        controller: controller,
        keyboardType: type,
        obscureText: obscureText,
        onFieldSubmitted: (value) {
          onSubmit();
        },
        focusNode: focusNode,
        validator: validator,
        onChanged: onChanged,
      ),
    ),
  );
}

Widget defaultButton(
    {required void Function() onTap,
      required String text,
      bool isLoading = false}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(
        vertical: 11.h,
        horizontal: 16.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: davyIsGrey,
      ),
      child: Center(
        child: isLoading
            ? const CircularProgressIndicator(
          color: Colors.white,
        )
            : Text(
          text,
          style: openSans(16.sp, Colors.white, FontWeight.bold),
          textScaleFactor: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ),
  );
}




