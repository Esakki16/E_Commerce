import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/login_ganesh.dart';
import 'package:e_commerce/product_detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpGanesh extends StatefulWidget {
  const SignUpGanesh({super.key});

  @override
  State<SignUpGanesh> createState() => _SignUpGaneshState();
}

class _SignUpGaneshState extends State<SignUpGanesh> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
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
      print('1');
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      print('2');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set({
        'name': nameController.text,
        'email': emailController.text,
        'mobile number': mobileNumberController.text,
      });
      FirebaseAuth.instance.authStateChanges().listen((event) {
        if (event != null) {
          user = event;
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ProductDetailScreen()));
        }
      });
      print('3');
      setState(() {
        isLoading = false;
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: ((context) => ProductDetailScreen())));
      });
    }
  }

  Widget buildNameTextFormField() {
    return TextFormField(
      validator: ((value) {
        if (value!.length < 2 || value.isEmpty) {
          return 'Please enter a Name';
        }
        return null;
      }),
      controller: nameController,
      decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person_outline), hintText: 'Name'),
    );
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

  Widget buildMobileNumberTextformField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      validator: ((value) {
        if (value!.length < 10 || value.isEmpty) {
          return 'Please enter a valid number';
        }
        return null;
      }),
      controller: mobileNumberController,
      decoration: const InputDecoration(
          prefixIcon: Icon(Icons.phone), hintText: 'Mobile Number'),
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

  Widget buildConfirmPasswordTextFormField() {
    return TextFormField(
      validator: ((value) {
        if (value == passwordController) {
          return 'Password do not match';
        }
        return null;
      }),
      controller: confirmPasswordController,
      decoration: const InputDecoration(
          prefixIcon: Icon(Icons.lock),
          hintText: 'Confirm Password',
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
                    'REGISTER',
                    style: TextStyle(color: Colors.white),
                  )),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.orange),
      ),
      onTap: _trySubmit,
    );
  }

  Widget buildLoginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an account?'),
        TextButton(
            onPressed: (() => Navigator.push(context,
                MaterialPageRoute(builder: ((context) => LoginGanesh())))),
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.black),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 65,
              ),
              const Text(
                'Register in to get started',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text('Experience the all new App!'),
              const SizedBox(
                height: 25,
              ),
              buildNameTextFormField(),
              const SizedBox(
                height: 25,
              ),
              buildEmailTextFormField(),
              const SizedBox(
                height: 25,
              ),
              buildMobileNumberTextformField(),
              const SizedBox(
                height: 25,
              ),
              buildPasswordTextFormField(),
              const SizedBox(
                height: 25,
              ),
              buildConfirmPasswordTextFormField(),
              const SizedBox(
                height: 40,
              ),
              buildRegisterButton(),
              const SizedBox(
                height: 25,
              ),
              buildLoginButton(),
            ],
          ),
        ),
      )),
    );
  }
}
