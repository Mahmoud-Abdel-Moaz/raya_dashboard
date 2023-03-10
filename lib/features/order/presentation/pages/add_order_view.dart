import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raya_dashboard/core/colors.dart';
import 'package:raya_dashboard/core/compnents.dart';
import 'package:raya_dashboard/core/font.dart';

import '../bloc/order_cubit.dart';

class AddOrderScreen extends StatelessWidget {
  const AddOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addressController = TextEditingController();
    final detailsController = TextEditingController();
    final detailsFocusNode = FocusNode();
    final addressFocusNode = FocusNode();
    OrderCubit orderCubit = OrderCubit.get(context);
    bool isLoading = false;
    return Scaffold(
      backgroundColor: cultured,
      appBar:
      defaultAppBar(title: 'Add Order', context: context, withBack: true),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
        child: BlocConsumer<OrderCubit, OrderState>(
          listener: (context, state) {
           if(state is LoadingAddOrderState){
             isLoading=true;
           }else if(state is LoadedAddOrderState){
             isLoading=false;
             showToast(msg: 'Order Added', state: ToastStates.success);
             orderCubit.getOrders();
           }else if(state is ErrorAddOrderState){
             isLoading=false;
             showToast(msg: state.errorMessage, state: ToastStates.error);
           }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order address',
                        style: openSans(16.sp, raisinBlack, FontWeight.w600),
                        textScaleFactor: 1,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      customTextField(
                        controller: addressController,
                        context: context,
                        hint: 'destination address',
                        focusNode: addressFocusNode,
                        onSubmit: () =>
                            FocusScope.of(context).requestFocus(
                                detailsFocusNode),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        'Order Details',
                        style: openSans(16.sp, raisinBlack, FontWeight.w600),
                        textScaleFactor: 1,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      customTextField(
                        controller: detailsController,
                        context: context,
                        height: 100.h,
                        hint: 'Order Details',
                        type: TextInputType.multiline,
                        focusNode: detailsFocusNode,
                        onSubmit: () =>
                            FocusScope.of(context).unfocus(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                defaultButton(onTap: () {
                  if (!isLoading) {
                    if (addressController.text.isNotEmpty &&
                        detailsController.text.isNotEmpty) {
                      orderCubit.addOrder(orderDetails: detailsController.text,
                          address: addressController.text);
                    }
                  }
                }, text: 'Add Order', isLoading: isLoading),
              ],
            );
          },
        ),
      ),
    );
  }
}
