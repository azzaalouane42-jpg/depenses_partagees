import 'package:depenses_partagees/screens/home_screen.dart';
import 'package:flutter/material.dart';
//importer l'écran d"inscription
import 'register_screen.dart';


// Cette classe représente l'écran de connexion de l'application
// StatefulWidget permet de modifier l'écran pendant son utilisation
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  // Cette méthode crée l'état associé à LoginScreen
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
// Cette classe contient les variables et le fonctionnement de l'écran Login
class _LoginScreenState extends State<LoginScreen>{

  // Clé utilisée pour contrôler le formulaire et lancer la validation
  final _formKey = GlobalKey<FormState>();
  // Controller pour récupérer le texte saisi dans le champ Email
  final emailController = TextEditingController();
  // Controller pour récupérer le texte saisi dans le champ Mot de passe
  final passwordController = TextEditingController();

  // Variable booléenne pour cacher ou afficher le mot de passe
  // true = mot de passe caché ; false = mot de passe visible
  bool cachermotdepasse = true;

  // Cette méthode libère les ressources utilisées par les controllers
  // lorsque l'écran est supprimé
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  // Cette méthode construit l'interface graphique de l'écran
  @override
  Widget build(BuildContext context){
    return Scaffold(
      // Définir la couleur de fond de la page
      backgroundColor: const Color(0xFFF8F5FC),
      // SafeArea évite que le contenu soit caché par les barres du téléphone
      body: SafeArea(
        // Form regroupe les champs et permet de vérifier leur validité
      child: Form(key: _formKey,

        // Ajouter un espace autour du contenu de la page
          child: Padding(padding: const EdgeInsets.all(24),

            // Permet de faire défiler l'écran si le contenu est trop grand
          child:SingleChildScrollView(
            // Column organise les éléments verticalement
            child: Column(
            children: [
              // Ajouter un espace en haut de la page
              const SizedBox(height: 35),
              // Icône représentant les dépenses et le portefeuille
            const Icon(Icons.account_balance_wallet_rounded,
            size: 75,
              color: Color(0xFF9B59B6),
            ),
              // Ajouter un espace entre l'icône et le titre
            const SizedBox(height: 15),

              // Titre principal de l'application
            const Text('Dépenses Partagées',
            textAlign: TextAlign.center,
              style: TextStyle(fontSize: 27,
              fontWeight: FontWeight.bold,
                color: Color(0xFF663399),
              ),
            ),
              // Ajouter un espace après le titre
            const SizedBox(height: 8),

              // Texte descriptif de l'application
            const Text('Gérez vos dépenses facilement en groupe',
            textAlign: TextAlign.center,

              // Définir le style du texte descriptif
              style: TextStyle(fontSize: 14,color: Colors.grey,),
            ),
              // Ajouter un espace avant les champs de connexion
            const SizedBox(height: 40),

            //Email
              TextFormField(
                // Controller pour récupérer l'email saisi
                controller: emailController,

                // Afficher un clavier adapté à la saisie d'un email
                keyboardType: TextInputType.emailAddress,

                // Vérifier si l'email saisi est valide
                validator:(value){
                  // Vérifier si le champ est vide
                if(value ==null || value.isEmpty){
                  return 'Veuillez saisir votre email';
                }
                // Vérifier la présence de @ et d'un point
                if(!value.contains('@') || !value.contains('.')){
                  return 'Email invalide';
                }
                // null signifie que la validation est réussie
                return null;
               },
                // Définir l'apparence du champ Email
                decoration: InputDecoration(labelText: 'Email',
                  // Icône affichée au début du champ
                prefixIcon: const Icon(Icons.email_outlined),
                  // Activer la couleur de fond du champ
                  filled: true,
                  fillColor: Colors.white,
                  // Définir une bordure arrondie
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              // Ajouter un espace entre Email et Mot de passe
              const SizedBox(height: 20),

              //mot de passe
            TextFormField(
              // Controller pour récupérer le mot de passe saisi
              controller: passwordController,
              // Cacher ou afficher le texte selon la variable
            obscureText: cachermotdepasse,
              // Vérifier la validité du mot de passe
              validator: (value){
                // Vérifier si le champ est vide
                if(value ==null || value.isEmpty){
                  return 'Veuillez saisir votre mot de passe';
                }
                // Vérifier que le mot de passe contient au moins 6 caractères
                if(value.length < 6){
                  return 'Le mot de passe doit contenir au moins 6 caractéres';
                }
                // null signifie que la validation est réussie
                return null;
              },
              // Définir l'apparence du champ Mot de passe
              decoration: InputDecoration(
              labelText: 'Mot de passe',
                // Icône affichée au début du champ
              prefixIcon: const Icon(Icons.lock_outline),
                // Bouton permettant d'afficher ou cacher le mot de passe
              suffixIcon: IconButton(
                // Changer l'icône selon l'état du mot de passe
                icon: Icon(
                  cachermotdepasse
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                // Exécuter une action lorsque l'utilisateur clique sur l'œil
                onPressed: () {
                  // Actualiser l'interface après le changement de variable
                  setState(() {
                    // Inverser la valeur : true devient false et inversement
                    cachermotdepasse = !cachermotdepasse;
                  });
                },
              ),
                // Définir une bordure arrondie pour le champ
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
              // Ajouter un espace avant le bouton de connexion
              const SizedBox(height: 30),
              ElevatedButton(
                // Action exécutée lorsque l'utilisateur clique sur le bouton
                onPressed: (){
                  // Vérifier tous les champs du Form
                  if(_formKey.currentState!.validate()){
                    // Si les champs sont valides, ouvrir la page d'accueil
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),
                    ),);
                  }
              },
                // Définir le style du bouton
              style: ElevatedButton.styleFrom(
                // Couleur de fond du bouton
                backgroundColor: const Color(0xFF9B59B6),
                // Couleur du texte du bouton
              foregroundColor: Colors.white,
                // Ajouter un espace vertical à l'intérieur du bouton
                padding: const EdgeInsets.symmetric(vertical: 16),
                // Définir les coins arrondis du bouton
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
              ),
                // Texte affiché à l'intérieur du bouton
                child: const Text('Se connecter',
                  // Définir le style du texte du bouton
                  style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),),
              ),
              TextButton(
                onPressed: (){
                  //ouvrir la page d'inscription
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const RegisterScreen();
                      },
                    ),
                  );
                },
                //texte affichée dans le bouton
                child: const Text('Créer un compte',
                style: TextStyle(
                  color: Color(0xFF663399),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),

            ],
          ),
          ),
          ),),),);
  }
}