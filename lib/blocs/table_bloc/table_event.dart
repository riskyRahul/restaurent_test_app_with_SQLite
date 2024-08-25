import 'package:equatable/equatable.dart';
import 'package:restaurent_app/model/table_model.dart';

abstract class TableEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadTables extends TableEvent {}

class AddTable extends TableEvent {
  final MTable table;

  AddTable(this.table);

  @override
  List<Object> get props => [table];
}

class UpdateTable extends TableEvent {
  final MTable table;

  UpdateTable(this.table);

  @override
  List<Object> get props => [table];
}

class DeleteTable extends TableEvent {
  final int id;

  DeleteTable(this.id);

  @override
  List<Object> get props => [id];
}
