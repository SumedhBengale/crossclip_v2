import 'package:crossclip_v2/UI/Authentication/SignUp/signup.dart';
import 'package:crossclip_v2/main.dart';
import 'package:firebase_dart/firebase_dart.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String emailError = "";
  String passwordError = "";

  void signIn() {
    if (emailError == 'none' && passwordError == 'none') {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) => Navigator.push(
              context, MaterialPageRoute(builder: (context) => const MyApp())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("Sign In with Email",
                style: Theme.of(context).textTheme.headlineMedium),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
                width: 400,
                child: TextField(
                  controller: emailController,
                  onChanged: (email) {
                    if (email.isEmpty ||
                        !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
                            .hasMatch(email)) {
                      emailError = "Please enter a valid email";
                      setState(() {});
                    } else {
                      emailError = "none";
                      setState(() {});
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: 400,
              child: TextField(
                controller: passwordController,
                onChanged: (password) {
                  if (password.isEmpty ||
                      !RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$")
                          .hasMatch(password)) {
                    passwordError =
                        "The Password should contain atleast 8 characters,at least 1 alphabet, 1 number and 1 special character";
                    setState(() {});
                  } else {
                    passwordError = "none";
                    setState(() {});
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
          ),
          (emailError == "none" || emailError == "")
              ? const SizedBox()
              : Text(emailError, style: const TextStyle(color: Colors.red)),
          (passwordError == "none" || passwordError == "")
              ? const SizedBox()
              : Text(passwordError, style: const TextStyle(color: Colors.red)),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignUp()));
            },
            child: const Text("Don't have an Account? Sign Up",
                style: TextStyle(color: Colors.blue)),
          ),
          Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: 100,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ))),
                    onPressed: () => {signIn()},
                    child: const Text("Sign In")),
              ))
        ],
      ),
    ));
  }
}
