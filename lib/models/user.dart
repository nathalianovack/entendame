import 'package:cloud_firestore/cloud_firestore.dart';

/*class Usuarios {

  Usuarios({this.email, this.senha, this.name, this.id, Usuarios usuarios, Usuarios usuarios2});

  Usuarios.fromDocument(DocumentSnapshot doc){
    id = doc.id;
    name = doc.data()['name'].toString();
    email = doc.data()['email'].toString();
  }

  String id;
  String name;
  String email;
  String senha;

  String ConfirmarSenha;

  DocumentReference get firestoreRef => FirebaseFirestore.instance.doc('usuarios/$id');

  Future<void> saveData() async{
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap(){
    return{
      'name': name,
      'email': email,
    };
  }
}*/
class User {

  User({this.email, this.password, this.name, this.id});

  User.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document.data['name'] as String;
    email = document.data['email'] as String;
  }

  String id;
  String name;
  String email;
  String password;
  String confirmPassword;

  bool admin = false;

  DocumentReference get firestoreRef =>
      Firestore.instance.document('users/$id');

  CollectionReference get cartReference => firestoreRef.collection('cart');

  Future<void> saveData() async {
    await firestoreRef.setData(toMap());
  }
  Map<String, dynamic> toMap()=> <String, dynamic> {
      'name': name,
      'email': email,
    };
}