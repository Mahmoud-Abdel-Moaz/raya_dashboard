
import '../../domain/entities/order.dart';

class OrderModel extends Orderr{
  OrderModel(super.id, super.address, super.details, super.stats, super.createdOn);
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(json['id'], json['address'], json['details'],
        json['stats'], DateTime.parse(json['created_on']),);
  }

}

/* 'id':newDocId,
  'details': orderDetails,
  'address': address,
  'stats':'new',
  'created_on':DateTime.now().toString()*/