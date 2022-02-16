import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white,
     appBar: AppBar(
       backgroundColor: Colors.white,
       elevation: 0,
       title: Row(
         children: [
           CircleAvatar(
             backgroundColor: Colors.white,
             backgroundImage: NetworkImage(
               'https://scontent.fcai19-2.fna.fbcdn.net/v/t1.6435-9/187137835_3930767890343555_7817363124794517256_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=8bfeb9&_nc_ohc=WtYZ5Z7O4p0AX_f4AEd&_nc_ht=scontent.fcai19-2.fna&oh=0b439c66ca40bab583ee888eafb6a162&oe=60CE856B'
             ),
             radius: 22,
           ),
           SizedBox(
             width: 12,
           ),
           Text(
             'Chats',
             style: TextStyle(
               color: Colors.black87,
               fontSize: 30,
               fontWeight: FontWeight.w700,
             ),
           ),
         ],
       ),
       titleSpacing: 20.0,
       actions: [
         CircleAvatar(
           radius: 15,
           backgroundColor: Colors.grey[300],
           child: IconButton(
             alignment: Alignment.center,
             padding: EdgeInsets.all(0),
             icon: Icon(
               Icons.camera_alt,
               color: Colors.black87,
                size: 17,
             ),
             onPressed: (){
               print('pressed camera');
             },
           ),
         ),
         SizedBox(
           width: 15,
         ),
         CircleAvatar(
           backgroundColor: Colors.grey[300],
           radius: 15,
           child: IconButton(
             padding: EdgeInsets.all(0),
               icon: Icon(
                 Icons.edit,
                 color: Colors.black87,
                 size: 16,
               ),
               onPressed: (){
                 print('Edit pressed');
               },),
         ),
         SizedBox(
           width: 15,
         ),
       ],
     ),


     body: Padding(
       padding: const EdgeInsets.all(20),
       child: SingleChildScrollView(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             SizedBox(
               height: 8,
             ),

             /// search bar
             Container(
               decoration: BoxDecoration(
                 color: Colors.grey[300],
                 borderRadius: BorderRadius.circular(18),
               ),
               padding: EdgeInsets.symmetric(
                 vertical: 13,
                 horizontal: 20,
               ),
               child: Row(
                   children: [
                     Icon(
                       Icons.search,
                       size: 23,
                     ),
                     SizedBox(
                       width: 8,
                     ),
                     Text(
                       'Search',
                       style: TextStyle(
                         fontWeight: FontWeight.w500,
                         color: Colors.black87,
                         fontSize: 17,
                       ),
                     ),
                   ],
                 ),
             ),
             SizedBox(
               height: 20,
             ),

             /// stories
             Container(
               height: 115,
               child: ListView.separated(
                 shrinkWrap: true,
                 scrollDirection: Axis.horizontal,

                   itemBuilder: (context, index) => storyItem(),
                   separatorBuilder: (context, index)=> SizedBox(
                     width: 10,
                   ),
                   itemCount: 15,
               ),
             ),
             SizedBox(height: 18),

             /// chats
             ListView.separated(
               physics: NeverScrollableScrollPhysics(),
               shrinkWrap: true,
               scrollDirection: Axis.vertical,
               separatorBuilder: (cont, index)=> SizedBox(height: 10,),
               itemBuilder: (cont, index) => chatItem(),
               itemCount: 20,
             ),
           ],
         ),
       ),
     ),
   );
  }

  Widget storyItem() => Column(
    children: [
      Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
              'https://scontent.fcai19-2.fna.fbcdn.net/v/t1.6435-1/p200x200/144880335_955787641494174_6306476889917704720_n.jpg?_nc_cat=100&ccb=1-3&_nc_sid=7206a8&_nc_ohc=D7aL3pr9kvYAX9PxbII&_nc_ht=scontent.fcai19-2.fna&tp=6&oh=fdbd9d9ef12cc967ab89252c7e0d886e&oe=60CF431B',
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.green,
            radius: 8,
          ),
        ],
      ),
      SizedBox(
        height: 7,
      ),
      Container(
        width: 80,
        child: Text(
          'Taha Ahmed El-Abd',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.5,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ),
    ],
  );
  Widget chatItem() => Row(
    children: [
      //profile pic
      CircleAvatar(
        backgroundColor: Colors.white,
        radius: 30,
        backgroundImage: NetworkImage(
            "https://scontent.fcai19-2.fna.fbcdn.net/v/t1.6435-9/138811861_3602814706472210_3844811973319459704_n.jpg?_nc_cat=107&ccb=1-3&_nc_sid=174925&_nc_ohc=p8frQE7CjjAAX8tCP8u&_nc_ht=scontent.fcai19-2.fna&oh=1f53afcb3571e9f4dd2f73cdb42e48d4&oe=60D18496"
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // name title
            Container(
              child: Text(
                'Mostafa Alazhariy',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                  fontSize: 19,
                ),
              ),
            ),

            SizedBox(
              height: 3,
            ),
            // message
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Hey, bro how are you? I\'m waiting you on my Bathengan mekhalel, but sometimes no.',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.5,
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    radius: 2.3,
                  ),
                ),

                Container(
                  child: Text(
                    '10:23 AM',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );



}