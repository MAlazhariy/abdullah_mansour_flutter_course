import 'package:firstapp/modules/age_calculator_app/age_calculator/age_calc_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeAgeCalc extends StatefulWidget {
  const HomeAgeCalc({Key key}) : super(key: key);

  @override
  _HomeAgeCalcState createState() => _HomeAgeCalcState();
}

class _HomeAgeCalcState extends State<HomeAgeCalc> {

  var nameCtrl = TextEditingController();

  var dayCtrl = TextEditingController();
  var monthCtrl = TextEditingController();
  var yearCtrl = TextEditingController();

  var hourCtrl = TextEditingController();
  var minuteCtrl = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Simple Age Calculator',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 8,),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 65,
        ),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: 14,),
                /// name
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    title('Name:'),
                    SizedBox(width: 15,),
                    Expanded(
                      child: Container(
                        height: 35,
                        /// name field
                        child: TextFormField(
                          controller: nameCtrl,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          // maxLines: 1,
                          keyboardType: TextInputType.name,
                          validator: (String value){
                            // if (nameCtrl.text.length<3) {
                            //   return 'Please enter name';
                            // }
                            return null;
                          },
                          onFieldSubmitted: (value){
                            if(formKey.currentState.validate()){
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50,),

                /// date
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    title('Date:'),
                    SizedBox(width: 10,),
                    Expanded(
                      flex: 2,
                      child: box(
                          labelText: 'Day',
                        validatorFunc: (value){
                          bool isYearLeap;
                          // important to check if there is value in year to convert to int, or not!
                          // or the value is numbers only
                          try {
                            // calculate if input year is leap or not and set value to boolean
                            // 1. check if year is divisible by 4 , if not that means it's not a leap year
                            // 2. if year is divisible by 4 check if it is divisible by 100 or not, if true then check
                            //    if it divisible by 400 too, if true that means it's a LEAP year.
                            if (int.parse(yearCtrl.text)%4==0){
                              if(int.parse(yearCtrl.text)%100==0){
                                int.parse(yearCtrl.text)%400==0
                                    ? isYearLeap = true
                                    : isYearLeap = false;
                              } else isYearLeap = true;
                            } else {
                              isYearLeap = false;
                            }
                          } catch (e){
                            // catch do not return 'Invalid' because the error in the year
                            // So the year validator should return the error
                          }


                          /// validator rules

                          // 1. check if the bDay is empty to return REQUIRED
                            if(value=='') {
                              return 'Required';
                            } else {
                              // 2. check the day is number or return 'Invalid' in catch
                              try{
                                int day = int.parse(value);

                                // 3. check if year and month are numbers
                                //    or return nothing
                                try {
                                  int month = int.parse(monthCtrl.text);

                                  // 4. check if the bMonth is 30-day and the bDay <= 30,
                                  //    or if the bYear is leap, check the day is less than 29 if the bMonth is 2
                                  //    or check the day is less then 31
                                  if(month <= 12 && month > 0){

                                    if(day>=1
                                        && (( (month==1||month==3||month==5||month==7||month==8||month==10||month==12) && day<=31 )
                                            || ((month==4||month==6||month==9||month==11) && day<=30 )
                                            || ( month==2 && (isYearLeap!=null ? (isYearLeap?day<=29:day<=28) :day<=29) ))
                                    ){
                                      return null;
                                    } else {
                                      return 'Invalid';
                                    }
                                    
                                  }

                                } catch (e){
                                  // catch do not return 'Invalid' because the error in the year or month or twice
                                  // So the year or month validator should return the error
                                }

                              } catch (e){
                                return 'Invalid';
                              }



                            }
                        },
                        ctrl: dayCtrl,
                        keyboard: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 8,),
                    Expanded(
                      flex: 2,
                      child: box(
                        labelText: 'Month',
                        validatorFunc: (value){
                          // 1. check if value is empty return required
                          if(value==''){
                            return 'Required';
                          }else {
                            // 2. after checking the VALUE is not empty
                            // ensure that the value is numbers only by try & catch
                            try{
                              // 3. check the value is between 1:12
                              if(int.parse(value)>=1 && int.parse(value)<=12){
                                return null;
                              } else {
                                return 'Invalid';
                              }
                            } catch (e){
                              return 'Invalid';
                            }

                          }
                        },
                        ctrl: monthCtrl,
                        keyboard: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 8,),
                    Expanded(
                      flex: 3,
                      child: box(
                        labelText: 'Year',
                        validatorFunc: (String value){

                          try {
                            if(value==''){
                              return 'Required';
                            } else {
                              if(int.parse(value)<=0){
                                return 'Invalid';
                              } else {
                                try {
                                    if(DateTime.now().isAfter(DateTime(int.parse(yearCtrl.text),
                                        int.parse(monthCtrl.text),
                                        int.parse(dayCtrl.text),
                                        (hourCtrl.text!=''?int.parse(hourCtrl.text):0),
                                        (minuteCtrl.text!=''?int.parse(minuteCtrl.text):0))))
                                    {
                                      return null;
                                    } else return 'Not yet come!';
                                } catch (e){
                                  // catch do not return 'Invalid' because the error in the month or the day
                                  // So the month or day validator should return the error
                                }
                              }

                            }
                          } catch (e){
                            return 'Invalid input';
                          }


                        },
                        ctrl: yearCtrl,
                        keyboard: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),

                /// time
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    title('Time:'),
                    SizedBox(width: 10,),
                    Expanded(
                      flex: 2,
                      child: box(
                        labelText: 'Hour',
                        hintText: '00',
                        validatorFunc: (value) {
                          if (value!=''){
                            if(int.parse(value)<24){
                              return null;
                            } else {
                              return 'Invalid hour';
                            }
                          } else return null;
                        },
                        ctrl: hourCtrl,
                        keyboard: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal:4,
                      ),
                      child: Text(
                      ':',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                          color: Colors.grey[700],
                          textBaseline: TextBaseline.alphabetic,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: box(
                        labelText: 'Minute',
                        hintText: '00',
                        validatorFunc: (value) {
                          if (value!=''){
                            if(int.parse(value)<60){
                              return null;
                            } else {
                              return 'Invalid minute';
                            }
                          } else return null;
                        },
                        ctrl: minuteCtrl,
                        keyboard: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8,),
                Padding(
                  padding: const EdgeInsets.only(
                       left: 14,
                      // right: 8,
                  ),
                  child: Text(
                    'Do not know time? keep it empty',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 13.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                SizedBox(height: 45,),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: MaterialButton(
                    height: 50,
                    child: Text(
                      'Calculate now',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: (){
                      if(formKey.currentState.validate()){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AgeCalcResult(
                                  bDay: int.parse(dayCtrl.text),
                                  bMonth: int.parse(monthCtrl.text),
                                  bYear: int.parse(yearCtrl.text),

                                  bHour: (hourCtrl.text !='')
                                      ? int.parse(hourCtrl.text) : 0,
                                  bMinute: (minuteCtrl.text!='')
                                      ? int.parse(minuteCtrl.text) : 0,
                                  name: (nameCtrl.text!='')
                                      ? nameCtrl.text.replaceRange(0, 1, nameCtrl.text[0].toUpperCase()):'',
                                ),
                            ),
                        );
                      }
                    },
                  ),
                ),
                // SizedBox(height: 10,),

                /// Clear all
                TextButton(
                    onPressed: (){
                      nameCtrl.text=
                      dayCtrl.text=
                      monthCtrl.text=
                      yearCtrl.text=
                      hourCtrl.text=
                      minuteCtrl.text='';
                    },
                    child: Text(
                      'CLEAR',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue[500],
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }




}



Widget title (String title) {

  return Text(
      title,
    style: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 17,
      color: Colors.grey[800],
      textBaseline: TextBaseline.alphabetic,
    ),
  );

}


Widget box ({
  @required TextEditingController ctrl,
  @required String labelText,
  String hintText,
  @required Function validatorFunc,
  Function onSubFunc,
  TextInputType keyboard = TextInputType.number,
}) {
  return Container(
    // height: 50,
    child: TextFormField(
      controller: ctrl,
      style: TextStyle(
        height: 0.75,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: 16,
          color: Colors.grey[600],
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: 18,
          color: Colors.grey[600],
        ),
        errorStyle: TextStyle(
          fontSize: 11,
        ),
        border: OutlineInputBorder(
          gapPadding: 2.5,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      cursorHeight: 25,
      maxLines: 1,
      keyboardType: keyboard,
      validator: validatorFunc,
      textAlign: TextAlign.center,
    ),
  );
}
