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
            children: [const SizedBox(height: 20),
            TextFormField(controller: passwordController,
            obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
                prefixIcon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(),
              ),
            ),
            ],
          ),
          ),
          ),),),);
  }
}