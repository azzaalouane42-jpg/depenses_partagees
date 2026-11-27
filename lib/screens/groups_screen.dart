import 'package:material_ui/material_ui.dart';
import 'create_group_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//cette classe représente la page des groupes
class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {

  //récupérer les groupes de l'utilisateur connecté
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FC),

      //barre supérieure
      appBar: AppBar(
        title: const Text('Mes groupes'),
        backgroundColor: const Color(0xFF9B59B6),
        foregroundColor: Colors.white,
      ),


      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            //récupérer et afficher les groupes depuis Firestore
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: groupesStream,

                builder: (context, snapshot) {

                  //vérifier le chargement
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  //vérifier les erreurs
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Erreur de chargement des groupes"),
                    );
                  }

                  //récupérer les groupes
                  final groupes = snapshot.data?.docs ?? [];

                  // Si aucun groupe n'existe
                  if (groupes.isEmpty) {
                    return const Center(
                      child: Text(
                        'Aucun groupe pour le moment',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                  //afficher la liste des groupes
                  return ListView.builder(
                    itemCount: groupes.length,
                    itemBuilder: (context, index) {

                      final groupe = groupes[index].data();


                      return Card(
                        color: Colors.white,
                        child: ListTile(
                          leading: const Icon(
                            Icons.group,
                            color: Color(0xFF9B59B6),
                          ),

                          title: Text(groupe['nom'] ?? ''),
                          subtitle: Text(groupe['description'] ?? ''),

                          // Bouton pour supprimer le groupe
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () async {

                              //demander confirmation avant la suppression
                              bool? confirmation = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Supprimer le groupe"),
                                  content: const Text(
                                    "Voulez-vous vraiment supprimer ce groupe ?",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, false);
                                      },
                                      child: const Text("Annuler"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, true);
                                      },
                                      child: const Text(
                                        "Supprimer",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );

                              // Supprimer le groupe de Firestore
                              if (confirmation == true) {
                                try {
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth.instance.currentUser!.uid)
                                      .collection('groups')
                                      .doc(groupes[index].id)
                                      .delete();

                                  if (!context.mounted) return;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Groupe supprimé avec succès"),
                                    ),
                                  );

                                } catch (e) {
                                  if (!context.mounted) return;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Erreur lors de la suppression : $e"),
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      );

                    },
                  );
                },
              ),
            ),

            // Bouton pour ajouter un groupe
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Ouvrir la page de création
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateGroupScreen(),
                    ),
                  );
                },

                icon: const Icon(Icons.group_add),
                label: const Text('Créer un groupe'),

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9B59B6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}