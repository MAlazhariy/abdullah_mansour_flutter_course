// Created by Mostafa Alazhariy
import 'package:flutter/material.dart';

class AgeCalcResult extends StatefulWidget {

  int bDay, bMonth, bYear, bHour, bMinute;
  String name;

  AgeCalcResult({
    this.name,
    this.bDay,
    this.bHour,
    this.bMinute,
    this.bMonth,
    this.bYear,
  });

  @override
  _AgeCalcResultState createState() => _AgeCalcResultState(
    name: name,
    bDay: bDay,
    bHour: bHour,
    bMinute: bMinute,
    bMonth: bMonth,
    bYear: bYear,
  );
}



class _AgeCalcResultState extends State<AgeCalcResult> {

  int bDay, bMonth, bYear, bHour, bMinute;
  String name;

  int ageYear, ageMonths, ageDays, ageHours, ageMinutes;
  bool isBirthDay = false;
  bool isYearLeap;

  int ageindays,ageinhours, ageinminutes, ageinseconds;

  /// Constractor calculates the age and changes the values in class to calculated values
  _AgeCalcResultState({
    this.name,
    this.bDay,
    this.bHour,
    this.bMinute,
    this.bMonth,
    this.bYear,
  }) {
    this.ageMonths = 0;

    int inDays ([int year, int month, int day]){
      return
        (DateTime.now().difference(DateTime(year,month,day))).inDays;
    }
    int inHours ([int year, int month, int day, int hour, int minute]){
      return
        (DateTime.now().difference(DateTime(year,month,day,hour,minute))
            .inHours);
    }
    int inMinutes ([int year, int month, int day, int hour, int minute]){
      return
        (DateTime.now().difference(DateTime(year,month,day,hour,minute))
            .inMinutes);
    }

    /// check if today is birthday or not
    if (DateTime.now().day == bDay
        && DateTime.now().month == bMonth) isBirthDay = true;

    /// calculating age in values
    this.ageindays = inDays(bYear, bMonth, bDay);
    this.ageinhours = inHours(bYear, bMonth, bDay, bHour, bMinute);
    this.ageinminutes = inMinutes(bYear, bMonth, bDay, bHour, bMinute);
    this.ageinseconds = DateTime.now().difference(DateTime(bYear, bMonth, bDay, bHour, bMinute)).inSeconds;

    /// calculating ageDays first
    // give initial value to ageDAys
    ageDays = ageindays;
    // calculate if current year is leap or not and set value to boolean
    // 1. check if current year is divisible by 4 , if not that means it's not a leap year
    // 2. if year is divisible by 4 check if it is divisible by 100 or not, if true then check
    //    if it divisible by 400 too if true that means it's a LEAP year.
    if (DateTime.now().year%4==0){
      if(DateTime.now().year%100==0){
        DateTime.now().year%400==0
            ? isYearLeap = true
            : isYearLeap = false;
      } else isYearLeap = true;
    } else {
      isYearLeap = false;
    }

    /// subtract days in leap years from total days in age (except the current year)
    for(int j=bMonth,i = bYear; i<(DateTime.now().year); i++){
      // check the year he born in if it a leap year but he born after FEB month,
      // then skip this year
      if (j>2){
        j=1;
        continue;
      }
      // check if the year[i] is leap or not
      if (i%4==0){
        if(i%100==0){
          i%400==0 ? ageDays -= 1 : null;
          continue;
        }
        ageDays -= 1;
      }
    }

    // check if current month is after Feb or today is the last day in the month in leap year
    // to sub leap day from ageDays (or not)
    if(DateTime.now().month>2 || (DateTime.now().day==29 && DateTime.now().month==2)){
      // check if current year is leap or not
      if (DateTime.now().year%4==0){
        if(DateTime.now().year%100==0){
          DateTime.now().year%400==0 ? ageDays -= 1 : null;
        } else {
          ageDays -= 1;
        }
      }
    }

    /// NOW ageDays equals total days he lived excepted the leap days

    // It's important to calculate year after subtracting leap days from ageDays
    // then divide result by 365 to get EXACTLY number of years he lived
    ageYear = (ageDays / 365).floor();
    // Calculates the remainder of the days in the current year
    // to prepare it for the subtraction of months
    ageDays = ageDays % 365;
    /// calculate ageHours and ageMinutes
    ageHours = (inHours(bYear, bMonth, bDay, bHour, bMinute) % 24);
    ageMinutes = (inMinutes(bYear, bMonth, bDay, bHour, bMinute) % 60);

//    // calculate the difference between two months
//    int monthsSub = DateTime.now().month>bMonth
//        ? DateTime.now().month - bMonth : (12 - bMonth) + DateTime.now().month;

    // startMonth is a counter var to use in loop
    // to know which month starting loop with
    int startMonth = bMonth;

    // This loop subtracts the days of the months from the total ageDays
    /// and also calculates ageMonths
      // please keep the variable [i] in the loop
      // because it's IMPORTANT to recognize the first loop to do a specific action
    for (int i=1;;i++){
      // check in the first loop if the birth day is the last in the birth month,
      // if true continue and start from the next month
      if(i==1){
        if(
        ((bMonth==1 || bMonth==3 || bMonth==5 || bMonth==7 || bMonth==8 || bMonth==10 || bMonth==12) && bDay==31)
            || (bMonth==2 && bDay== (isYearLeap?29:28))
        ){
          startMonth++;
          continue;
        }
      }

      if (startMonth==1 || startMonth==13) {
        if (ageDays<31) break;
        ageDays -= 31;
        startMonth=1;
      }
      else if (startMonth==2) {
        if (ageDays<28) break;
        ageDays -= 28;
      }
      else if (startMonth==3){
        if (ageDays<31) break;
        ageDays -= 31;
      }
      else if (startMonth==4){
        if (ageDays<30) break;
        ageDays -= 30;
      }
      else if (startMonth==5){
        if (ageDays<31) break;
        ageDays -= 31;
      }
      else if (startMonth==6){
        if (ageDays<30) break;
        ageDays -= 30;
      }
      else if (startMonth==7){
        if (ageDays<31) break;
        ageDays -= 31;
      }
      else if (startMonth==8){
        if (ageDays<31) break;
        ageDays -= 31;
      }
      else if (startMonth==9){
        if (ageDays<30) break;
        ageDays -= 30;
      }
      else if (startMonth==10){
        if (ageDays<31) break;
        ageDays -= 31;
      }
      else if (startMonth==11){
        if (ageDays<30) break;
        ageDays -= 30;
      }
      else if (startMonth==12){
        if (ageDays<31) break;
        ageDays -= 31;
      }
      ageMonths+=1;
      startMonth++;
    }
  }

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              isBirthDay?'Happy Birthday':'Age Calculated',
            ),
            (isBirthDay)?Row(
              children: [
                SizedBox(width: 5,),
                Icon(
                  Icons.favorite_outlined,
                  size: 20,
                ),
                SizedBox(width: 5,),
              ],
            ):Container(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                (isBirthDay) ? Column(
                  children: [
                    Text(
                      'Happy Birthday ${name}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        letterSpacing: .17,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Image(
                      image: AssetImage(
                        'assets/images/heart.png',
                      ),
                      width: 180,
                    ),
                    SizedBox(height: 40,),
                  ],
                ) : Container(),
                // your age is
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (isBirthDay)
                          ? 'your age now is'
                          : 'Hi $name, Your age is',
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.blue,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 23,),
                    // years and months
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// years
                        box(
                          title: 'year',
                          value: ageYear,
                          firsttext: '',
                        ),
                        SizedBox(width: 5),
                        /// months
                        box(
                          title: 'month',
                          value: ageMonths,
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    // days and hours
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// days
                        box(
                          title: 'day',
                          value: ageDays,
                        ),
                        SizedBox(width: 5),
                        /// hours
                        box(
                          title: 'hour',
                          value: ageHours,
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    // minutes
                    Container(
                      child: box(
                        title: 'minute',
                        value: ageMinutes,
                        firsttext: 'and',
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 40,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),

                box2(title: 'day', value: ageindays),
                box2(title: 'hour', value: ageinhours),
                box2(title: 'minute', value: ageinminutes),
                box2(title: 'second', value: ageinseconds),

                SizedBox(height: 2,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Designed by : ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      'Mostafa Alazhariy',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blue,
                        fontWeight: FontWeight.w400,
                        letterSpacing: .2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
          onPressed: () {
              setState(() {
                this.ageMonths = 0;

                int inDays ([int year, int month, int day]){
                  return
                    (DateTime.now().difference(DateTime(year,month,day))).inDays;
                }
                int inHours ([int year, int month, int day, int hour, int minute]){
                  return
                    (DateTime.now().difference(DateTime(year,month,day,hour,minute))
                        .inHours);
                }
                int inMinutes ([int year, int month, int day, int hour, int minute]){
                  return
                    (DateTime.now().difference(DateTime(year,month,day,hour,minute))
                        .inMinutes);
                }

                /// check if today is birthday or not
                if (DateTime.now().day == bDay
                    && DateTime.now().month == bMonth) isBirthDay = true;

                /// calculating age in values
                this.ageindays = inDays(bYear, bMonth, bDay);
                this.ageinhours = inHours(bYear, bMonth, bDay, bHour, bMinute);
                this.ageinminutes = inMinutes(bYear, bMonth, bDay, bHour, bMinute);
                this.ageinseconds = DateTime.now().difference(DateTime(bYear, bMonth, bDay, bHour, bMinute)).inSeconds;

                /// calculating ageDays first
                // give initial value to ageDAys
                ageDays = ageindays;
                // calculate if current year is leap or not and set value to boolean
                // 1. check if current year is divisible by 4 , if not that means it's not a leap year
                // 2. if year is divisible by 4 check if it is divisible by 100 or not, if true then check
                //    if it divisible by 400 too if true that means it's a LEAP year.
                if (DateTime.now().year%4==0){
                  if(DateTime.now().year%100==0){
                    DateTime.now().year%400==0
                        ? isYearLeap = true
                        : isYearLeap = false;
                  } else isYearLeap = true;
                } else {
                  isYearLeap = false;
                }

                /// subtract days in leap years from total days in age (except the current year)
                for(int j=bMonth,i = bYear; i<(DateTime.now().year); i++){
                  // check the year he born in if it a leap year but he born after FEB month,
                  // then skip this year
                  if (j>2){
                    j=1;
                    continue;
                  }
                  // check if the year[i] is leap or not
                  if (i%4==0){
                    if(i%100==0){
                      i%400==0 ? ageDays -= 1 : null;
                      continue;
                    }
                    ageDays -= 1;
                  }
                }

                // check if current month is after Feb or today is the last day in the month in leap year
                // to sub leap day from ageDays (or not)
                if(DateTime.now().month>2 || (DateTime.now().day==29 && DateTime.now().month==2)){
                  // check if current year is leap or not
                  if (DateTime.now().year%4==0){
                    if(DateTime.now().year%100==0){
                      DateTime.now().year%400==0 ? ageDays -= 1 : null;
                    } else {
                      ageDays -= 1;
                    }
                  }
                }

                /// NOW ageDays equals total days he lived excepted the leap days

                // It's important to calculate year after subtracting leap days from ageDays
                // then divide result by 365 to get EXACTLY number of years he lived
                ageYear = (ageDays / 365).floor();
                // Calculates the remainder of the days in the current year
                // to prepare it for the subtraction of months
                ageDays = ageDays % 365;
                /// calculate ageHours and ageMinutes
                ageHours = (inHours(bYear, bMonth, bDay, bHour, bMinute) % 24);
                ageMinutes = (inMinutes(bYear, bMonth, bDay, bHour, bMinute) % 60);

                // startMonth is a counter var to use in loop
                // to know which month starting loop with
                int startMonth = bMonth;

                // This loop subtracts the days of the months from the total ageDays
                /// and also calculates ageMonths
                // please keep the variable [i] in the loop
                // because it's IMPORTANT to recognize the first loop to do a specific action
                for (int i=1;;i++){
                  // check in the first loop if the birth day is the last in the birth month,
                  // if true continue and start from the next month
                  if(i==1){
                    if(
                    ((bMonth==1 || bMonth==3 || bMonth==5 || bMonth==7 || bMonth==8 || bMonth==10 || bMonth==12) && bDay==31)
                        || (bMonth==2 && bDay== (isYearLeap?29:28))
                    ){
                      startMonth++;
                      continue;
                    }
                  }

                  if (startMonth==1 || startMonth==13) {
                    if (ageDays<31) break;
                    ageDays -= 31;
                    startMonth=1;
                  }
                  else if (startMonth==2) {
                    if (ageDays<28) break;
                    ageDays -= 28;
                  }
                  else if (startMonth==3){
                    if (ageDays<31) break;
                    ageDays -= 31;
                  }
                  else if (startMonth==4){
                    if (ageDays<30) break;
                    ageDays -= 30;
                  }
                  else if (startMonth==5){
                    if (ageDays<31) break;
                    ageDays -= 31;
                  }
                  else if (startMonth==6){
                    if (ageDays<30) break;
                    ageDays -= 30;
                  }
                  else if (startMonth==7){
                    if (ageDays<31) break;
                    ageDays -= 31;
                  }
                  else if (startMonth==8){
                    if (ageDays<31) break;
                    ageDays -= 31;
                  }
                  else if (startMonth==9){
                    if (ageDays<30) break;
                    ageDays -= 30;
                  }
                  else if (startMonth==10){
                    if (ageDays<31) break;
                    ageDays -= 31;
                  }
                  else if (startMonth==11){
                    if (ageDays<30) break;
                    ageDays -= 30;
                  }
                  else if (startMonth==12){
                    if (ageDays<31) break;
                    ageDays -= 31;
                  }
                  ageMonths+=1;
                  startMonth++;
                }
            });
          },
          icon: Icon(
            Icons.replay,
          ),
        ),
      ),
    );
  }
}





/// /////////////////////////////


Widget box ({
  String firsttext=',',
  @required int value,
  @required String title,
}) {

  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        firsttext,
        style: TextStyle(
          fontSize: 22.5,
          color: Colors.blue,
          fontWeight: FontWeight.w400,
        ),
      ),
      SizedBox(
        width: firsttext!=''? 7 : 0,
      ),
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$value',
              style: TextStyle(
                fontSize: value<900?28.7:26,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(width: 5,),

            Text(
              value>1 ? '${title}s' : title,
              style: TextStyle(
                fontSize: 25.5,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}



Widget box2 ({
  @required String title,
  @required int value,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
        ),
        child: Text(
          'Age in ${title}s:',
          style: TextStyle(
            fontSize: 17,
            color: Colors.blue[400],
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      SizedBox(height: 5,),
      Container(
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.blue[50].withAlpha(750),
          borderRadius: BorderRadius.circular(12),
        ),
        child:  Row(
          children: [
            Text(
              '${value}',
              style: TextStyle(
                fontSize: 25,
                color: Colors.blue[400],
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(width: 5,),
            Text(
              '${title}s',
              style: TextStyle(
                fontSize: 21,
                color: Colors.blue[400],
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 25,),
    ],
  );
}