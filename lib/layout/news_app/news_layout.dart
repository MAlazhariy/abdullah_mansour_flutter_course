import 'package:firstapp/layout/news_app/cubit/cubti.dart';
import 'package:firstapp/layout/news_app/cubit/states.dart';
import 'package:firstapp/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => NewsCubit(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state){},
        builder: (context, state) {
          NewsCubit cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'News App',
              ),
              actions: [
                IconButton(
                  onPressed: (){},
                  icon: const Icon(
                    Icons.search,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 10,),
                IconButton(
                  onPressed: (){
                    AppCubit.get(context).changeTheme();
                  },
                  icon: const Icon(
                    Icons.brightness_4_rounded,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 15,),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (int index){
                cubit.changeNavBar(index);
              },
              currentIndex: cubit.currentBottomIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.work_rounded),
                  label: 'Business',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.sports_baseball_sharp),
                  label: 'Sports',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.science_rounded),
                  label: 'Science',
                ),
              ],
            ),
            body: cubit.screens[cubit.currentBottomIndex],
          );
        },
      ),
    );
  }
}
