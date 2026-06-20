import 'package:bloc/bloc.dart';
import 'package:ewire_machine_test/model/product_model.dart';
import 'package:ewire_machine_test/service/products_fetching.dart';
import 'package:meta/meta.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitial()) {
    on<HomeScreenEvent>((event, emit) {});
    on<LoadProductsEvent>((event, emit) async {
      final result = await ProductsFetching.fetch();
      emit(
        fetchedHomeScreenDatasState(
          products: result['products'],
          categories: result['categories'],
        ),
      );

      print(result['categories'][2]);
    });
  }
}
