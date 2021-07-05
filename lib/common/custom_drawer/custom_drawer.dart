import 'package:flutter/material.dart';
import 'package:meentenda/common/custom_drawer/custom_drawer_header.dart';
import 'package:meentenda/common/custom_drawer/drawer_tile.dart';
import 'package:meentenda/models/user_manager.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
               colors: [const Color.fromARGB(208, 144, 180, 219),
               Colors.white30,
               ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            ),
          ),
          ListView(
            children: <Widget>[
              CustomDrawerHeader(),
              const Divider(),
              DrawerTile(
                iconData: Icons.home_outlined,
                title: 'Página Inicial',
                page: 0,),
              /*DrawerTile(
                iconData: Icons.format_list_bulleted_outlined,
                title: 'Produtos',
                page: 1,),
              */DrawerTile(
                iconData: Icons.help_outline,
                title: 'Manual Entenda Me',
                page: 2,),
              /*DrawerTile(
                iconData: Icons.location_on,
                title: 'Loja',
                page: 3  ,
              ),*/
              //habilitando itens de adminitradores do app
              Consumer<UserManager>(
                builder: (_, userManager, __){
                  if(userManager.adminEnabled){
                    return Column(
                      children: <Widget>[
                        const Divider(),
                        /*DrawerTile(
                          iconData: Icons.people_alt_outlined,
                          title: 'Usuários',
                          page: 4,),
                        DrawerTile(
                          iconData: Icons.fact_check_outlined,
                          title: 'Pedidos',
                          page: 5  ,
                        ),*/
                      ],
                    );
                    } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
