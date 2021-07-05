import 'package:flutter/material.dart';
import 'package:meentenda/models/home_manager.dart';
import 'package:meentenda/models/section.dart';
import 'package:meentenda/screens/home/components/item_tile.dart';
import 'package:meentenda/screens/home/components/seaction_header.dart';
import 'package:provider/provider.dart';

import 'add_tile_widget.dart';


class SectionList extends StatelessWidget {

  //construtor
  const SectionList(this.section);

  final Section section;

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();


    return ChangeNotifierProvider.value(
      value: section,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SectionHeader(),
            SizedBox(

              height: 170,
              child: Consumer<Section>(
                builder: (_, section, __){
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index){
                      if(index < section.items.length)
                        return ItemTile(section.items[index]);
                      else
                        return AddTileWidget();
                    },
                    separatorBuilder: (_,__) => const SizedBox(width: 5,),
                    itemCount: homeManager.editing
                        ? section.items.length + 1
                        : section.items.length,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
