import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meentenda/models/item_size.dart';
import 'package:meentenda/models/product.dart';

class CartProduct extends ChangeNotifier{

  CartProduct.fromProduct(this.product){
    productID = product.id;
    quantity = 1;
    size = product.selectedSize.name;
  }

  CartProduct.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    productID = document.data['pid'] as String;
    quantity = document.data['quantity'] as int;
    size = document.data['size'] as String;

    firestore.document('products/$productID').get().then((doc){
      product = Product.fromDocument(doc);
      notifyListeners();
    });
  }

  final Firestore firestore = Firestore.instance;

  String id;
  String productID;
  int quantity;
  String size;


  Product product;

  ItemSize get itemSize{
    if(product == null) return null;
    return product.findSize(size);
  }

  num get totalPrice => unitPrice * quantity;

  num get unitPrice {
    if(product == null) return 0;
    return itemSize?.price ?? 0;
  }

  Map<String, dynamic> toCartItemMap()=> <String, dynamic>{
      'pid' : productID,
      'quantity' : quantity,
      'size' : size,
    };

  bool stackable(Product product){
    return product.id == productID && product.selectedSize.name == size;
  }

  void increment(){
    quantity++;
    notifyListeners();
  }

  void decrement(){
    quantity--;
    notifyListeners();
  }

  bool get hasStock{
    final size = itemSize;
    if(size == null) return false;
    return size.stock >= quantity;
  }

}