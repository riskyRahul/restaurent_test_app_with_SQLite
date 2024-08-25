import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurent_app/repository/table_repository.dart';
import 'package:restaurent_app/model/table_model.dart';
import 'table_event.dart';
import 'table_state.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  final TableRepository tableRepository;

  TableBloc({required this.tableRepository}) : super(TableLoading()) {
    on<LoadTables>((event, emit) async {
      emit(TableLoading());
      try {
        final tables = await tableRepository.fetchAllTables();
        if (tables.isEmpty) {
          // Define your bulk data

          final bulkTables = [
            MTable(
                id: 1,
                name: 'T 1',
                numberOfSeats: 4,
                tableStatus: 0,
                time: '2024-08-25T12:00:00Z'),
            MTable(
                id: 2,
                name: 'T 2',
                numberOfSeats: 2,
                tableStatus: 0,
                time: '2024-08-25T12:30:00Z'),
            MTable(
                id: 3,
                name: 'T 3',
                numberOfSeats: 6,
                tableStatus: 0,
                time: '2024-08-25T13:00:00Z'),
            MTable(
                id: 4,
                name: 'T 4',
                numberOfSeats: 4,
                tableStatus: 0,
                time: '2024-08-25T13:30:00Z'),
            MTable(
                id: 5,
                name: 'T 5',
                numberOfSeats: 8,
                tableStatus: 0,
                time: '2024-08-25T14:00:00Z'),
            MTable(
                id: 6,
                name: 'T 6',
                numberOfSeats: 2,
                tableStatus: 0,
                time: '2024-08-25T14:30:00Z'),
            MTable(
                id: 7,
                name: 'T 7',
                numberOfSeats: 4,
                tableStatus: 0,
                time: '2024-08-25T15:00:00Z'),
            MTable(
                id: 8,
                name: 'T 8',
                numberOfSeats: 6,
                tableStatus: 0,
                time: '2024-08-25T15:30:00Z'),
            MTable(
                id: 9,
                name: 'T 9',
                numberOfSeats: 2,
                tableStatus: 0,
                time: '2024-08-25T16:00:00Z'),
            MTable(
                id: 10,
                name: 'T 10',
                numberOfSeats: 4,
                tableStatus: 0,
                time: '2024-08-25T16:30:00Z'),
            MTable(
                id: 11,
                name: 'T 11',
                numberOfSeats: 8,
                tableStatus: 0,
                time: '2024-08-25T17:00:00Z'),
            MTable(
                id: 12,
                name: 'T 12',
                numberOfSeats: 2,
                tableStatus: 0,
                time: '2024-08-25T17:30:00Z'),
            MTable(
                id: 13,
                name: 'T 13',
                numberOfSeats: 4,
                tableStatus: 0,
                time: '2024-08-25T18:00:00Z'),
            MTable(
                id: 14,
                name: 'T 14',
                numberOfSeats: 6,
                tableStatus: 0,
                time: '2024-08-25T18:30:00Z'),
            MTable(
                id: 15,
                name: 'T 15',
                numberOfSeats: 4,
                tableStatus: 0,
                time: '2024-08-25T19:00:00Z'),
            MTable(
                id: 16,
                name: 'T 16',
                numberOfSeats: 2,
                tableStatus: 0,
                time: '2024-08-25T19:30:00Z'),
            MTable(
                id: 17,
                name: 'T 17',
                numberOfSeats: 8,
                tableStatus: 0,
                time: '2024-08-25T20:00:00Z'),
            MTable(
                id: 18,
                name: 'T 18',
                numberOfSeats: 4,
                tableStatus: 0,
                time: '2024-08-25T20:30:00Z'),
            MTable(
                id: 19,
                name: 'T 19',
                numberOfSeats: 6,
                tableStatus: 0,
                time: '2024-08-25T21:00:00Z'),
            MTable(
                id: 20,
                name: 'T 20',
                numberOfSeats: 2,
                tableStatus: 0,
                time: '2024-08-25T21:30:00Z'),
          ];
          await tableRepository.bulkInsertTables(bulkTables).whenComplete(() {
            print("data insurted in bulk");
          });
          // Fetch tables again after inserting
          final updatedTables = await tableRepository.fetchAllTables();
          emit(TableLoaded(updatedTables));
        } else {
          emit(TableLoaded(tables));
        }
      } catch (_) {
        emit(TableOperationFailure());
      }
    });

    on<AddTable>((event, emit) async {
      try {
        await tableRepository.addTable(event.table);
        final tables = await tableRepository.fetchAllTables();
        emit(TableLoaded(tables));
      } catch (_) {
        emit(TableOperationFailure());
      }
    });

    on<UpdateTable>((event, emit) async {
      try {
        await tableRepository.updateTable(event.table);
        final tables = await tableRepository.fetchAllTables();
        emit(TableLoaded(tables));
      } catch (_) {
        emit(TableOperationFailure());
      }
    });

    on<DeleteTable>((event, emit) async {
      try {
        await tableRepository.deleteTable(event.id);
        final tables = await tableRepository.fetchAllTables();
        emit(TableLoaded(tables));
      } catch (_) {
        emit(TableOperationFailure());
      }
    });
  }
}
