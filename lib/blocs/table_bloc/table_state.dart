import 'package:equatable/equatable.dart';
import 'package:restaurent_app/model/table_model.dart';

abstract class TableState extends Equatable {
  @override
  List<Object> get props => [];
}

class TableLoading extends TableState {}

class TableLoaded extends TableState {
  final List<MTable> tables;

  TableLoaded(this.tables);

  @override
  List<Object> get props => [tables];
}

class TableOperationFailure extends TableState {}
