import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/cache_helper.dart';
import 'features/order/presentation/bloc/order_cubit.dart';
import 'features/order/presentation/pages/add_order_view.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) =>  OrderCubit()),

      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: ( context,child) =>const MaterialApp(
          title: 'Raya Dashboard',
          debugShowCheckedModeBanner: false,
          home: AddOrderScreen(),
        )
      ),

    );
  }
}
