import 'package:conditional_builder/conditional_builder.dart';
import 'package:firstapp/modules/news_app/news_web_view/news_web_view.dart';
import 'package:firstapp/shared/components/constants.dart';
import 'package:firstapp/shared/cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:sqflite/sqflite.dart';
import 'package:webview_flutter/webview_flutter.dart';

Widget defaultButton({
  Color backgroundColor = Colors.blue,
  Color textColor = Colors.white,
  double width = double.infinity,
  @required Function onPressedFunction,
  @required String text,
  double fontsize = 16,
  bool isUpperCase = true,
  double border = 0,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(border),
      ),
      child: MaterialButton(
        height: 50,
        onPressed: onPressedFunction,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: fontsize,
          ),
        ),
      ),
    );


Widget whiteTextForm ({
  TextInputAction inputAction = TextInputAction.none,
  @required TextEditingController controller,
  TextInputType keyboardType = TextInputType.emailAddress,
  String hintText,
  Icon prefixIcon,
  String helper,
  Function onChanged,
  @required Function validator,
  bool obscureText = false,
  Function onFieldSubmitted,
  Widget suffix,
}){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      boxShadow: [
        BoxShadow(
          color: Color(0x3B8B8B8B),
          blurRadius: 15,
          offset: Offset(0,5),
        ),
      ],
    ),
    child: TextFormField(
      textInputAction: inputAction,
      obscureText: obscureText,
      style: TextStyle(
        fontSize: 19.5,
        fontWeight: FontWeight.w600,
        color: redColor,
      ),
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 28,
          vertical: 18,
        ),

        filled: true,
        fillColor: Colors.white,
        suffix: suffix,
        suffixStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: redColor,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: redColor,
            width: 2.2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: redColor,
            width: 2.2,
          ),
        ),
        errorStyle: TextStyle(
          color: redColor,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 19.5,
          fontWeight: FontWeight.w600,
          color: Color(0x7C323F48),
        ),
        prefixIcon: prefixIcon != null ? Padding(
          padding: const EdgeInsets.only(
              left: 20,
              right: 10
          ),
          child: prefixIcon,
        ) : null,
        helperText: helper,
        helperStyle: TextStyle(
          color: redColor,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          gapPadding: 10,
        ),
      ),
      onChanged: onChanged,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
    ),
  );
}

Widget buildTaskItem({
  @required Map model,
  @required context,
}) =>
    Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        AppCubit.get(context).deleteDatabase(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(
                '${model['time']}',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 8,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateDatabase(
                  id: model['id'],
                  status: 'done task',
                );
              },
              icon: Icon(
                Icons.check_box_outlined,
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateDatabase(
                  id: model['id'],
                  status: 'archived task',
                );
              },
              icon: Icon(Icons.archive_outlined),
            ),
          ],
        ),
      ),
    );

Widget taskBodyBuilder({
  @required List<Map> tasks,
}) {
  return ConditionalBuilder(
    condition: tasks.length > 0,
    builder: (context) => ListView.separated(
      itemBuilder: (context, index) => buildTaskItem(
        model: tasks[index],
        context: context,
      ),
      separatorBuilder: (context, index) => separator(),
      itemCount: tasks.length,
    ),
    fallback: (context) => Center(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon(
            //   Icons.warning_rounded,
            //   color: Colors.grey,
            //   size: 80,
            // ),
            Text(
              'Add a new task to appear here',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 23,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget separator() {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 4,
      horizontal: 18,
    ),
    child: Container(
      color: Colors.grey[500],
      height: 0.5,
    ),
  );
}

Widget newsItem ({
  @required Map article,
  @required BuildContext context,
}){
  return InkWell(
    onTap: (){
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context){
              return WebViewScreen(url: article['url']);
            }
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  article['urlToImage'] != null
                      ? article['urlToImage']
                      : 'http://www.aaru.edu.jo/websites/aaru2/wp-content/plugins/learnpress/assets/images/no-image.png?Mobile=1&Source=%2F%5Flayouts%2Fmobile%2Fdispform%2Easpx%3FList%3D78b536db%252De7c7%252D45d9%252Da661%252Ddb2a2aa2fbaf%26View%3D6efc759a%252D0646%252D433c%252Dab6e%252D2f027ffe0799%26RootFolder%3D%252Fwebsites%252Faaru2%252Fwp%252Dcontent%252Fplugins%252Flearnpress%252Fassets%252Fimages%26ID%3D4786%26CurrentPage%3D1',
                ),
              ),
            ),
          ),
          SizedBox(width: 8,),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    article['title'],
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    article['publishedAt'],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[500],
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget webView({
  @required String url,
}){
  return WebView(
    initialUrl: url,
  );
}