import 'package:firstapp/modules/shop_app/login_screen.dart';
import 'package:firstapp/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sala Market',
        ),
      ),
      body: TextButton(
        onPressed: () {
          CacheHelper.removeToken();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) {
              return ShopAppLoginScreen();
            }),
            (route) => false,
          );
        },
        child: const Text('SIGN OUT'),
      ),
    );
  }
}
