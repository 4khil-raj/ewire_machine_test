part of 'home_screen_bloc.dart';

@immutable
sealed class HomeScreenEvent {}

final class LoadProductsEvent extends HomeScreenEvent {}
