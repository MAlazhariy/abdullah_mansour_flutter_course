
import 'dart:developer';

import 'package:firstapp/modules/todo_app/archived_task/archived_tasks_screen.dart';
import 'package:firstapp/modules/todo_app/done_tasks/done_tasks_screen.dart';
import 'package:firstapp/modules/todo_app/new_tasks/new_tasks_screen.dart';
import 'package:firstapp/shared/app_cubit/app_states.dart';
import 'package:firstapp/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) {
    return BlocProvider.of(context);
  }

  int currentBottomIndex = 0;

  bool isBottomSheetIsOpen = false;
  IconData fabIcon = Icons.add;

  static bool isDark = false;

  late Database database;

  // void changeTheme() {
  //   isDark = !isDark;
  //   CacheHelper.setBoolean(key: 'isDark', value: isDark).then((value) {
  //     emit(AppChangeThemeModeState());
  //   });
  // }

  List<Widget> bodyTask = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeBar(index) {
    currentBottomIndex = index;
    emit(AppButtomNavBarState());
  }

  void changeFab({
    required IconData icon,
    required bool isOpen,
  }) {
    fabIcon = icon;
    isBottomSheetIsOpen = isOpen;
    emit(AppChangeBottomSheetState());
  }

  void createDataBase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (db, version) {
        log('Database Created');

        db
            .execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)',
        )
            .then((value) {
          log('Table Created');
        }).catchError((err) {
          log('Error when creating database ${err.toString()}!');
        });
      },
      onOpen: (db) {
        log('DataBase Opened');
        getDataFromDatabase(db);
      },
    ).then((Database value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  void insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) {
      return txn
          .rawInsert('INSERT INTO tasks(title, date, time, status)'
              ' VALUES ("$title", "$date", "$time", "new task")')
          .then((value) {
        log('$value inserted successfully in table');
        emit(AppInsertToDatabaseState());
      }).catchError((err) {
        log('Error while inserting record in table tasks: ${err.toString()}');
      });

    }).then((value) {
      getDataFromDatabase(database);
    });
  }

  void updateDatabase({
    required int id,
    required String status,
  }) async {
    await database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?', [status, id]).then((value) {
      emit(AppChangeTasksState());
      getDataFromDatabase(database);
    });
  }

  void deleteDatabase({
    required int id,
  }) async {
    await database
        .rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      log('task $value was deleted successful');
      emit(AppDeleteDatabaseState());
      getDataFromDatabase(database);
    });
  }

  void getDataFromDatabase(database) async {
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      newTasks = [];
      doneTasks = [];
      archiveTasks = [];
      value.forEach((element) {
        if (element['status'] == 'new task') {
          newTasks.add(element);
        } else if (element['status'] == 'done task') {
          doneTasks.add(element);
        } else if (element['status'] == 'archived task') {
          archiveTasks.add(element);
        }
      });
      emit(AppGetDatabaseState());
      log('get database table');
    });
  }
}
