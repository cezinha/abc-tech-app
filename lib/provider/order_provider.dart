import 'package:abctechapp/constants.dart';
import 'package:abctechapp/model/order.dart';
import 'package:get/get.dart';

abstract class OrderProviderInterface {
  Future<Response> postOrder(Order order);
}

class OrderProvider extends GetConnect implements OrderProviderInterface {
  @override
  Future<Response> postOrder(Order order) =>
      post('${Constants.url}/order', order.toMap());
}
