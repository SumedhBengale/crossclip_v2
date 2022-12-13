import 'package:crossclip_v2/UI/Authentication/SignIn/signin.dart';
import 'package:crossclip_v2/UI/Homepage/HomePage.dart';
import 'package:crossclip_v2/logic/homepage/cubit/homepage_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_dart/firebase_dart.dart';
import 'package:firebase_dart_flutter/firebase_dart_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseDartFlutter.setup();
  var options = const FirebaseOptions(
      apiKey: "AIzaSyBzKL8zgDPvwBqqTC4GgnvmIq3LFioO2tI",
      authDomain: "crossclip-271415.firebaseapp.com",
      projectId: "crossclip-271415",
      storageBucket: "crossclip-271415.appspot.com",
      messagingSenderId: "535545675507",
      appId: "1:535545675507:web:09036ef05c8dec850b4186",
      measurementId: "G-7FV669JYZW");

  FirebaseApp app = await Firebase.initializeApp(options: options);
  FirebaseAuth.instanceFor(app: app);
  FirebaseDatabase(
      app: app,
      databaseURL: 'https://crossclip-271415-default-rtdb.firebaseio.com/');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CrossClip 2.0',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => HomepageCubit(),
        child: (FirebaseAuth.instance.currentUser != null)
            ? const HomePage()
            : const SignIn(),
      ),
    );
  }
}
