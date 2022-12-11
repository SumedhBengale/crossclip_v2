import 'package:crossclip_v2/UI/MediaClipboard/mediaclipboard.dart';
import 'package:crossclip_v2/UI/Settings/settings.dart';
import 'package:crossclip_v2/UI/TextClipboard/textclipboard.dart';
import 'package:crossclip_v2/logic/homepage/cubit/homepage_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomepageCubit>(context).getHomePage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          //Todo: Change Elevated buttons to Toggle Buttons
          ElevatedButton(
              onPressed: () =>
                  {BlocProvider.of<HomepageCubit>(context).getTextClipboard()},
              child: const Text("Text")),
          ElevatedButton(
              onPressed: () =>
                  {BlocProvider.of<HomepageCubit>(context).getMediaClipboard()},
              child: const Text("Media")),
          ElevatedButton(
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Settings()))
            },
            child: const Icon(Icons.settings),
          ),
        ],
        title: const Text('Crossclip'),
      ),
      body: BlocBuilder<HomepageCubit, HomepageState>(
        builder: (context, state) {
          if (state is HomePageLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomePageText) {
            return const TextClipboard();
          } else if (state is HomePageMedia) {
            return const MediaClipboard();
          } else if (state is HomePageError) {
            return const Center(
              child: Text('Error'),
            );
          } else {
            return const TextClipboard();
          }
        },
      ),
    );
  }
}
