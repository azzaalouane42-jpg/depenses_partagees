import 'package:flutter/material.dart';

//cette classe représente l'écran d'inscription
//StatefulWidget permet de modifier l'écran selon les actions de l'utilisateur
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  //cette méthode crée l'état associé a RegisterScreen
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
//cette classe contient l'état et le fonctionnement de l'écran d'inscription
class _RegisterScreenState extends State<RegisterScreen>{

  //cette méthode construit l'interface graphique de la page
  @override
  Widget build(BuildContext context){
    return Scaffold(
      //couleur de fond de la page
      backgroundColor: const Color(0xFFF8F5FC),

      //SafeArea évite que le contenu soit caché par la barre du télephone
      body: SafeArea(child: Padding(
        //ajouter un espace de 24 pixels autour du contenu
          padding: const EdgeInsets.all(24),

        //permet de faire défiler la page si le contenu est trop grand
        child: SingleChildScrollView(
          child: Column(
            //Placer les élements de la page verticalement
            children: [
              //contenu de la page d'inscription
            ],
          ),
        ),

      ),),
    );
  }
}