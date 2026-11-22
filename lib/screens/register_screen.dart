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
  // clé pour contrôler et valider le formulaire
  final _formKey = GlobalKey<FormState>();

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
          // formulaire pour valider les informations saisies
          child: Form(
            key: _formKey,
            child: Column(
            //contenu de la page d'inscription
            children: [
              //ajouter un espace en haut de la page
              const SizedBox(height: 30),

              //icone represente la création d'un nouveau compte
              const Icon(
                Icons.person_add_alt_1_rounded,
                size: 70,
                color: Color(0xFF9B59B6),
              ),
              //ajouter un espace entre l'icone et le titre
              const SizedBox(height: 15),

              //titre de la page d'inscription
              const Text('Créer un compte',
              textAlign: TextAlign.center,

                //définir le style du titre
                style: TextStyle(fontSize: 27,
                fontWeight: FontWeight.bold,
                  color: Color(0xFF663399),
                ),
              ),
              //ajouter un espace aprés le titre
              const SizedBox(height: 8),

              //text descriptif de la page
              const Text('Rejoignez vos groupes et partagez vos dépenses',
              textAlign: TextAlign.center,

                //définir le style du text
                style: TextStyle(fontSize: 14,color: Colors.grey,),
              ),
              //ajouter un espace avant les champs du formulaire
              const SizedBox(height: 35),

          //champ pour saisir le nom de l'utilisateur
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Nom",
                  //icone affichée au debut du champ
                  prefixIcon: const Icon(Icons.person_outline),
                  //définir la couleur de fond du champ
                  filled: true,
                  fillColor: Colors.white,
                  //définir les coins arrondis du champ
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
          //ajouter un espace après le champ nom
              const SizedBox(height: 20),
              // Champ pour saisir le prénom de l'utilisateur
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Prénom',
                  // Icône affichée au début du champ
                  prefixIcon: const Icon(Icons.person_outline),
                  // Définir la couleur de fond du champ
                  filled: true,
                  fillColor: Colors.white,
                  // Définir les coins arrondis du champ
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

            // Ajouter un espace après le champ prénom
              const SizedBox(height: 20),

          // Champ pour saisir l'adresse email de l'utilisateur.
          TextFormField(
            // Afficher le clavier adapté à la saisie d'un email.
            keyboardType: TextInputType.emailAddress,

            decoration: InputDecoration(
              labelText: 'Email',

              // Icône affichée au début du champ
              prefixIcon: const Icon(Icons.email_outlined),

              // Définir la couleur de fond du champ
              filled: true,
              fillColor: Colors.white,

              // Définir les coins arrondis du champ
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),

          // Ajouter un espace après le champ email
          const SizedBox(height: 20),

              //champ pour saisir le mot de passe
              TextFormField(
                //cacher le mot de passe
                obscureText: true,

                //définir l'apparence du champ
                decoration: InputDecoration(labelText: 'Mot de passe',

                  //icone affichée au début du champ
                  prefixIcon: const Icon(Icons.lock_outline),

                  //définir la couleur de fond du champ
                  filled: true,
                  fillColor: Colors.white,

                  //définir les coins arrondis du champ
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),),
                ),
              ),
              //ajouter un espace après le champ mot de passe
              const SizedBox(height: 20),

              //bouton pour créer un nouveau compte
              ElevatedButton(
                //action exécutée lorsque l'utilisateur clique sur le bouton
                onPressed:(){
                  //afficher un message aprés le clic
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Inscription bientot disponible'),
                      ),
                  );
              },
                //définir le style du bouton
                style: ElevatedButton.styleFrom(
                  //couleur de fond du bouton
                  backgroundColor: const Color(0xFF9B59B6),

                  //couleur du texte
                  foregroundColor: Colors.white,

                  //ajouter un espace a l'intérieur du bouton
                  padding: const EdgeInsets.symmetric(vertical: 16),

                  //définir les coins arrondis
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),
                  ),
                ),
                //texte affichée dans le bouton
                child: const Text('Créer mon compte',
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),
                ),
                ),
            ],
          ),
        ),

      ),),),
    );
  }
}