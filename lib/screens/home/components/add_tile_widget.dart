import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meentenda/models/section.dart';
import 'package:meentenda/models/section_item.dart';
import 'package:meentenda/screens/edit_produtc/components/image_souce_sheet.dart';
import 'package:provider/provider.dart';

class AddTileWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final section = context.watch<Section>();

    void onImageSelected(File file){
      section.addItem(SectionItem(image: file));
      Navigator.of(context).pop();

    }


    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: (){
          showModalBottomSheet <void>(
              context: context,
              builder: (context) => ImageSourceSheet(onImageSelected: onImageSelected,));

        },
        child: Container(
          color: Colors.white.withAlpha(30),
          child: Icon(
            Icons.add_a_photo_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
