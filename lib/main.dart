
import 'package:ecom_user_3/pages/cart_page.dart';
import 'package:ecom_user_3/pages/checkout_page.dart';
import 'package:ecom_user_3/pages/launcher_page.dart';
import 'package:ecom_user_3/pages/login_page.dart';
import 'package:ecom_user_3/pages/order_page.dart';
import 'package:ecom_user_3/pages/order_successful_page.dart';
import 'package:ecom_user_3/pages/otp_verification_page.dart';
import 'package:ecom_user_3/pages/product_details_page.dart';
import 'package:ecom_user_3/providers/cart_provider.dart';
import 'package:ecom_user_3/providers/product_provider.dart';
import 'package:ecom_user_3/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'pages/user_profile_page.dart';
import 'pages/view_product_page.dart';
import 'providers/order_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ProductProvider()),
    ChangeNotifierProvider(create: (_) => OrderProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => CartProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: EasyLoading.init(),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName: (_) => const LauncherPage(),
        LoginPage.routeName: (_) => const LoginPage(),
        ViewProductPage.routeName: (_) => const ViewProductPage(),
        ProductDetailsPage.routeName: (_) => const ProductDetailsPage(),
        OrderPage.routeName: (_) => const OrderPage(),
        UserProfilePage.routeName: (_) => const UserProfilePage(),
        OtpVerificationPage.routeName: (_) => const OtpVerificationPage(),
        CartPage.routeName: (_) => const CartPage(),
        CheckoutPage.routeName: (_) => const CheckoutPage(),
        OrderSuccessfulPage.routeName: (_) => const OrderSuccessfulPage(),
      },
    );
  }
}
