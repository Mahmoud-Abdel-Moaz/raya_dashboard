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

void navigateToAndReplacement(context, widget) => Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
  /*      (Route<dynamic> route){
      return false;
    }*/
);

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
          Icons.keyboard_arrow_right,
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
        style: openSans(16, raisinBlack, FontWeight.w600),
        decoration: InputDecoration(
            isDense: true,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            disabledBorder: InputBorder.none,
            hintText: hint,
            hintStyle: openSans(16, spanishGray, FontWeight.w300)),
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

passwordTextField({
  required TextEditingController controller,
  required BuildContext context,
  required String hint,
  required FocusNode focusNode,
  required bool obscureText,
  double? height,
  double? verticalPadding,
  TextInputType type = TextInputType.text,
  required void Function() onSubmit,
  required void Function() onTap,
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
        style: openSans(16, raisinBlack, FontWeight.w600),
        decoration: InputDecoration(
            isDense: true,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            disabledBorder: InputBorder.none,
            suffixIconConstraints:
            BoxConstraints(minWidth: 20.w, maxHeight: 20.h),
            suffixIcon: GestureDetector(
              onTap: onTap,
              child: SizedBox(
                width: 20.r,
                height: 20.r,
                child: Icon(
                  obscureText
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  // size: 20.w,
                  color: spanishGray,
                ),
              ),
            ),
            hintText: hint,
            hintStyle: openSans(16, spanishGray, FontWeight.w300)),
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
            border: Border.all(width: 1.r, color: outerSpace)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                style: cairo(16.sp, Colors.black, FontWeight.w400),
                cursorColor: outerSpace,
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
              color: outerSpace,
            ),
          ],
        ),
      ),
    );

