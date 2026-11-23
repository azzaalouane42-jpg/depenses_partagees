import 'package:flutter/material.dart';

//cette classe représente l'écran de création d'un groupe
class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState(){
    return _CreateGroupScreenState();
  }
}
class _CreateGroupScreenState extends State<CreateGroupScreen>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FC),

      //barre supérieure de l'écran
      appBar: AppBar(
        title: const Text('Créer un groupe'),
        backgroundColor: const Color(0xFF9B59B6),
        foregroundColor: Colors.white,
      ),
      //contenu principale
      body: const Center(
        child: Text('Nouveau groupe',
        style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,),
        ),
      ),
    );
  }
}