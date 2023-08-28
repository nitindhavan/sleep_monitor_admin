import 'dart:convert';
import 'dart:html';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sleep_monitor_admin/survey.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;

import 'models/Survey.dart';
import 'models/User.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  List<Survey> surveyList = [];
  String currentWeek='Week1';
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
          ],
        ),
        backgroundColor: Colors.blue.shade300,
      ),
      body: Row(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        currentWeek='Week1';
                      });
                    },
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white
                      ),
                      child: Center(child: Text('Week 1',style: TextStyle(color: currentWeek=='Week1'?  Colors.blue: Colors.black ),)),
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        currentWeek='Week2';
                      });
                    },
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white
                      ),
                      child: Center(child: Text('Week 2',style: TextStyle(color: currentWeek=='Week2'?  Colors.blue: Colors.black ),)),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        currentWeek='Week3';
                      });
                    },
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white
                      ),
                      child: Center(child: Text('Week 3',style: TextStyle(color: currentWeek=='Week3'?  Colors.blue: Colors.black ),)),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        currentWeek='Week4';
                      });
                    },
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white
                      ),
                      child: Center(child: Text('Week 4',style: TextStyle(color: currentWeek=='Week4'?  Colors.blue: Colors.black ),)),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        currentWeek='Week5';
                      });
                    },
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white
                      ),
                      child: Center(child: Text('Week 5',style: TextStyle(color: currentWeek=='Week5'?  Colors.blue: Colors.black ),)),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        currentWeek='Week6';
                      });
                    },
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white
                      ),
                      child: Center(child: Text('Week 6',style: TextStyle(color: currentWeek=='Week6'?  Colors.blue: Colors.black ),)),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        currentWeek='Week7';
                      });
                    },
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white
                      ),
                      child: Center(child: Text('Week 7',style: TextStyle(color: currentWeek=='Week7'?  Colors.blue: Colors.black ),)),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        currentWeek='Week8';
                      });
                    },
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white
                      ),
                      child: Center(child: Text('Week 8',style: TextStyle(color: currentWeek=='Week8'?  Colors.blue: Colors.black ),)),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Expanded(
                  child: GestureDetector(onTap: (){
                      setState(() {
                        currentWeek='Week9';
                      });
                    },
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white
                      ),
                      child: Center(child: Text('Week 9',style: TextStyle(color: currentWeek=='Week9'?  Colors.blue: Colors.black ),)),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        currentWeek='Week10';
                      });
                    },
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white
                      ),
                      child: Center(child: Text('Week 10',style: TextStyle(color: currentWeek=='Week10'?  Colors.blue: Colors.black ),)),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        currentWeek='Week11';
                      });
                    },
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white
                      ),
                      child: Center(child: Text('Week 11',style: TextStyle(color: currentWeek=='Week11'?  Colors.blue: Colors.black ),)),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        currentWeek='Week12';
                      });
                    },
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white
                      ),
                      child: Center(child: Text('Week 12',style: TextStyle(color: currentWeek=='Week12'?  Colors.blue: Colors.black ),)),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: FutureBuilder(
                key: Key(currentWeek),
                builder:
                    (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.data!.snapshot.exists) {
                    return Center(
                      child: Text("No Survey Available"),
                    );
                  } else {
                    surveyList.clear();
                    for (DataSnapshot snap in snapshot.data!.snapshot.children) {
                      Survey survey = Survey.fromJson(snap.value as Map);
                      if(survey.week==currentWeek) {
                        surveyList.add(survey);
                      }
                    }
                    if(surveyList.isEmpty)return Center(
                      child: Text("No Data Available"),
                    );
                    return ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(16),
                                child: Text(
                                  index == 0 ? "Sr. No" : index.toString(),
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              child: index==0 ? Container(
                                margin: EdgeInsets.all(16),
                                child: Text("Student Name",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ) : FutureBuilder(builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
                                if(!snapshot.hasData) return LinearProgressIndicator();
                                surveyList[index-1].name=snapshot.data!.snapshot.value as String;
                                return Container(
                                  margin: EdgeInsets.all(16),
                                  child: Text(
                                    snapshot.data!.snapshot.value as String,
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              },future: FirebaseDatabase.instance.ref('users').child(surveyList[index-1].uid).child('name').once(),),

                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(16),
                                child: Text(
                                  index == 0 ? "Sleep Duration" : durationScore(surveyList[index-1].answers).toString(),
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(16),
                                child: Text(
                                  index == 0 ? "Sleep Lag" : 56 - durationScore(surveyList[index-1].answers) < 0 ? '0' : (56 - durationScore(surveyList[index-1].answers)).toString(),
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),

                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(16),
                                child: Text(
                                  index == 0 ? "Regularity" : regurality(surveyList[index-1].answers) ? 'Regular' : 'Irregular',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(16),
                                child: Text(
                                  index == 0 ? "Sleep Hygiene Compliance" : sleepHygine(surveyList[index-1].answers).toString(),
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(16),
                                child: Text(
                                  index == 0 ? "Overall Sleep Health" : grandTotal(surveyList[index-1].answers).toString(),
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: surveyList.length + 1,
                    );
                  }
                  return Container();
                },
                future: FirebaseDatabase.instance.ref('surveys').once(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _createExcel() {

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
    sheet.getRangeByName('C1').setText("Sleep Duration");
    sheet.getRangeByName('C1').columnWidth=10;
    sheet.getRangeByName('D1').setText("Sleep Lag");
    sheet.getRangeByName('D1').columnWidth=10;
    sheet.getRangeByName('E1').setText("Regularity");
    sheet.getRangeByName('E1').columnWidth=10;
    sheet.getRangeByName('F1').setText("Sleep Hygiene Compliance");
    sheet.getRangeByName('F1').columnWidth=25;
    sheet.getRangeByName('G1').setText("Overall Sleep Health");
    sheet.getRangeByName('G1').columnWidth=25;

    for(Survey survey in surveyList){
      int index=surveyList.indexOf(survey)+2;
      sheet.getRangeByName('A$index').setText((index-1).toString());
      sheet.getRangeByName('B$index').setText(survey.name);
      sheet.getRangeByName('C$index').setText(durationScore(survey.answers).toString());
      sheet.getRangeByName('D$index').setText(56 - durationScore(survey.answers) < 0 ? '0' : (56 - durationScore(survey.answers)).toString());
      sheet.getRangeByName('E$index').setText(regurality(survey.answers) ? "Regular" : "Irregular");
      sheet.getRangeByName('F$index').setText(sleepHygine(survey.answers).toString());
      sheet.getRangeByName('G$index').setText(grandTotal(survey.answers).toString());
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

  int durationScore(List<int> answerList) {
    int totalDuration=63;
    totalDuration-= 5 * answerList[0];
    totalDuration+= 5 *answerList[1];
    totalDuration-= 2 * answerList[2];
    totalDuration+= 2 *answerList[3];
    return totalDuration;
  }
  bool regurality(List<int> answerList){
    return answerList[0] - answerList[1] == answerList[2]- answerList[3];
  }

  int grandTotal(List<int> answerList) {
    int total=0;
    if(answerList[10]==0)total++;
    if(answerList[11]==0)total++;
    if(answerList[12]==0)total++;
    if(answerList[13]==1)total++;
    if(answerList[14]==1)total++;
    if(answerList[15]==0)total++;
    if(answerList[16]==1)total++;
    if(answerList[17]==1)total++;
    if(answerList[18]==1)total++;
    if(answerList[19]==0)total++;

    if(durationScore(answerList) >= 56) total+=2;

    if(durationScore(answerList) >= 49 && (durationScore(answerList) < 56 )) total++;

    if(56 - durationScore(answerList) < 1) total+=2;

    if(56-durationScore(answerList) > 0 && 56-durationScore(answerList) <=7) total++;

    if(regurality(answerList)) total++;
    return total;
  }

  int sleepHygine(List<int> answerList) {
    int total=0;
    if(answerList[10]==0)total++;
    if(answerList[11]==0)total++;
    if(answerList[12]==0)total++;
    if(answerList[13]==1)total++;
    if(answerList[14]==1)total++;
    if(answerList[15]==0)total++;
    if(answerList[16]==1)total++;
    if(answerList[17]==1)total++;
    if(answerList[18]==1)total++;
    if(answerList[19]==0)total++;
    return total;
  }

}
