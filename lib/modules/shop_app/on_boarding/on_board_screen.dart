import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login/login_screen.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  double currentIndex = 0;
  bool isLast = false;

  PageController boardController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index.toDouble();
                  if (currentIndex == (boardItems.length) - 1) {
                    isLast = true;
                  } else {
                    isLast = false;
                  }
                });
              },
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                  right: 25,
                  left: 25,
                  bottom: 20,
                ),
                child:
                    boardBuilderItem(context: context, item: boardItems[index]),
              ),
              controller: boardController,
              itemCount: boardItems.length,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text(
                    isLast ? '' : 'Skip',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onPressed: isLast
                      ? null
                      : () {
                          if (!isLast) {
                            /// Skip
                            setState(() {
                              boardController.animateToPage(
                                boardItems.length - 1,
                                duration: const Duration(
                                  milliseconds: 300,
                                ),
                                curve: Curves.fastLinearToSlowEaseIn,
                              );
                            });
                          }
                        },
                ),
                Expanded(
                  child: Center(
                    child: SmoothPageIndicator(
                      controller: boardController,
                      count: boardItems.length,
                      effect: WormEffect(
                        activeDotColor: Theme.of(context).primaryColor,
                        dotHeight: 10,
                        dotWidth: 10,
                        offset: currentIndex,
                      ),
                      onDotClicked: (int index) {
                        setState(() {
                          boardController.animateToPage(
                            index,
                            duration: const Duration(
                              milliseconds: 300,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        });
                      },
                    ),
                  ),
                ),
                TextButton(
                  child: Text(
                    isLast ? 'Done' : 'Next',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: isLast ? 18 : 17,
                      fontWeight: isLast ? FontWeight.w700 : FontWeight.w400,
                    ),
                  ),
                  onPressed: () {
                    if (isLast) {
                      /// Done
                      setState(() {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShopAppLoginScreen(),
                          ),
                          (route) => false,
                        );
                      });
                    } else {
                      /// Next
                      setState(() {
                        boardController.nextPage(
                          duration: const Duration(
                            milliseconds: 700,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

List<PageViewModel> pageModels = [
  PageViewModel(
    title: 'Welcome to my application',
    body: 'This is a welcome screen to my application, '
        'which designed by Mostafa Alazhariy.\n'
        'All rights reserved.',
    image: const Image(
      image: NetworkImage(
          'https://www.sampleposts.com/wp-content/uploads/2020/10/help-quote.jpg'),
    ),
    decoration: const PageDecoration(
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 23,
        decorationColor: Colors.black,
        color: Colors.black,
      ),
      bodyTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        decorationColor: Colors.black,
        color: Colors.black,
      ),
      pageColor: Colors.deepOrange,
    ),
  ),
  PageViewModel(
    title: 'This app will helping you to get what you want when you want',
    body: 'This application is based on roasted fried eggplant',
    image: const Image(
      image: NetworkImage(
        'https://www.sampleposts.com/wp-content/uploads/2020/10/help-quote.jpg',
      ),
    ),
    decoration: const PageDecoration(
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 23,
        decorationColor: Colors.black,
        color: Colors.black,
      ),
      bodyTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        decorationColor: Colors.black,
        color: Colors.black,
      ),
      pageColor: Colors.deepOrange,
    ),
  ),
  PageViewModel(
    title: 'You are now ready',
    body: 'Let\'s go ..',
    image: const Image(
      image: NetworkImage(
        'https://readymkt.com/wp-content/uploads/2020/11/ready-logo-2.png',
      ),
    ),
    decoration: const PageDecoration(
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 23,
        decorationColor: Colors.black,
        color: Colors.black,
      ),
      bodyTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        decorationColor: Colors.black,
        color: Colors.black,
      ),
      pageColor: Colors.deepOrange,
    ),
  ),
];

List boardItems = [
  {
    'Screen': 1,
    'headline': 'Welcome to my application',
    'subtitle': 'This is a welcome screen to my application, '
        'which designed by Mostafa Alazhariy.\n'
        'All rights reserved.',
    'image': const NetworkImage(
        'https://scontent.fcai19-2.fna.fbcdn.net/v/t1.6435-9/201751130_4018138651606478_5214116909417067342_n.jpg?_nc_cat=109&ccb=1-3&_nc_sid=730e14&_nc_ohc=NcC9RgQpR3UAX_zIQkM&_nc_ht=scontent.fcai19-2.fna&oh=0a9268e08dbac863b2b2e8b334c84c52&oe=60EB8577'),
  },
  {
    'Screen': 2,
    'headline': 'This app will helping you to get what you want when you want',
    'subtitle': 'This application is based on roasted fried eggplant',
    'image': const NetworkImage(
      'https://www.sampleposts.com/wp-content/uploads/2020/10/help-quote.jpg',
    ),
  },
  {
    'Screen': 3,
    'headline': 'You are now ready',
    'subtitle': 'Let\'s go ..',
    'image': const NetworkImage(
      'https://readymkt.com/wp-content/uploads/2020/11/ready-logo-2.png',
    ),
  },
];

Widget boardBuilderItem({
  required BuildContext context,
  required Map item,
}) {
  return Column(
    // crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ClipRRect(
        child: SizedBox(
          child: Image(
            image: item['image'],
            fit: BoxFit.fitWidth,
            errorBuilder: (context, object, stackTracer) {
              return const Icon(Icons.not_interested);
            },
          ),
          height: 200,
          width: double.infinity,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      const SizedBox(
        height: 40,
      ),
      Text(
        item['headline'],
        style: Theme.of(context).textTheme.headline1,
        // textAlign: TextAlign.start,
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        item['subtitle'],
        style: Theme.of(context).textTheme.headline2,
        textAlign: TextAlign.center,
      ),
    ],
  );
}
