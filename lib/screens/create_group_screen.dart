import 'package:material_ui/material_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//cette classe représente l'écran de création d'un groupe
class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState(){
    return _CreateGroupScreenState();
  }
}
class _CreateGroupScreenState extends State<CreateGroupScreen>{
  //controllers pour récupérer les informations saisies
  final TextEditingController nomController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();

  //fonction pour enregistrer un groupe dans firebase
  Future<void> enregistrerGroupe() async {

    //récupérer les informations saisies
    String nom = nomController.text.trim();
    String description = descriptionController.text.trim();
    String budget = budgetController.text.trim();

    //vérifier le nom du groupe
    if (nom.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Veuillez saisir le nom du groupe"),
        ),
      );
      return;
    }

    // récupérer l'utilisateur connecté
    User? utilisateur = FirebaseAuth.instance.currentUser;

    if (utilisateur == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Veuillez vous connecter"),
        ),
      );
      return;
    }

    try {
      //enregistrer le groupe dans Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(utilisateur.uid)
          .collection('groups')
          .add({
        'nom': nom,
        'description': description,
        'budget': budget,
        'dateCreation': FieldValue.serverTimestamp(),
      });

      //retourner à la page précédente
      if (!mounted) return;

      Navigator.pop(context, {
        'nom': nom,
        'description': description,
        'budget': budget,
      });

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erreur lors de la création : $e"),
        ),
      );
    }
  }

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
              controller: nomController,
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
              controller: descriptionController,
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
              controller: budgetController,
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
                onPressed: () {
                  enregistrerGroupe();
                  // Récupérer les informations saisies
                  String nom = nomController.text.trim();
                  String description = descriptionController.text.trim();
                  String budget = budgetController.text.trim();

                  // Vérifier que le nom du groupe n'est pas vide
                  if (nom.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Veuillez saisir le nom du groupe"),
                      ),
                    );
                    return;
                  }

                  // Retourner les informations vers la page précédente
                  Navigator.pop(context, {
                    'nom': nom,
                    'description': description,
                    'budget': budget,
                  });
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