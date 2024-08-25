// category_event.dart
import 'package:restaurent_app/model/category_model.dart';
import 'package:restaurent_app/model/product_model.dart';

abstract class CategoryEvent {}

class LoadCategories extends CategoryEvent {}

class LoadCategoryProducts extends CategoryEvent {
  final int categoryId;
  LoadCategoryProducts(this.categoryId);
}

// category_state.dart
abstract class CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;
  final Map<int, List<Product>> categoryProducts;
  CategoryLoaded(this.categories, this.categoryProducts);
}

class CategoryOperationFailure extends CategoryState {}
