// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:abctechapp/model/order_location.dart';

class Order {
  int operatorId;
  List<int> services = [];
  OrderLocation? start;
  OrderLocation? end;

  Order(
      {required this.operatorId,
      required this.services,
      required this.start,
      required this.end});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'operatorId': operatorId,
      'services': services,
      'start': start?.toMap(),
      'end': end?.toMap()
    };
  }

  String toJson() => json.encode(toMap());
}
