import 'package:material_ui/material_ui.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //titre de la page
            const Text('Créer votre groupe',
          style: TextStyle(
            fontSize: 24,fontWeight: FontWeight.bold,),
          ),
            const SizedBox(height: 20),

            //champ pour saisir le nom du groupe
            TextFormField(
              decoration: InputDecoration(
                labelText: "Nom du groupe",
                hintText: 'Exemple: Voyage, Colocation...',
                prefixIcon: const Icon(Icons.group),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),),
                  filled: true,
                  fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            //champ pour décrire le groupe
            TextFormField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Description",
                hintText: 'Décrire votre groupe..',
                prefixIcon: const Icon(Icons.description),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),),
                filled: true,
                fillColor: Colors.white,
              ),
              ),
            const SizedBox(height: 20),
            //champ pour saisir le budget du groupe
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Budget du groupe",
                hintText: "Exemple : 500 DT",
                prefixIcon: const Icon(Icons.account_balance_wallet),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            //bouton pour créer le groupe
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: (){
                  //action a exécuter lors de la création du groupe
                },
              icon: const Icon(Icons.group_add),
                label:const Text("Créer le groupe"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9B59B6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                ),),
              ),
          ],
        ),

      ),
    );
  }
}