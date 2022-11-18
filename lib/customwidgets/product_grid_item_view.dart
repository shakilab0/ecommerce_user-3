import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_user_3/models/product_model.dart';
import 'package:ecom_user_3/pages/product_details_page.dart';
import 'package:ecom_user_3/utils/constants.dart';
import 'package:ecom_user_3/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductGridItemView extends StatelessWidget {
  final ProductModel productModel;
  const ProductGridItemView({Key? key,required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, ProductDetailsPage.routeName,arguments:productModel);
      },
      child: Card(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: productModel.thumbnailImageModel.imageDownloadUrl,
                    placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(productModel.productName,style: const TextStyle(fontSize: 16,color:Colors.grey ),),
                ),

                if(productModel.productDiscount > 0)Padding(
                  padding: const EdgeInsets.all(2.0),
                  child:RichText(
                      text: TextSpan(
                        text: " ${getPriceAfterDiscount(productModel.salePrice, productModel.productDiscount)}",
                        style: const TextStyle(fontSize: 20,color: Colors.black),
                        children: [
                          TextSpan(
                            text: "$currencySymbol${productModel.salePrice}",
                            style: const TextStyle(fontSize: 16,color: Colors.black38,decoration:TextDecoration.lineThrough ),
                          )
                        ]
                      ),
                  ),
                ),

                if(productModel.productDiscount ==0)Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text('$currencySymbol ${productModel.salePrice}',style: const TextStyle(fontSize: 16,color:Colors.grey )),
                ),

                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RatingBar.builder(
                        initialRating: productModel.avgRating.toDouble(),
                        minRating: 0.0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ignoreGestures: true,
                        itemSize: 20,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      const SizedBox(height: 3,),
                      Text(productModel.avgRating.toString(),style: const TextStyle(color: Colors.orange),)
                    ],
                  ),
                ),
              ],
            ),
            if(productModel.productDiscount==0)Positioned(
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                height: 45,
                color: Colors.black38,
                child: Text("${productModel.productDiscount}% OFF",style: const TextStyle(fontSize: 25,color:Colors.white),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
