import 'package:crossclip_v2/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_dart/firebase_dart.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String emailError = "";
  String passwordError = "";
  String confirmPasswordError = "";

  Future<void> signUp() async {
    if (emailError == 'none' &&
        passwordError == 'none' &&
        confirmPasswordError == 'none') {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

        await FirebaseAuth.instance.currentUser
            ?.sendEmailVerification()
            .then((user) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VerifyEmailPage(
                      emailController.text, passwordController.text)));
        });
      } else {
        //TODO: Passwords are not the same error message.
      }
    } else {
      //TODO: Invalid Email and Password error message.
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
            child: Text("Sign Up with Email",
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: 400,
              child: TextField(
                controller: confirmPasswordController,
                onChanged: (password) {
                  if (confirmPasswordController.text !=
                      passwordController.text) {
                    debugPrint(passwordController.text);
                    debugPrint(confirmPasswordController.text);
                    confirmPasswordError = "The Passwords must be the same";
                    setState(() {});
                  } else {
                    confirmPasswordError = "none";
                    setState(() {});
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm Password',
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
          (confirmPasswordError == "none" || confirmPasswordError == "")
              ? const SizedBox()
              : Text(confirmPasswordError,
                  style: const TextStyle(color: Colors.red)),
          InkWell(
            onTap: () {},
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
                    onPressed: () => {signUp()},
                    child: const Text("Sign Up")),
              ))
        ],
      ),
    ));
  }
}

//Verify Email Page

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage(this.email, this.password, {super.key});
  final String email;
  final String password;
  @override
  Widget build(BuildContext context) {
    debugPrint(email);
    debugPrint(password);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Verify Your Email"),
            const Text(
                "A verification email has been sent to your email address"),
            const Text("Please verify your email address and continue"),
            ElevatedButton(
                onPressed: () async {
                  print("$email $password");
                  await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: email, password: password)
                      .then((user) => {
                            if (user.user!.emailVerified)
                              {
                                print(user.user.toString()),
                                print("email verified"),
                                //This will return true or false
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const MyApp()))
                              }
                            else
                              {
                                //TODO: Email not verified error message.
                                print(user.user!.emailVerified.toString()),
                                debugPrint('email not verified')
                              }
                          })
                      .catchError((onError) {
                    debugPrint(onError.toString());
                    return onError;
                  });
                },
                child: const Text("Continue"))
          ],
        ),
      ),
    );
  }
}
