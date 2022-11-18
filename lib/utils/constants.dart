const String firebaseStorageProductImageDir = 'ProductImages';
const String currencySymbol = '৳';

const cities=["Dhaka",'Rajshahi','Sylhet','Noakhali','pabna','borisal'];

abstract class PaymentStatus{
  static const String pending='Pending';
  static const String processing='Processing';
  static const String delivered='Delivered';
  static const String cancelled='Cancelled';
  static const String returned ='Returned';

}

abstract class PaymentMethod{
  static const String cod='Cash on Delivery';
  static const String online='Online Payment';


}