import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/colors.dart';
import '../../domain/entities/order.dart';
import '../widgets/order_item_view.dart';

class OrderTypeView extends StatelessWidget {
  final List<Orderr>? orders;
  final String type;

  const OrderTypeView({Key? key, required this.orders, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Orderr>? typeOrders;
    if (orders != null) {
      typeOrders = orders!.where((element) => element.stats == type).toList();
    }
    return ConditionalBuilder(
      condition: orders != null,
      fallback: (context) => Center(
        child: CircularProgressIndicator(
          color: outerSpace,
        ),
      ),
      builder: (context) => ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) =>OrderItemView(order: typeOrders![index],),
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          height: 16.h,
        ),
        itemCount: typeOrders!.length,
      ),
    );
  }
}
