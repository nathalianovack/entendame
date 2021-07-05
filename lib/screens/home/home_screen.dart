import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meentenda/common/custom_drawer/custom_drawer.dart';
import 'package:meentenda/models/home_manager.dart';
import 'package:meentenda/models/user_manager.dart';
import 'package:provider/provider.dart';

import 'components/add_section_widget.dart';
import 'components/section_list.dart';
import 'components/section_staggered.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: const[
                  Color.fromARGB(255, 76, 142, 199),
                  Color.fromARGB(255, 76, 142, 199),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            ),
          ),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              snap: true,
              floating: true,
              flexibleSpace: const FlexibleSpaceBar(
                title: Text('ENTENDA ME'),
                centerTitle: true,
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.shopping_cart_outlined),
                  color: Colors.transparent,
                  onPressed: () => Navigator.of(context).pushNamed('/cart'),
                ),
                Consumer2<UserManager, HomeManager>(
                  builder: (_, userManager, homeManager, __){
                    if(userManager.adminEnabled && !homeManager.loading){
                      if(homeManager.editing){
                        return PopupMenuButton(
                          elevation: 80,
                          color: Theme.of(context).primaryColor,
                          onSelected: (String e){
                            if(e == 'Salvar'){
                              homeManager.saveEditing();
                            } else {
                              homeManager.discardEditing();
                            }
                          },
                            itemBuilder: (_){
                              return ['Salvar','Descartar'].map((e){
                                return PopupMenuItem(
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 25,
                                    ) ,),
                                  value: e,
                                );
                              }).toList();
                            }
                        );
                      }else {
                        return IconButton(
                            icon: Icon(Icons.edit_outlined, color: Colors.transparent,),
                            onPressed: homeManager.enterEditing,
                        );
                      }
                    }else
                      return Container();
                  },
                )
              ],
            ),
            Consumer<HomeManager>(
              builder: (_, homeManager, __){
                if(homeManager.loading){
                  return SliverToBoxAdapter(
                    child: LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                      backgroundColor: Colors.transparent,
                    ),
                  );
                }
                //transformar cada seção em Widget
                final List<Widget> children = homeManager.sections.map<Widget>(
                        (section) {
                          //verificando o tipo de seção
                          switch(section.type){
                            case 'List':
                              return SectionList(section);
                            case 'Staggered' :
                              return SectionStaggered(section);
                            default:
                              return Container();
                          }
                        }
                ).toList();

                if(homeManager.editing)
                  children.add(AddSectionWidget(homeManager));


                return SliverList(
                    delegate: SliverChildListDelegate(children),
                );
              },
            )
          ],
        ),
      ],
      ),
    );
  }
}
