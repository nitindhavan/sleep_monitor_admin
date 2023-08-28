import 'dart:convert';
import 'dart:html';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sleep_monitor_admin/models/User.dart';
import 'package:sleep_monitor_admin/models/notification.dart';
import 'package:sleep_monitor_admin/report.dart';
import 'package:sleep_monitor_admin/survey.dart';
import 'models/Feedback.dart' as model;
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<User> userList=[];
  bool isList=true;
  bool feedback=false;
  var titleController=TextEditingController();
  var subtitleController=TextEditingController();
  bool notification=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Sleep Monitor Admin'),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Report()));
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Container(
                        color:  Color(0xff5f259f) ,
                            height: 40,
                            width: 40, child : Icon(Icons.insert_page_break)),
                      ),
                      SizedBox(height: 4,),
                      Text("View Report",style: TextStyle(color: Colors.white,fontSize: 12),)
                    ],
                  ),
                ),
                SizedBox(width: 16,),
                GestureDetector(
                onTap:_createExcel,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Container(
                            color:  Color(0xff5f259f) ,
                            height: 40,
                            width: 40, child : Icon(Icons.insert_page_break)),
                      ),
                      SizedBox(height: 4,),
                      Text("Generate Report",style: TextStyle(color: Colors.white,fontSize: 12),)
                    ],
                  ),
                ),

                SizedBox(width: 16,),
                GestureDetector(
                  onTap:(){
                    setState(() {
                      feedback=!feedback;
                    });
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Container(
                            color:  Color(0xff5f259f) ,
                            height: 40,
                            width: 40, child : Icon(Icons.feedback)),
                      ),
                      SizedBox(height: 4,),
                      Text("Feedback",style: TextStyle(color: Colors.white,fontSize: 12),)
                    ],
                  ),
                ),

                SizedBox(width: 16,),
                GestureDetector(
                  onTap:(){
                    setState(() {
                      notification=!notification;
                    });
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Container(
                            color:  Color(0xff5f259f) ,
                            height: 40,
                            width: 40, child : Icon(Icons.notification_add)),
                      ),
                      SizedBox(height: 4,),
                      Text("Send Notification",style: TextStyle(color: Colors.white,fontSize: 12),)
                    ],
                  ),
                ),

              ],
            ),
          ],
        ),
        backgroundColor: Colors.blue.shade300,
      ),
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: FutureBuilder(
                    builder:
                        (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.data!.snapshot.exists) {
                        return Center(
                          child: Text("No users registered yet"),
                        );
                      } else {
                        userList.clear();
                        for (DataSnapshot snap in snapshot.data!.snapshot.children) {
                          User user = User.fromJson(snap.value as Map);
                          userList.add(user);
                        }
                        return ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Container(
                                        margin: EdgeInsets.all(4),
                                        child: Text(
                                          index == 0 ? "Sr. No" : index.toString(),
                                          style: TextStyle(
                                              fontSize: 16, fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ))),
                                Container(
                                  margin: EdgeInsets.all(16),
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white12,
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  child:
                                      index != 0 ? Image.asset('sleep.png') : SizedBox(),
                                ),
                                Expanded(
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SurveyScreen(user: userList[index-1],)));
                                      },
                                        child: Container(
                                            margin: EdgeInsets.all(4),
                                            child: Text(
                                              index == 0
                                                  ? "Student Name"
                                                  : userList[index - 1].name,
                                              style: TextStyle(
                                                  fontSize: index == 0 ? 16 : 14,
                                                  fontWeight: index == 0
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                  color: index == 0
                                                      ? Colors.black
                                                      : Colors.blue),
                                              textAlign: TextAlign.center,
                                            )))),
                                Expanded(
                                    child: Container(
                                        margin: EdgeInsets.all(4),
                                        child: Text(
                                            index == 0
                                                ? "Std/Class"
                                                : userList[index - 1].classNumber,
                                            style: TextStyle(
                                                fontSize: index == 0 ? 16 : 14,
                                                fontWeight: index == 0
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                            textAlign: TextAlign.center))),
                                Expanded(
                                    child: Container(
                                        margin: EdgeInsets.all(4),
                                        child: Text(
                                            index == 0 ? "Div" : userList[index - 1].div,
                                            style: TextStyle(
                                                fontSize: index == 0 ? 16 : 14,
                                                fontWeight: index == 0
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                            textAlign: TextAlign.center))),
                                Expanded(
                                    child: Container(
                                        margin: EdgeInsets.all(4),
                                        child: Text(
                                            index == 0
                                                ? "Height"
                                                : userList[index - 1].height.toString(),
                                            style: TextStyle(
                                                fontSize: index == 0 ? 16 : 14,
                                                fontWeight: index == 0
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                            textAlign: TextAlign.center))),
                                Expanded(
                                    child: Container(
                                        margin: EdgeInsets.all(4),
                                        child: Text(
                                            index == 0
                                                ? "Weight"
                                                : userList[index - 1].weight.toString(),
                                            style: TextStyle(
                                                fontSize: index == 0 ? 16 : 14,
                                                fontWeight: index == 0
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                            textAlign: TextAlign.center))),
                                Expanded(
                                    child: Container(
                                        margin: EdgeInsets.all(4),
                                        child: Text(
                                            index == 0
                                                ? "Gender"
                                                : userList[index - 1].gender,
                                            style: TextStyle(
                                                fontSize: index == 0 ? 16 : 14,
                                                fontWeight: index == 0
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                            textAlign: TextAlign.center))),
                                Expanded(
                                    child: Container(
                                        margin: EdgeInsets.all(4),
                                        child: Text(
                                            index == 0
                                                ? "Fathers Name"
                                                : userList[index - 1].fatherName,
                                            style: TextStyle(
                                                fontSize: index == 0 ? 16 : 14,
                                                fontWeight: index == 0
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                            textAlign: TextAlign.center))),
                                Expanded(
                                    child: Container(
                                        margin: EdgeInsets.all(4),
                                        child: Text(
                                            index == 0
                                                ? "Mothers Name"
                                                : userList[index - 1].motherName,
                                            style: TextStyle(
                                                fontSize: index == 0 ? 16 : 14,
                                                fontWeight: index == 0
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                            textAlign: TextAlign.center))),
                                Expanded(
                                    child: Container(
                                        margin: EdgeInsets.all(4),
                                        child: Text(
                                            index == 0
                                                ? "Fathers Contact"
                                                : userList[index - 1].fatherContact,
                                            style: TextStyle(
                                                fontSize: index == 0 ? 16 : 14,
                                                fontWeight: index == 0
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                            textAlign: TextAlign.center))),
                                Expanded(
                                    child: Container(
                                        margin: EdgeInsets.all(4),
                                        child: Text(
                                            index == 0
                                                ? "Mothers Contact"
                                                : userList[index - 1].motherContact,
                                            style: TextStyle(
                                                fontSize: index == 0 ? 16 : 14,
                                                fontWeight: index == 0
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                            textAlign: TextAlign.center))),
                              ],
                            );
                          },
                          itemCount: userList.length + 1,
                        );
                      }
                      return Container();
                    },
                    future: FirebaseDatabase.instance.ref('users').once(),
                  ),
                ),
              ),
              if(feedback) Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: FutureBuilder(
                    builder:
                        (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.data!.snapshot.exists) {
                        return const Center(
                          child: Text("No feedbacks yet"),
                        );
                      } else {
                        List<model.Feedback> feedbackList=[];
                        for (DataSnapshot snap in snapshot.data!.snapshot.children) {
                          model.Feedback feedback= model.Feedback.fromJson(snap.value as Map);
                          feedbackList.add(feedback);
                        }
                        return ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return FutureBuilder(builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
                              if(!snapshot.hasData) return Container(width: 200,height : 1,child: LinearProgressIndicator());
                              User user=User.fromJson(snapshot.data!.snapshot.value as Map);
                              return Card(
                                color:Color(0xffe5e5ff),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      ClipRRect(borderRadius: BorderRadius.circular(50),child: user.imageUrl != null ? Image.network(user.imageUrl!,height: 50,width: 50,) : Image.asset('sleep.png',height: 60,width: 60,)),
                                      SizedBox(width: 16,),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(user.name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                            SizedBox(height: 8,),
                                            Text(feedbackList[index].feedback),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },future: FirebaseDatabase.instance.ref('users').child(feedbackList[index].uid).once(),);
                          },
                          itemCount: feedbackList.length,
                        );
                      }
                      return Container();
                    },
                    future: FirebaseDatabase.instance.ref('feedback').once(),
                  ),
                ),
              ),
            ],
          ),
          if(notification)Container(
            color: Colors.black54,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.all(16),
                width: 400.0,
                child: Card(
                  color: Colors.white,
                  child: Container(
                    height: 350,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Send Notification",style: TextStyle(color: Colors.black,fontSize: 20),),
                              GestureDetector(onTap: (){
                                setState(() {
                                  notification=!notification;
                                });
                              },child: Icon(Icons.close))
                            ],
                          ),
                          SizedBox(height: 32,),
                          Column(
                            children: [
                              Container(margin: EdgeInsets.only(top: 16,bottom: 16),color: Color(0xffe5e5ff),padding: EdgeInsets.only(left: 16,right: 16),child: TextField(controller: titleController,decoration: InputDecoration(hintText: "Enter Title",border: InputBorder.none,),keyboardType: TextInputType.multiline,maxLines: 1,)),
                              Container(margin: EdgeInsets.only(top: 16,bottom: 16),color: Color(0xffe5e5ff),padding: EdgeInsets.only(left: 16,right: 16),child: TextField(controller: subtitleController,decoration: InputDecoration(hintText: "Enter Subtitle",border: InputBorder.none,),keyboardType: TextInputType.multiline,maxLines: 1,)),
                              SizedBox(height: 16,),
                              GestureDetector(
                                onTap: (){
                                  sendNotification(titleController.text,subtitleController.text);
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Color(0xff5f259f), borderRadius: BorderRadius.circular(32)),
                                  child: Center(child: Text("Send Notification",style: TextStyle(color: Colors.white),)),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),

              ),
            ),
          )
        ],
      ),
    );
  }
  Future<void> _createExcel() async
  {
    //Create a Excel document.
    //Creating a workbook.
    final excel.Workbook workbook = excel.Workbook();
    //Accessing via index.
    final excel.Worksheet sheet = workbook.worksheets[0];
    // Set the text value.

    sheet.getRangeByName('A1').setText("Sr.no");
    sheet.getRangeByName('A1').columnWidth=10;
    sheet.getRangeByName('B1').setText("Student Name");
    sheet.getRangeByName('B1').columnWidth=25;
    sheet.getRangeByName('C1').setText("Std / Class");
    sheet.getRangeByName('C1').columnWidth=10;
    sheet.getRangeByName('D1').setText("Division");
    sheet.getRangeByName('D1').columnWidth=10;
    sheet.getRangeByName('E1').setText("Height");
    sheet.getRangeByName('E1').columnWidth=10;
    sheet.getRangeByName('F1').setText("Weight");
    sheet.getRangeByName('F1').columnWidth=10;
    sheet.getRangeByName('G1').setText("Gender");
    sheet.getRangeByName('G1').columnWidth=10;
    sheet.getRangeByName('H1').setText("Fathers Name");
    sheet.getRangeByName('H1').columnWidth=25;
    sheet.getRangeByName('I1').setText("Mothers Name");
    sheet.getRangeByName('I1').columnWidth=25;
    sheet.getRangeByName('J1').setText("Fathers Contact");
    sheet.getRangeByName('J1').columnWidth=25;
    sheet.getRangeByName('K1').setText("Mothers Contact");
    sheet.getRangeByName('K1')..columnWidth=25;

    for(User user in userList){
      sheet.rows.add();
      int index=userList.indexOf(user)+2;
      sheet.getRangeByName('A$index').setText((index-1).toString());
      sheet.getRangeByName('B$index').setText(user.name);
      sheet.getRangeByName('C$index').setText(user.classNumber);
      sheet.getRangeByName('D$index').setText(user.div);
      sheet.getRangeByName('E$index').setText(user.height.toString());
      sheet.getRangeByName('F$index').setText(user.weight.toString());
      sheet.getRangeByName('G$index').setText(user.gender.toString());
      sheet.getRangeByName('H$index').setText(user.fatherName.toString());
      sheet.getRangeByName('I$index').setText(user.motherName.toString());
      sheet.getRangeByName('J$index').setText(user.fatherName.toString());
      sheet.getRangeByName('K$index').setText(user.motherName.toString());
    }

    //Save and launch the excel.
    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.
    workbook.dispose();

    AnchorElement(
        href:
        "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "output.xlsx")
      ..click();

  }

  void sendNotification(String title, String subtitle) {
    var reference=FirebaseDatabase.instance.ref("notifications");
    String id=reference.push().key!;
    NotificationModel model=NotificationModel(id, title, subtitle);
    reference.child(id).set(model.toMap()).then((value){
      callOnFcmApiSendPushNotifications(title,subtitle).then((value){
        setState(() {
          notification=!notification;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Notification was sent")));
        });
      });
    });
  }
  Future<bool> callOnFcmApiSendPushNotifications(String title,String subTitle) async {

    final postUrl = 'https://fcm.googleapis.com/fcm/send';

    String toParams = "/topics/"+'all';
    final data = {
      "notification": {"body":"$subTitle", "title":"$title"},
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done",
        "sound": 'default',
        "screen": "yourTopicName",
      },
      "to": "${toParams}"};

    final headers = {
      'content-type': 'application/json',
      'Authorization': 'key=AAAAsR_WWGw:APA91bG4lPXRyDBaRY0gYbJ_B8256cFa27tuh8_bKBWPubEDzi0rF5Pp4qhnKAdUJUrW6IvHRq_PZzVOa4r2A9HU9g6kf-63q55Z125iYpmWUMt919G0euGEFAyF8tkXlmq-i_xLL-s8' // 'key=YOUR_SERVER_KEY'
    };

    final response = await http.post(Uri.parse(postUrl),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      // on success do sth
      print('test ok push CFM');
      return true;
    } else {
      print(response.statusCode);
      // on failure do sth
      return false;
    }
  }
}
