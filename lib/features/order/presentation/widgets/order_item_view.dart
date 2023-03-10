
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raya_dashboard/core/font.dart';

import '../../../../core/colors.dart';
import '../../../../core/constants.dart';
import '../../domain/entities/order.dart';

class OrderItemView extends StatelessWidget {
  final Orderr order;
  const OrderItemView({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(order.details,style: openSans(16.sp, raisinBlack, FontWeight.w600),textScaleFactor: 1,),
          SizedBox(height: 8.h,),
          Text(convertDate(order.createdOn),style: openSans(14.sp, dimGray, FontWeight.w600),textScaleFactor: 1,),
        ],
      ),
    );
  }
}
