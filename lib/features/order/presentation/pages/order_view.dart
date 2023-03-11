import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/colors.dart';
import '../../../../core/compnents.dart';
import '../../../../core/constants.dart';
import '../../../../core/font.dart';
import '../../../../core/local_notification_service.dart';
import '../../domain/entities/order.dart';
import '../bloc/order_cubit.dart';
import 'add_order_view.dart';
import 'order_type_view.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  @override
  void initState() {
    notification(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    setDefaultStatusBar();
    OrderCubit orderCubit = OrderCubit.get(context);
    List<Orderr>? orders = orderCubit.orders;
    orderCubit.getOrders();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: cultured,
        appBar: defaultAppBar(title: 'Orders', context: context, bottom: TabBar(
          unselectedLabelStyle:
          openSans(15.sp, outerSpace, FontWeight.w400),
          unselectedLabelColor: outerSpace,
          labelStyle: openSans(15.sp, Colors.white, FontWeight.w500),
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          overlayColor: MaterialStateProperty.all(cultured),
          tabs: const [
            Tab(
              text: 'New',
            ),
            Tab(
              text: 'Returned',
            ),
            Tab(
              text: 'Completed',
            ),

          ],
        )),
        body: BlocConsumer<OrderCubit, OrderState>(
          listener: (context, state) {
           if(state is LoadedOrdersState){
             orders=state.orders;
           }else if(state is ErrorOrdersState){
              showToast(msg: state.errorMessage, state: ToastStates.error);
           }
          },
          builder: (context, state) {
            return TabBarView(
              physics: const BouncingScrollPhysics(),
              children: [
                OrderTypeView(orders: orders, type: 'new'),
                OrderTypeView(orders: orders, type: 'returned'),
                OrderTypeView(orders: orders, type: 'completed'),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(onPressed: ()=>navigateTo(context,const AddOrderScreen()),backgroundColor: raisinBlack,child:const Icon(Icons.add,color: Colors.white,),),
      ),
    );
  }

  notification(context) {
    LocalNotificationService.initialize(context);

    ///gives you the message on which user taps
    ///and it opened the app from terminated state

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        navigateToAndFinish(context,const OrderScreen());

      }
    });

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        // print(message.notification!.body);
        // print(message.notification!.title);
      }

      LocalNotificationService.display(message);
    });

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      navigateToAndFinish(context,const OrderScreen());
    });
  }
}
