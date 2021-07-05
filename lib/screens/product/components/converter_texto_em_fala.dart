import 'package:flutter/material.dart';
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';

class ConverterTextoEmFala extends StatelessWidget {

  TextEditingController txtFala = TextEditingController();
  VoiceController controller = FlutterTextToSpeech.instance.voiceController();

  // ignore: must_call_super
  Future<void> initState() async => controller.init();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFormField(
            controller: txtFala,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20)
            ),
          ),
          RaisedButton(
            onPressed: (){
              controller.setLanguage("pt-br");
              controller.speak(txtFala.text);
            },
            child: Text(
                'Clique aqui para Falar',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white
            ),),
          )
        ],
      ),
    );
  }
}



/*Wrap(
spacing: 8,
runSpacing: 8,
children: product.sizes.map((s) {
return ConverterTextoEmFala();
}).toList(),
),*/