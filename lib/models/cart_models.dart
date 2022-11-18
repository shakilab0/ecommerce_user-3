
const String collectionCart='Cart';

const String cartFieldproductId='productId';
const String cartFieldproductName='productName';
const String cartFieldproductImageUrl='productImageUrl';
const String cartFieldproductQuantity='quantity';
const String cartFieldproductSalePrice='salePrice';


class CartModel{

  String productId;
  String productName;
  String productImageUrl;
  num quantity;
  num salePrice;

  CartModel({
    required this.productId,
    required this.productName,
    required this.productImageUrl,
    this.quantity=1,
    required this.salePrice,
  });



  Map<String,dynamic>toMap(){
    return <String,dynamic>{
      cartFieldproductId:productId,
      cartFieldproductName:productName,
      cartFieldproductImageUrl:productImageUrl,
      cartFieldproductQuantity:quantity,
      cartFieldproductSalePrice:salePrice,
    };
  }

  factory CartModel.fromMap(Map<String,dynamic>map)=>CartModel(
    productId:map[cartFieldproductId],
    productName:map[cartFieldproductName],
    productImageUrl: map[cartFieldproductImageUrl],
    quantity:map[cartFieldproductQuantity],
    salePrice: map[cartFieldproductSalePrice],
  );


}