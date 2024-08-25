// category_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurent_app/blocs/menu_bloc/category/category_event.dart';
import 'package:restaurent_app/model/category_model.dart';
import 'package:restaurent_app/model/product_model.dart';
import 'package:restaurent_app/repository/category_repository.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc({required this.categoryRepository}) : super(CategoryLoading()) {
    on<LoadCategories>((event, emit) async {
      try {
        // Check if there are existing categories
        print("##########");
        final categories = await categoryRepository.fetchAllCategories();
        if (categories.isEmpty) {
          // If no categories, insert dummy data
          await categoryRepository.bulkInsertCategories(_dummyCategories());
        }

        // Fetch categories again after insertion
        final updatedCategories = await categoryRepository.fetchAllCategories();
        final categoryProducts = <int, List<Product>>{};
        for (var category in updatedCategories) {
          final products =
              await categoryRepository.fetchProductsByCategory(category.id);
          categoryProducts[category.id] = products;
        }
        emit(CategoryLoaded(updatedCategories, categoryProducts));
      } catch (_) {
        print(_);
        emit(CategoryOperationFailure());
      }
    });

    on<LoadCategoryProducts>((event, emit) async {
      try {
        final products =
            await categoryRepository.fetchProductsByCategory(event.categoryId);
        if (state is CategoryLoaded) {
          final currentState = state as CategoryLoaded;
          final updatedProducts =
              Map<int, List<Product>>.from(currentState.categoryProducts);
          updatedProducts[event.categoryId] = products;
          emit(CategoryLoaded(currentState.categories, updatedProducts));
        }
      } catch (_) {
        emit(CategoryOperationFailure());
      }
    });
  }

  // Dummy categories and products
  List<Category> _dummyCategories() {
    return List.generate(6, (index) {
      return Category(
        id: index + 1,
        name: 'Category ${index + 1}',
        productList: List.generate(6, (prodIndex) {
          return Product(
            id: (index * 6) + prodIndex + 1,
            name: 'Product ${(index * 6) + prodIndex + 1}',
            price: (prodIndex + 1) * 10,
            categoryId: index + 1,
          );
        }),
      );
    });
  }
}
