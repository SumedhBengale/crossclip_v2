part of 'homepage_cubit.dart';

@immutable
abstract class HomepageState {}

class HomepageInitial extends HomepageState {}

class HomePageText extends HomepageState {}

class HomePageMedia extends HomepageState {}

class HomePageLoading extends HomepageState {}

class HomePageError extends HomepageState {}
