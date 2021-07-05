import 'package:flutter/material.dart';
import 'package:meentenda/common/custom_drawer/custom_drawer.dart';
import 'package:meentenda/models/page_manager.dart';
import 'package:meentenda/models/user_manager.dart';
import 'package:meentenda/screens/admin_users/admin_users_screen.dart';
import 'package:meentenda/screens/home/home_screen.dart';
import 'package:meentenda/screens/manual/manual_screen.dart';
import 'package:meentenda/screens/products/products_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(
        builder: (_, userManager, __){
          return  PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
              HomeScreen(),
              ProductsScreen(),
              ManualScreen(),
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Home4'),
                ),
              ),
              //verificando se o usuário é administrador
              if(userManager.adminEnabled)
                ...[
              AdminUsersScreen(),
              Scaffold(
              drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Pedidos'),
                  ),
                ),
              ],
            ]
          );
          },
      ),
    );
  }
}