import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';
import 'package:meentenda/models/item_size.dart';
import 'package:meentenda/models/product.dart';
import 'package:provider/provider.dart';

class SizeWidget extends StatelessWidget {

  SizeWidget({this.size});

  final ItemSize size;

  @override
  Widget build(BuildContext context) {
    final product = context.watch<Product>();
    final selected = size == product.selectedSize;

    Color color;
    if(!size.hasStock)
      color = Colors.red.withAlpha(50);
    else if (selected)
      color = Theme.of(context).primaryColor;
    else
      color = Colors.grey;

    return GestureDetector(
      onTap: (){
        if(size.hasStock){
          product.selectedSize = size;
        }
      },
      child: Container(
          decoration: BoxDecoration(
          border: Border.all(
            color: color,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              color: color,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Text(
                size.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
