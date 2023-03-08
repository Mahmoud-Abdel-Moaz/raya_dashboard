import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  static OrderCubit get(context) => BlocProvider.of(context);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  addOrder({required String orderDetails,required String address})async{
    try{
      emit(LoadingAddOrder());
      await _addData(orderDetails: orderDetails,address: address);
      _sendNotification('New Order', orderDetails);
      emit(LoadedAddOrder());
    }catch(e){
      print('Error on add order $e');
      emit(ErrorAddOrder(e.toString()));
    }
  }

  Future<void> _addData({required String orderDetails, required String address, }) async {
    final CollectionReference myCollection =_firestore.collection('orders');
    final DocumentReference newDocRef = myCollection.doc();
    final String newDocId = newDocRef.id;
    await _firestore.collection('orders').doc(newDocId).set({
      'id':newDocId,
      'details': orderDetails,
      'address': address,
      'stats':'new',
    });
  }


/*  Future<void> addData() async {
    try {
      final response = await http.post(
        Uri.parse('https://firestore.googleapis.com/v1/projects/{projectId}/databases/(default)/documents/{collectionName}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer {accessToken}',
        },
        body: jsonEncode(<String, dynamic>{
          'fields': {
            'field1': {'stringValue': 'value1'},
            'field2': {'stringValue': 'value2'},
          },
        }),
      );
      if (response.statusCode == 200) {
        print('Data added successfully.');
      } else {
        print('Failed to add data. Error code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }*/

  Future<void> _sendNotification(String title,String description) async {
    const postUrl = 'https://fcm.googleapis.com/fcm/send';
    Dio dio = Dio();
    final data = {
      "notification":{
        "body":description,
        "title":title,
      },
      "data": {
        "message": description,
        "title": 'data',
      },
      "to": '/topics/new_orders'
    };
    FirebaseMessaging.instance.sendMessage();
    String serverKey='AAAAJEGO7HI:APA91bEMZB5B2PuLUpPCJ4CfUhsDQ97rshTyLiIOoWhJUBuKlgoLsb6SaWIogas8lIJPtp9cD2iVbNSRzugz4wrNpG4snduTfvuB-kPuS9VakIz-BGi3WMtYgxdvMfPgQkp8b01EEFeA';
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = 'key=$serverKey';
    try {
      final response = await dio.post(postUrl, data: data);
      print('notification response ${response.data}');
      if (response.statusCode == 200) {
        print('Request Sent To Driver');
      } else {
        print('notification sending failed');
      }
    }catch (e) {
      print('exception $e');
    }
  }



}
