import 'package:flutter/material.dart';

//cette classe représente la page d'accueil
class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FC),

      //barre supérieur de la page
      appBar: AppBar(
        title: const Text('Dépenses Partagées'),
        backgroundColor: const Color(0xFF9B59B6),
        foregroundColor: Colors.white,
      ),
      //contenu principale de la page
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Message de bienvenue
            const Text('Bienvenue !👋',
              style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}