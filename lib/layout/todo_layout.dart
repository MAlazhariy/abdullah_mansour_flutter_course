/// WARNING !
/// Do not run this App until delete the login_cubit creating
/// in the main function.

import 'package:firstapp/shared/app_cubit/app_cubit.dart';
import 'package:firstapp/shared/app_cubit/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeLayout extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final timeController = TextEditingController();
  final dateController = TextEditingController();

  HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertToDatabaseState) {
            Navigator.pop(context);
            titleController.text =
                timeController.text = dateController.text = '';
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
            body: (state is! AppGetDatabaseLoadingState)
                ? cubit.bodyTask[cubit.currentBottomIndex]
                : const Center(child: CircularProgressIndicator()),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                // check if bottom is open to insert data to database then close bottom
                if (cubit.isBottomSheetIsOpen) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text,
                    );
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
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
                                  controller: titleController,
                                  keyboardType: TextInputType.text,
                                  validator: (String? value) {
                                    if (value == '') {
                                      return 'Title must not be empty';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    labelText: 'Task title',
                                    prefixIcon: const Icon(Icons.title),
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
                                  controller: timeController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    labelText: 'Time',
                                    prefixIcon: const Icon(Icons.access_time_rounded),
                                  ),
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text =
                                          value!.format(context).toString();
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty || value == '') {
                                      return 'Time must not be empty';
                                    } else {
                                      return null;
                                    }
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
                                  controller: dateController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    labelText: 'Date',
                                    prefixIcon: const Icon(Icons.date_range_rounded),
                                  ),
                                  onTap: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.now()
                                                .add(const Duration(days: 365)))
                                        .then((value) {
                                      dateController.text =
                                          DateFormat('dd/MM/yyyy')
                                              .format(value!)
                                              .toString();
                                    });
                                  },
                                  validator: (value) {
                                    if (value == '') {
                                      return 'Date must not be empty';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        elevation: 20,
                      )
                      .closed
                      .then((value) {
                    cubit.changeFab(
                      icon: Icons.add,
                      isOpen: false,
                    );
                  });
                  cubit.changeFab(icon: Icons.check_rounded, isOpen: true);
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
              items: const [
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
