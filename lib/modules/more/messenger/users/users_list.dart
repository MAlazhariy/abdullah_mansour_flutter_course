import 'package:firstapp/models/messenger_user_model/user_model.dart';
import 'package:flutter/material.dart';



class UsersScreen extends StatelessWidget {

  final List<UserModel> users = [
    UserModel(
      id: 1,
      name: 'Mostafa Alazhriy',
      phone: '01122766832',
    ),
    UserModel(
      id: 2,
      name: 'Taha',
      phone: '016548942',
    ),
    UserModel(
      id: 3,
      name: 'Abbas Mahmoud',
      phone: '011654987451',
    ),
    UserModel(
      id: 4,
      name: 'Mostafa Mahmoud',
      phone: '01122766832',
    ),
    UserModel(
      id: 5,
      name: 'Taha',
      phone: '016548942',
    ),
    UserModel(
      id: 6,
      name: 'Abbas Mahmoud',
      phone: '011654987451',
    ),
    UserModel(
      id: 10,
      name: 'Taha Ahmed El-Abd',
      phone: '011002332135265465215',
    ),
  ];

  UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Users',
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => buildUserItem(users[index]),
        itemCount: users.length,
        separatorBuilder: (context, index)=>Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey[300],
          ),
        ),
        scrollDirection: Axis.vertical,
      ),
    );
  }

  Widget buildUserItem(UserModel user) => Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 30,
      vertical: 18,
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.lightBlue,
          child: Text(
            '${user.id}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              user.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black54,
              ),
            ),
            Text(
              user.phone,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Colors.grey,
              ),
            ),
          ],

        ),
      ],
    ),
  );

}
