
import 'package:e_commerce/product_detail_screen.dart';
import 'package:e_commerce/signup_ganesh.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginGanesh extends StatefulWidget {
  const LoginGanesh({super.key});

  @override
  State<LoginGanesh> createState() => _LoginGaneshState();
}

class _LoginGaneshState extends State<LoginGanesh> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final _auth = FirebaseAuth.instance;
  var user;

  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      FirebaseAuth.instance.authStateChanges().listen((event) {
        if (event != null) {
          user = event;
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ProductDetailScreen()));
        }
      });
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildEmailTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: ((value) {
        if (!value!.contains('@') || value.isEmpty) {
          return 'Please enter a valid email address';
        }
        return null;
      }),
      controller: emailController,
      decoration: const InputDecoration(
          prefixIcon: Icon(Icons.email_outlined), hintText: 'E-mail ID'),
    );
  }

  Widget buildPasswordTextFormField() {
    return TextFormField(
      validator: ((value) {
        if (value!.length < 8 || value.isEmpty) {
          return 'Password must be atleast 8 Characters long.';
        }
        return null;
      }),
      controller: passwordController,
      decoration: const InputDecoration(
          prefixIcon: Icon(Icons.lock),
          hintText: 'Password',
          suffixIcon: Icon(Icons.visibility)),
    );
  }

  Widget buildRegisterButton() {
    return GestureDetector(
      // ignore: sort_child_properties_last
      child: Container(
        height: 40,
        width: double.infinity,
        // ignore: sort_child_properties_last
        child: Center(
            child: isLoading
                ? const CircularProgressIndicator()
                : const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  )),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.orange),
      ),
      onTap: _trySubmit,
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 65,
                ),
                const Text(
                  'Log in to get started',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text('Experience the all new App!'),
                const SizedBox(
                  height: 25,
                ),
                buildEmailTextFormField(),
                const SizedBox(
                  height: 25,
                ),
                buildPasswordTextFormField(),
                SizedBox(
                  height: 300
                ),
                buildRegisterButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
