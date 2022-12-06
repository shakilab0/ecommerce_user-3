import 'package:flutter/material.dart';

class PromoCodePage extends StatelessWidget {
  static const String routeName = '/promo';
  const PromoCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final code = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: const Text('My Promo Codes'),),
      body: Center(
        child: Text(code, style: Theme.of(context).textTheme.headline6,),
      ),
    );
  }
}
