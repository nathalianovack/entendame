import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';
import 'package:meentenda/models/product.dart';
import 'package:meentenda/models/user_manager.dart';
import 'package:provider/provider.dart';

import 'components/size_widget.dart';

// ignore: must_be_immutable
class ProductScreen extends StatefulWidget {

  ProductScreen(this.product);

  final Product product;

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController txtFala = TextEditingController();

  VoiceController controller = FlutterTextToSpeech.instance.voiceController();

  @override
  void initState(){
    controller.init();
  }

  @override
  Widget build(BuildContext context) {

    final primaryColor = Theme.of(context).primaryColor;

    return ChangeNotifierProvider.value(
      value: widget.product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.product.name),
          centerTitle: true,
          actions: <Widget>[
            Consumer<UserManager>(
              builder: (_, userManager, __){
                if(userManager.adminEnabled){
                  return IconButton(
                      icon: Icon(Icons.edit_outlined, color: Colors.transparent,),
                      onPressed: (){
                        Navigator.of(context).pushReplacementNamed('/edit_product', arguments: widget.product);
                  });
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            AspectRatio(
                aspectRatio: 1,
                child: Carousel(
                    images: widget.product.images.map((url){
                      return NetworkImage(url);
                    }).toList(),
                  dotSize: 0,
                  dotSpacing: 15,
                  dotPosition: DotPosition.bottomCenter,
                  dotBgColor: Colors.transparent,
                  dotColor: Colors.transparent,
                  autoplay: false,
            )
      ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    widget.product.name,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child:Column(
                      children: [
                        TextFormField(
                          controller: txtFala,
                          style: TextStyle(
                            fontSize: 30
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            labelText: 'Digite aqui o que está pensando\n\n',
                            labelStyle: TextStyle(
                              fontSize: 26
                            ),
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                        SizedBox(height: 16,),
                        SizedBox(
                          height: 50,
                          width: 300,
                          child: RaisedButton(
                            elevation: 5,
                            onPressed: (){
                              controller.setLanguage("pt-br");
                              controller.speak(txtFala.text, VoiceControllerOptions(speechRate: 0.5));
                            },
                            child: Text(
                              'Clique aqui para se expressar,\ndeixe o volume do celular alto.',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white
                              ),
                            ),
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
