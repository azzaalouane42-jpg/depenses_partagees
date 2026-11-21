import 'package:flutter/material.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen>{
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool cachermotdepasse = true;

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FC),
      body: SafeArea(
      child: Form(key: _formKey,
          child: Padding(padding: const EdgeInsets.all(24),
          child:SingleChildScrollView(child: Column(
            children: [const SizedBox(height: 35),
            const Icon(Icons.account_balance_wallet_rounded,
            size: 75,
              color: Color(0xFF9B59B6),
            ),
            const SizedBox(height: 15),
            const Text('Dépenses Partagées',
            textAlign: TextAlign.center,
              style: TextStyle(fontSize: 27,
              fontWeight: FontWeight.bold,
                color: Color(0xFF663399),
              ),
            ),
            const SizedBox(height: 8),
            const Text('Gérez vos dépenses facilement en groupe',
            textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14,color: Colors.grey,),
            ),
            const SizedBox(height: 40),

            //Email
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'Email',
                prefixIcon: const Icon(Icons.email_outlined),
                  filled: true,
                  fillColor: Colors.white,
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              //mot de passe
            TextFormField(
              controller: passwordController,
            obscureText: cachermotdepasse,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(icon: Icon(
                    cachermotdepasse
                        ? Icons.visibility_off
                        : Icons.visibility,
                ),
                  onPressed: () {
                    setState(() {
                      cachermotdepasse = !cachermotdepasse;
                    });
                  },
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
                ),),
              ),
              const SizedBox(height: 30),
              ElevatedButton(onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:
                Text('La connexion sera bientot disponible'),
                ),);
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF9B59B6),
              foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
              ),
                child: const Text('Se connecter',style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),),
              ),

            ],
          ),
          ),
          ),),),);
  }
}