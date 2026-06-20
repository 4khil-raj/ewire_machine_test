part of 'home_screen_bloc.dart';

@immutable
sealed class HomeScreenState {}

final class HomeScreenInitial extends HomeScreenState {}

final class fetchedHomeScreenDatasState extends HomeScreenState {
  final List<ProductModel> products;
  final List<String> categories;

  fetchedHomeScreenDatasState({
    required this.products,
    required this.categories,
  });
}
