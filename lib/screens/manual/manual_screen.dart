import 'package:flutter/material.dart';
import 'package:meentenda/common/custom_drawer/custom_drawer.dart';

class ManualScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Manual Entenda Me'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          color: Colors.white70,
          elevation: 50,
          child: Padding(
            padding: const EdgeInsets.only(top: 8,left: 8,right: 8,bottom: 8),
            child: Text(
              '\n       Passo a Passo de como usar o aplicativo\n\n\n  1.Abra o Aplicativo\n\n  2.Na tela inicial do aplicativo, escolha uma imagem e clique para abrir\n\n  3.Na Tela da Imagem escreva o que está sentindo\n\n  4.Clique no botão para se expressar\n\n\n    Lembre-se de deixar o volume do celular sempre alto, pois ao apertar o botão uma voz irá dizer o que está escrito!\n\n\n\n            Obrigada por utilizar o Entenda Me\n             Aproveite e comunique-se muito.',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 22,
                fontWeight: FontWeight.w400
              ),
            ),
          ),
        ),
      ),
    );
  }
}
