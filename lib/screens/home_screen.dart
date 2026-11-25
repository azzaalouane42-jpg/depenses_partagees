import 'package:flutter/material.dart';
import 'create_group_screen.dart';

//cette classe représente la page d'accueil
class HomeScreen extends StatefulWidget  {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FC),
      //barre de navigation en bas
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF9B59B6),
        unselectedItemColor: Colors.grey,
        currentIndex: 0,

        items: const[
          BottomNavigationBarItem(icon:Icon(Icons.home),label: 'Accueil',),
          BottomNavigationBarItem(icon:Icon(Icons.group),label: 'Groupes',),
          BottomNavigationBarItem(icon:Icon(Icons.wallet),label: 'Dépenses',),
          BottomNavigationBarItem(icon:Icon(Icons.bar_chart),label: 'Statistiques',),
          BottomNavigationBarItem(icon:Icon(Icons.person),label: 'Profil',),
        ],
      ),

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

            //carte du solde
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFF9B59B6),borderRadius: BorderRadius.circular(20),),
              child: const Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //titre de la carte
                Text('Mon solde',
                style: TextStyle(color: Colors.white,fontSize: 16,),
                ),
                SizedBox(height: 10),

                //montant du solde
                Text('0.000 DT',
                style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold,),
                ),
              ],
              ),
            ),
            //carte des dépenses du mois
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20),),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //titre de la carte
                  Text('Dépenses du mois',
                  style: TextStyle(fontSize: 16,color: Colors.grey,),
                  ),
                  SizedBox(height: 10),

                  //montant des dépenses
                  Text('0.000 DT',
                  style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color: Color(0xFF9B59B6),),),
                ],
              ),
            ),
            const SizedBox(height: 20),

             ElevatedButton.icon(
              //action du bouton
              onPressed:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateGroupScreen(),
                  ),
                );
              },

              //icone du bouton
              icon:const Icon(Icons.group_add),
              
              //texte du boutob
              label: const Text('Créer un groupe'),
              //style du bouton
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9B59B6),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}