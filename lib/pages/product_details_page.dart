import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_user_3/models/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../auth/auth_service.dart';
import '../models/product_model.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';
import '../providers/user_provider.dart';
import '../utils/constants.dart';
import '../utils/helper_functions.dart';
import '../utils/widget_functions.dart';
import 'login_page.dart';

class ProductDetailsPage extends StatefulWidget {
  static const String routeName = "/product_details_page";
  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final focusNode = FocusNode();
  final txtController = TextEditingController();
  @override
  void dispose() {
    txtController.dispose();
    super.dispose();
  }

  late ProductModel productModel;
  late ProductProvider productProvider;
  late UserProvider userProvider;
  double userRating = 0.0;
  late Size size;
  var showImage = '';
  bool showDiscription = false;
  String photoUrl = '';

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    productModel = ModalRoute.of(context)!.settings.arguments as ProductModel;
    photoUrl = productModel.thumbnailImageModel.imageDownloadUrl;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(productModel.productName), actions: [
        TextButton(
            onPressed: () {},
            child: Column(
              children: const [
                Icon(Icons.favorite, color: Colors.white,),
                Text("Favourite", style: TextStyle(color: Colors.white,),
                )
              ],
            )),
        TextButton(
            onPressed: () {},
            child: Column(
              children: const [Icon(Icons.shopping_cart, color: Colors.white,),
                Text("Cart", style: TextStyle(color: Colors.white,),
                ),
              ],
            )),
        // Expanded(
        //   child: Consumer<CartProvider>(
        //     builder: (context, provider, child) {
        //       final isInCart =
        //       provider.isProductInCart(productModel.productId!);
        //       return TextButton.icon(
        //         onPressed: () async {
        //           EasyLoading.show(status: 'Please wait');
        //           if (isInCart) {
        //             //remove
        //             await provider
        //                 .removeFromCart(productModel.productId!);
        //             showMsg(context, 'Removed from Cart');
        //           } else {
        //             await provider.addToCart(
        //               productId: productModel.productId!,
        //               productName: productModel.productName,
        //               url: productModel
        //                   .thumbnailImageModel.imageDownloadUrl,
        //               salePrice: num.parse(getPriceAfterDiscount(
        //                   productModel.salePrice,
        //                   productModel.productDiscount)),
        //             );
        //             showMsg(context, 'Added to Cart');
        //           }
        //           EasyLoading.dismiss();
        //         },
        //         icon: Icon(isInCart
        //             ? Icons.remove_shopping_cart
        //             : Icons.shopping_cart),
        //         label:
        //         Text(isInCart ? 'REMOVE FROM CART' : 'ADD TO CART'),
        //       );
        //     },
        //   ),
        // ),
      ]),
      body: ListView(
        children: [
          CachedNetworkImage(
            width: double.infinity,
            height: 230,
            fit: BoxFit.fitHeight,
            imageUrl: photoUrl,
            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  photoUrl = productModel.thumbnailImageModel.imageDownloadUrl;
                },
                child: Card(
                  child: CachedNetworkImage(
                    width: 70,
                    height: 100,
                    fit: BoxFit.fitWidth,
                    imageUrl: productModel.thumbnailImageModel.imageDownloadUrl,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
              ...productModel.additionalImageModels.map((url) {
                return url.isEmpty ? const SizedBox(): InkWell(
                        onTap: () {
                          setState(() {
                            photoUrl = url;
                          });
                        },
                        child: Card(
                          child: CachedNetworkImage(
                            width: 100,
                            height: 100,
                            fit: BoxFit.fitWidth,
                            imageUrl: url,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                      );
              }).toList(),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite),
                  label: const Text('ADD TO FAVORITE'),
                ),
              ),
              Expanded(
                child: Consumer<CartProvider>(
                  builder: (context, provider, child) {
                    final isInCart = provider.isProductInCart(productModel.productId!);
                    return TextButton.icon(
                      onPressed: () async {
                        EasyLoading.show(status: 'Please wait');
                        if (isInCart) {
                          //remove
                          await provider.removeFromCart(productModel.productId!);
                          showMsg(context, 'Removed from Cart');
                        } else {
                          await provider.addToCart(
                            productId: productModel.productId!,
                            productName: productModel.productName,
                            url: productModel.thumbnailImageModel.imageDownloadUrl,
                            salePrice: num.parse(getPriceAfterDiscount(productModel.salePrice, productModel.productDiscount)),
                          );
                          showMsg(context, 'Added to Cart');
                        }
                        EasyLoading.dismiss();
                      },
                      icon: Icon(isInCart ? Icons.remove_shopping_cart : Icons.shopping_cart),
                      label: Text(isInCart ? 'REMOVE FROM CART' : 'ADD TO CART'),
                    );
                  },
                ),
              ),
            ],
          ),

          // //Another System Picture Show

          // SizedBox(
          //   height: 90,
          //   child:Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       productModel.additionalImageModels[0].isEmpty?SizedBox():
          //       PhotoFrameView(
          //         onImagePresed: (){
          //           setState((){
          //             showImage=productModel.additionalImageModels[0];
          //           });
          //         },
          //         url: productModel.additionalImageModels[0],
          //           child: const Icon(Icons.add_a_photo,size: 30,)
          //       ),
          //       productModel.additionalImageModels[1].isEmpty?SizedBox():
          //       PhotoFrameView(
          //         url: productModel.additionalImageModels[1],
          //         onImagePresed: (){
          //           setState((){
          //             showImage=productModel.additionalImageModels[1];
          //           });                },
          //           child: const Icon(Icons.add_a_photo,size: 30,)
          //       ),
          //       productModel.additionalImageModels[2].isEmpty?SizedBox():
          //       PhotoFrameView(
          //         url: productModel.additionalImageModels[2],
          //         onImagePresed: (){
          //           setState((){
          //             showImage=productModel.additionalImageModels[2];
          //           });
          //
          //         },
          //           child: const Icon(Icons.add_a_photo,size: 30,)
          //       ),
          //       PhotoFrameView(
          //         url: productModel.thumbnailImageModel.imageDownloadUrl,
          //         onImagePresed: (){
          //           setState((){
          //             showImage=productModel.thumbnailImageModel.imageDownloadUrl;
          //           });
          //
          //         },
          //         child: const Icon(Icons.add_a_photo,size: 30,)
          //
          //       ),
          //
          //
          //     ],
          //   ) ,
          // ),

          ListTile(
            title: Text(productModel.productName),
            subtitle: Text(productModel.category.categoryName),
          ),

          if (productModel.productDiscount == 0)Text('Price $currencySymbol ${productModel.salePrice}'),
          if (productModel.productDiscount > 0)
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: RichText(
                text: TextSpan(
                    text: " Price $currencySymbol${getPriceAfterDiscount(productModel.salePrice, productModel.productDiscount)}",
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    children: [
                      TextSpan(
                        text: "$currencySymbol${productModel.salePrice}",
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black38,
                            decoration: TextDecoration.lineThrough),
                      )
                    ]),
              ),
            ),
          const Text("Short Discription: "),
          productModel.shortDescription.toString().isEmpty ? Text(productModel.shortDescription.toString()) : Text("no discription Avalivale"),
          TextButton(
              onPressed: () {
                setState(() {
                  showDiscription = !showDiscription;
                });
              },
              child: const Text("Long description")
          ),
          showDiscription ? (productModel.longDescription.toString().isEmpty
                  ? Text(productModel.longDescription.toString())
                  : const Text("no discription Avalivale")) : const SizedBox(),

          Card(
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Text('Rate this Product'),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: RatingBar.builder(
                      initialRating: 3,
                      minRating: 0.0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      ignoreGestures: false,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                      itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber,),
                      onRatingUpdate: (rating) {userRating = rating;},
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      if (AuthService.currentUser!.isAnonymous) {
                        showCustomDialog(
                          context: context,
                          title: 'Unregistered User',
                          positiveButtonText: 'Login',
                          content: 'To rate this product, you need to login with your email and password or Google Account. To login with your account, go to Login Page',
                          onPressed: () {
                            Navigator.pushNamed(context, LoginPage.routeName);
                          },
                        );
                      } else {
                        EasyLoading.show(status: 'Please wait');
                        await productProvider.addRating(
                          productModel.productId!,
                          userRating,
                          userProvider.userModel!,
                        );
                        EasyLoading.dismiss();
                        showMsg(context, 'Thanks for your rating');
                      }
                    },
                    child: const Text('SUBMIT'),
                  )
                ])),
          ),

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Comments'),
          ),
          Card(
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Comment this Product'),
                    Padding(
                        padding: const EdgeInsets.all(4),
                        child: TextField(
                          focusNode: focusNode,
                          controller: txtController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        )
                    ),
                    OutlinedButton(
                      onPressed: () async {
                        if (txtController.text.isEmpty) return;
                        if (AuthService.currentUser!.isAnonymous) {
                          showCustomDialog(
                              context: context,
                              title: "Unregitered User",
                              positiveButtonText: "login",
                              content: 'To rate this product, you need to login with your email and password or Google Account. To login with your account, go to Login Page',
                              onPressed: () {
                                Navigator.pushNamed(context, LoginPage.routeName);
                              });
                        } else {
                          EasyLoading.show(status: "Please Wait");
                          productProvider.addComment(productModel.productId!,
                              txtController.text, userProvider.userModel!);
                          EasyLoading.dismiss();
                          focusNode.unfocus();
                          showMsg(context, "Thanks your feedback");
                        }
                      },
                      child: const Text("Submit"),
                    )
                  ]
                )
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('All Comments'),
          ),
          FutureBuilder<List<CommentModel>>(
              future: productProvider.getCommentsByProduct(productModel.productId!),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  final commentList=snapshot.data!;
                  if(commentList.isEmpty){
                    return const Center(child: Text("No Comment found"),);
                  }else{
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: commentList.map((comment) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(comment.userModel.displayName ??
                                comment.userModel.email),
                            subtitle: Text(comment.date),
                            leading: comment.userModel.imageUrl == null
                                ? const Icon(Icons.person)
                                : CachedNetworkImage(
                              width: 70,
                              height: 100,
                              fit: BoxFit.fill,
                              imageUrl: comment.userModel.imageUrl!,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              comment.comment,
                            ),
                          ),
                        ],
                      ))
                          .toList(),
                    );
                  }
                }
                if(snapshot.hasError){
                  return const Text("Failed to load Comment");
                }
                return const Center(child: Text("Loading comments"));
              }
          )
        ],
      ),
    );
  }

}
