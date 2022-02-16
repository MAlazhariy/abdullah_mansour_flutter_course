/// WARNING !
/// Do not run this App until delete the cubit creating
/// in the main function.

import 'package:firstapp/modules/todo_app/archived_task/archived_tasks_screen.dart';
import 'package:firstapp/modules/todo_app/done_tasks/done_tasks_screen.dart';
import 'package:firstapp/modules/todo_app/new_tasks/new_tasks_screen.dart';
import 'package:firstapp/shared/components/constants.dart';
import 'package:firstapp/shared/cubit/cubit.dart';
import 'package:firstapp/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  TextEditingController titlecontroller = new TextEditingController();
  TextEditingController timecontroller = new TextEditingController();
  TextEditingController datecontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(

        listener: (context, state) {
          if(state is AppInsertToDatabaseState) {
            Navigator.pop(context);
            titlecontroller.text =
                timecontroller.text =
                datecontroller.text = '' ;
          }
        },

        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentBottomIndex],
              ),
            ),
            body: (state is! AppGetDatabaseLoadingState )
                    ? cubit.bodyTask[cubit.currentBottomIndex]
                    : Center(child: CircularProgressIndicator()),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                // check if bottom is open to insert data to database then close bottom
                if (cubit.isBottomSheetIsOpen)
                {
                  if (formKey.currentState.validate()) {
                    cubit.insertToDatabase(
                        title: titlecontroller.text,
                        time: timecontroller.text,
                        date: datecontroller.text,
                    );
                  }
                }
                else
                {
                  scaffoldKey.currentState.showBottomSheet(
                        (context) => Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              /// title
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                  right: 15,
                                  left: 15,
                                  bottom: 7.5,
                                ),
                                child: TextFormField(
                                  controller: titlecontroller,
                                  keyboardType: TextInputType.text,
                                  validator: (String value) {
                                    if (value.isEmpty || value == '') {
                                      return 'Title must not be empty';
                                    } else
                                      return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    labelText: 'Task title',
                                    prefixIcon: Icon(Icons.title),
                                  ),
                                ),
                              ),

                              /// time
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 7.5,
                                  right: 15,
                                  left: 15,
                                  bottom: 7.5,
                                ),
                                child: TextFormField(
                                  readOnly: true,
                                  controller: timecontroller,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    labelText: 'Time',
                                    prefixIcon: Icon(Icons.access_time_rounded),
                                  ),
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timecontroller.text =
                                          value.format(context).toString();
                                    });
                                  },
                                  validator: (String value) {
                                    if (value.isEmpty || value == '') {
                                      return 'Time must not be empty';
                                    } else
                                      return null;
                                  },
                                ),
                              ),

                              /// date
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 7.5,
                                  right: 15,
                                  left: 15,
                                  bottom: 12,
                                ),
                                child: TextFormField(
                                  readOnly: true,
                                  controller: datecontroller,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    labelText: 'Date',
                                    prefixIcon: Icon(Icons.date_range_rounded),
                                  ),
                                  onTap: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.now()
                                                .add(Duration(days: 365)))
                                        .then((value) {
                                      datecontroller.text = DateFormat('dd/MM/y')
                                          .format(value)
                                          .toString();
                                    });
                                  },
                                  validator: (String value) {
                                    if (value.isEmpty || value == '') {
                                      return 'Date must not be empty';
                                    } else
                                      return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        elevation: 20,
                      ).closed
                      .then((value) {
                      cubit.changeFab(
                      icon: Icons.add,
                      isOpen: false,
                    );
                  });
                  cubit.changeFab(
                      icon: Icons.check_rounded,
                      isOpen: true
                  );
                }
              },
              child: Icon(
                cubit.fabIcon,
                size: 25,
              ),
              elevation: 3.5,
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                cubit.changeBar(index);
              },
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentBottomIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.playlist_add_check_rounded),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_box),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive),
                  label: 'Archived',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
