import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'homepage_state.dart';

class HomepageCubit extends Cubit<HomepageState> {
  HomepageCubit() : super(HomepageInitial());

  Future<void> getHomePage() async {
    try {
      emit(HomePageLoading());
      final prefs = await SharedPreferences.getInstance();
      final defaultHome = prefs.getString('defaultHome');
      if (defaultHome == 'Text' || defaultHome == null) {
        emit(HomePageText());
      } else {
        emit(HomePageMedia());
      }
    } catch (e) {
      emit(HomePageError());
    }
  }

  Future<void> changeHomePage(String currentPage) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('defaultHome', currentPage);
  }

  Future<void> getTextClipboard() async {
    emit(HomePageText());
  }

  Future<void> getMediaClipboard() async {
    emit(HomePageMedia());
  }
}
