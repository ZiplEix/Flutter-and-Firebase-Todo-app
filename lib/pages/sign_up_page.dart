import 'package:flutter/material.dart';
import 'package:todo_app/Widgets/auth_widget.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/pages/phone_auth_page.dart';
import 'package:todo_app/pages/sign_in_page.dart';
import 'package:todo_app/services/auth_services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthClass authClass = AuthClass();

  bool circular = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              AuthButtonWidget(
                logoPath: "assets/google.svg",
                size: 25,
                textContent: "Continue with Google",
                action: () async {
                  await authClass.googleSignIn(context);
                },
              ),
              const SizedBox(height: 15),
              AuthButtonWidget(
                logoPath: "assets/phone.svg",
                textContent: "Continue with Mobile",
                size: 30,
                action: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const PhoneAuthPage()));
                },
              ),
              const SizedBox(height: 15),
              const Text(
                "Or",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 15),
              FormInputWidget(
                labelText: "Email ...",
                controller: _emailController,
                obscureText: false,
              ),
              const SizedBox(height: 15),
              FormInputWidget(
                labelText: "Password ...",
                controller: _passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 30),
              sendFormButton(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "If you already have an account ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const SignInPage()),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget sendFormButton() {
    return InkWell(
      onTap: () async {
        setState(() {
          circular = true;
        });
        try {
          firebase_auth.UserCredential userCredential =
              await firebaseAuth.createUserWithEmailAndPassword(
                  email: _emailController.text,
                  password: _passwordController.text);
          print(userCredential.user?.email);
          setState(() {
            circular = false;
          });
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => const HomePage()),
            (route) => false,
          );
        } catch (e) {
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            circular = false;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 100,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(colors: [
            Color(0xfffd746c),
            Color(0xffff9068),
            Color(0xfffd746c)
          ]),
        ),
        child: Center(
          child: circular
              ? const CircularProgressIndicator()
              : const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
        ),
      ),
    );
  }
}
