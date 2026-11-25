import 'package:material_ui/material_ui.dart';
//cette classe représente la page des groupes
class GroupsScreen extends StatelessWidget{
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FC),

      //barre supérieure
      appBar: AppBar(
        title: const Text('Mes groupes'),
        backgroundColor: const Color(0xFF9B59B6),
        foregroundColor: Colors.white,
      ),
      //contenu de la page
      body: const Center(
        child: Text('Aucun groupe pour le moment',
        style: TextStyle(fontSize: 18,color: Colors.grey,),
        ),
      ),
    );
  }
}