


import 'package:ecom_user_3/models/address_model.dart';
import 'package:ecom_user_3/models/cart_models.dart';
import 'package:ecom_user_3/models/date_model.dart';


const String collectionOrder='Order';

const String orderFieldOrderId='orderId';
const String orderFieldUserId='userId';
const String orderFieldGrandTotal='grandTotal';
const String orderFieldDiscount='discount';
const String orderFieldVat='vat';
const String orderFieldOrderStatus='orderStatus';
const String orderFieldPayMethod='payMethod';
const String orderFieldDeliveryAddress='deliveryAddress';
const String orderFieldOrderDate='orderDate';
const String orderFieldProductDetails='productDetails';

class OrderModel{
String orderId;
String userId;
num grandTotal;
num discount;
num vat;
String orderStatus;
String payMethod;
DateModel orderDate;
AddressModel deliveryAddress;
List<CartModel> productDetails;

OrderModel({
      required this.orderId,
      required this.userId,
      required this.grandTotal,
      required this.discount,
      required this.vat,
      required this.orderStatus,
      required this.payMethod,
      required this.orderDate,
      required this.deliveryAddress,
      required this.productDetails,

      });


Map<String,dynamic>toMap(){
  return <String,dynamic>{
    orderFieldOrderId:orderId,
    orderFieldUserId:userId,
    orderFieldGrandTotal:grandTotal,
    orderFieldDiscount:discount,
    orderFieldVat:vat,
    orderFieldOrderStatus:orderStatus,
    orderFieldPayMethod:payMethod,
    orderFieldOrderDate:orderDate.toMap(),
    orderFieldDeliveryAddress:deliveryAddress.toMap(),
    orderFieldProductDetails:productDetails.toList(),

  };
}

factory OrderModel.fromMap(Map<String,dynamic>map)=>OrderModel(
  orderId: map[orderFieldOrderId],
  userId: map[orderFieldUserId],
  grandTotal: map[orderFieldGrandTotal],
  discount:map[orderFieldDiscount],
  vat: map[orderFieldVat],
  orderStatus:map[orderFieldOrderStatus],
  payMethod: map[orderFieldPayMethod],
  orderDate: DateModel.fromMap(map[orderFieldOrderDate]),
  deliveryAddress: AddressModel.fromMap(map[orderFieldDeliveryAddress]),
  productDetails: ((map[orderFieldProductDetails]) as List).map((e) =>CartModel.fromMap(e)).toList(),

);



}