import 'package:crossclip_v2/logic/homepage/cubit/homepage_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String? defaultHome;
  Future<String> getDefaultPage() async {
    final prefs = await SharedPreferences.getInstance();
    defaultHome = prefs.getString('defaultHome');
    setState(() {});
    if (defaultHome == 'Text' || defaultHome == null) {
      return 'Text';
    } else {
      return 'Media';
    }
  }

  @override
  initState() {
    getDefaultPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: BlocProvider(
          create: (context) => HomepageCubit(),
          child: Column(
            children: [
              const Text("Select the Default Clipboard"),
              BlocBuilder<HomepageCubit, HomepageState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      DropdownButton(
                        value: defaultHome,
                        items: const [
                          DropdownMenuItem(
                            value: "Text",
                            child: Text("Text"),
                          ),
                          DropdownMenuItem(
                            value: "Media",
                            child: Text("Media"),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            defaultHome = value.toString();
                          });
                          debugPrint(value.toString());
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<HomepageCubit>(context)
                              .changeHomePage(defaultHome!);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Preferences Saved"),
                            ),
                          );
                        },
                        child: const Text("Save"),
                      )
                    ],
                  );
                },
              )
            ],
          ),
        ));
  }
}
