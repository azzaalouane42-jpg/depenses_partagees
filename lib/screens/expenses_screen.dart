import 'package:material_ui/material_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//cette classe représente la page des dépenses
class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}
class _ExpensesScreenState extends State<ExpensesScreen> {

//controleur du nom
  final TextEditingController nomController = TextEditingController();
//controleur du montant
  final TextEditingController montantController = TextEditingController();
  // Groupe sélectionné pour la dépense
  String? groupeSelectionneId;
  String? groupeSelectionneNom;

//récupérer les groupes depuis firebase
  Stream<QuerySnapshot<Map<String, dynamic>>> get groupesStream {
    User? utilisateur = FirebaseAuth.instance.currentUser;

    if (utilisateur == null) {
      return const Stream.empty();
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(utilisateur.uid)
        .collection('groups')
        .snapshots();
  }
  //récupérer les dépenses depuis Firebase
  Stream<QuerySnapshot<Map<String, dynamic>>> get depensesStream {
    User? utilisateur = FirebaseAuth.instance.currentUser;
    if (utilisateur == null) {
      return const Stream.empty();
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(utilisateur.uid)
        .collection('expenses')
        .snapshots();
  }
//fonction pour afficher le formulaire d'ajout
  void afficherFormulaireDepense() {
    //vider les anciens champs
    nomController.clear();
    montantController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ajouter une dépense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              //champ du nom de la dépense
              TextField(
                controller: nomController,
                decoration: const InputDecoration(
                  labelText: 'Nom de la dépense',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),

              //choisir le groupe de la dépense
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: groupesStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Text(
                      'Aucun groupe disponible',
                    );
                  }
                  final groupes = snapshot.data!.docs;

                  return DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Choisir un groupe',
                      border: OutlineInputBorder(),
                    ),
                    initialValue: groupeSelectionneId,
                    items: groupes.map((groupe) {
                      return DropdownMenuItem<String>(
                        value: groupe.id,
                        child: Text(groupe['nom']),
                      );
                    }).toList(),
                    onChanged: (valeur) {
                      setState(() {
                        groupeSelectionneId = valeur;
                        final groupe = groupes.firstWhere(
                              (g) => g.id == valeur,
                        );
                        groupeSelectionneNom = groupe['nom'];
                      });
                    },
                  );
                },
              ),
              //champ du montant
              TextField(
                controller: montantController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Montant (DT)',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () async {
                //récupérer les informations saisies
                String nom = nomController.text.trim();
                String montant = montantController.text.trim();

                //vérifier les champs
                if (nom.isEmpty || montant.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Veuillez remplir tous les champs'),
                    ),
                  );
                  return;}
                //vérifier si un groupe est sélectionné
                if (groupeSelectionneId == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Veuillez choisir un groupe'),
                    ),
                  );
                  return;
                }
                //vérifier le montant
                double? valeur = double.tryParse(montant.replaceAll(',', '.'));
                if (valeur == null || valeur <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Veuillez saisir un montant valide'),
                    ),
                  );
                  return;
                }
                // Enregistrer la dépense dans Firebase
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('expenses')
                    .add({
                  'nom': nom,
                  'montant': valeur,
                  'groupeId': groupeSelectionneId,
                  'groupeNom': groupeSelectionneNom,
                  'dateCreation': FieldValue.serverTimestamp(),
                });
                //fermer le formulaire
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FC),
      //barre supérieure
      appBar: AppBar(
        title: const Text('Mes dépenses'),
        backgroundColor: const Color(0xFF9B59B6),
        foregroundColor: Colors.white,
      ),
      //contenu de la page
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: depensesStream,
        builder: (context, snapshot) {

          //afficher le chargement
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          //afficher une erreur
          if (snapshot.hasError) {
            return const Center(
              child: Text('Erreur lors du chargement des dépenses'),
            );
          }
          //récupérer les dépenses
          final documents = snapshot.data?.docs ?? [];

          //vérifier si la liste est vide
          if (documents.isEmpty) {
            return const Center(
              child: Text(
                'Aucune dépense pour le moment',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
          //afficher la liste des dépenses
          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final depense = documents[index];

              return Card(
                color: Colors.white,
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFF0E4F5),
                    child: Icon(
                      Icons.receipt_long,
                      color: Color(0xFF9B59B6),
                    ),
                  ),
                  title: Text(depense['nom'] ?? ''),
                  subtitle: Text(
                    '${depense['montant']} DT',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),

                    onPressed: () async {
                      try {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('expenses')
                            .doc(depense.id)
                            .delete();
                       } catch (e){
                        if(!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Erreur lors de la suppression de la dépense'),),
                        );
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      //bouton pour ajouter une dépense
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //afficher le formulaire d'ajout d'une dépense
          afficherFormulaireDepense();
        },
        backgroundColor: const Color(0xFF9B59B6),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),),
    );
  }
}
