
import 'package:ecom_user_3/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../customwidgets/cart_bubble_view.dart';
import '../customwidgets/main_drawer.dart';
import '../customwidgets/product_grid_item_view.dart';
import '../models/category_model.dart';
import '../providers/order_provider.dart';
import '../providers/product_provider.dart';
import '../providers/user_provider.dart';

class ViewProductPage extends StatefulWidget {
  static const String routeName = '/viewproduct';
  const ViewProductPage({Key? key}) : super(key: key);

  @override
  State<ViewProductPage> createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {


  @override
  void didChangeDependencies() {
    Provider.of<ProductProvider>(context, listen: false).getAllCategories();
    Provider.of<ProductProvider>(context, listen: false).getAllProducts();
    Provider.of<ProductProvider>(context, listen: false).getAllPurchases();
    Provider.of<OrderProvider>(context, listen: false).getOrderConstants();
    Provider.of<UserProvider>(context, listen: false).getUserInfo();
    Provider.of<CartProvider>(context, listen: false).getAllCartItemsByUser();
    super.didChangeDependencies();
  }
  CategoryModel? categoryModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text('All Product'),
        actions: const [
          CartBubbleView(),
        ],
        centerTitle: true,
      ),

      body: Consumer<ProductProvider>(
        builder: (context, provider, child) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<CategoryModel>(
                isExpanded: true,
                hint: const Text('Select Category'),
                value: categoryModel,
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
                items: provider
                    .getCategoriesForFiltering()
                    .map((catModel) => DropdownMenuItem(
                          value: catModel,
                          child: Text(catModel.categoryName))).toList(),
                onChanged: (value) {
                  setState(() {
                    categoryModel = value;
                    print(categoryModel!.categoryName);
                  });
                  if (categoryModel!.categoryName == 'All') {
                    provider.productList;
                  } else {
                    provider.getAllProductsByCategory(categoryModel!.categoryName);
                  }
                },
              ),
            ),
            Expanded(
              child:GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65
                  ),
                  itemCount: provider.productList.length,
                  itemBuilder: (context,index){
                    final product=provider.productList[index];
                    return ProductGridItemView(productModel: product,);
                  }
              ),
            ),

          ],
        ),
      ),
    );
  }
}
