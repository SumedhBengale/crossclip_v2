import 'dart:io';
import 'package:crossclip_v2/UI/Authentication/SignIn/signin.dart';
import 'package:crossclip_v2/UI/Homepage/HomePage.dart';
import 'package:crossclip_v2/hive_store.dart';
import 'package:crossclip_v2/logic/homepage/cubit/homepage_cubit.dart';
import 'package:firedart/auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  if (!Hive.isAdapterRegistered(42)) {
    Hive.registerAdapter(TokenAdapter());
  }
  FirebaseAuth.initialize(
      'AIzaSyBzKL8zgDPvwBqqTC4GgnvmIq3LFioO2tI', await HiveStore.create());
  // await firebaseAuth.signIn(email, password);
  // var user = await firebaseAuth.getUser();

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
        child: (FirebaseAuth.instance.isSignedIn)
            ? const HomePage()
            : const SignIn(),
      ),
    );
  }
}
