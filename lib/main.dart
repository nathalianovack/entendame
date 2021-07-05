import 'package:flutter/material.dart';
import 'package:meentenda/models/admins_user_manager.dart';
import 'package:meentenda/models/cart_manager.dart';
import 'package:meentenda/models/home_manager.dart';
import 'package:meentenda/models/product.dart';
import 'package:meentenda/models/product_manager.dart';
import 'package:meentenda/screens/base/base_screen.dart';
import 'package:meentenda/screens/cart/cart_screen.dart';
import 'package:meentenda/screens/edit_produtc/edit_product_screen.dart';
import 'package:meentenda/screens/login/login_screen.dart';
import 'package:meentenda/screens/product/product_screen.dart';
import 'package:meentenda/screens/select_product/select_product_screen.dart';
import 'package:meentenda/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';
import 'models/user_manager.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) => cartManager..updateUser(userManager),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          lazy: false,
          update: (_, userManager, adminUsersManager) => adminUsersManager..updateUser(userManager),
        )
      ],
      child: MaterialApp(
        title: 'Entenda Me',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 76, 142, 199),
          scaffoldBackgroundColor: const Color.fromARGB(255, 76, 142, 199),
          appBarTheme: const AppBarTheme(
              elevation: 0
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/base',
        onGenerateRoute: (settings){
          switch(settings.name){
            case '/login':
              return MaterialPageRoute <dynamic>(
                  builder: (_) => LoginScreen()
              );
            case '/edit_product':
              return MaterialPageRoute<dynamic>(
                  builder: (_) => EditProductScreen(settings.arguments as Product)
              );
            case '/signup':
              return MaterialPageRoute<dynamic>(
                  builder: (_) => SignUpScreen()
              );
            case '/select_product':
              return MaterialPageRoute<dynamic>(
                  builder: (_) => SelectProductScreen()
              );
            case '/cart':
              return MaterialPageRoute<dynamic>(
                  builder: (_) => CartScreen()
              );
            case '/product':
              return MaterialPageRoute<dynamic>(
                  builder: (_) => ProductScreen(settings.arguments as Product)
              );
            case '/base':
            default:
              return MaterialPageRoute<dynamic>(
                  builder: (_) => BaseScreen()
              );
          }
        },
      ),
    );
  }
}