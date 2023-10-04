import 'dart:convert';
import 'dart:html';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sleep_monitor_admin/survey.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;

import 'models/Survey.dart';
import 'models/User.dart';

class QuestionReport extends StatefulWidget {
  const QuestionReport({Key? key,required this.user}) : super(key: key);

  final User user;


  @override
  State<QuestionReport> createState() => _QuestionReportState();
}

class _QuestionReportState extends State<QuestionReport> {
  List<Survey?> surveyList = [];
  String currentWeek='Week1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: FutureBuilder<DatabaseEvent>(
          future: FirebaseDatabase.instance.ref('surveys').orderByChild('uid').equalTo(widget.user.uid).once(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.data!.snapshot.exists) {
            return const Center(child: Text("Survey Submitted yet"),);
          } else {
            for (int i = 0; i < 12; i++) {
              surveyList.add(null);
            }
            for (DataSnapshot snap in snapshot.data!.snapshot.children) {
              Survey survey = Survey.fromJson(snap.value as Map);
              int index = int.parse(survey.week.replaceAll("Week", ""));
              surveyList[index - 1] = survey;
              // surveyList.add(survey);
            }
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: _createExcel,
                      child: Row(
                        children: [
                          Expanded(child: Text("Question wise report",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Container(
                                color: Color(0xff5f259f),
                                height: 40,
                                width: 40,
                                child: Icon(Icons.insert_page_break)),
                          ),
                          SizedBox(width: 8,),
                          Text("Generate Question Report", style: TextStyle(
                              color: Colors.white, fontSize: 12),)
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(itemBuilder: (BuildContext context, int index) {
                    // return Text("Hello");
                    if(index==0){
                      return Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 30,),
                            Container(
                              width: 70,
                              child: Text("Question",
                                style: TextStyle(
                                    color: Colors.black),),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                child: ListView.builder(scrollDirection: Axis.horizontal,itemBuilder: (BuildContext context, int index2) {
                                  return Container(
                                    width: 40,
                                    padding: const EdgeInsets.only(top:16.0,bottom: 16),
                                    child: Text("Q${index2+1}"),
                                  );
                                },itemCount: 21),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                    Survey? survey=surveyList[index-1];
                    if(survey==null)return SizedBox();
                    return Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 30,),
                            Container(
                              width: 70,
                              child: Text(survey.week,
                                style: TextStyle(
                                    color: Colors.black),),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                child: ListView.builder(scrollDirection: Axis.horizontal,itemBuilder: (BuildContext context, int index2) {
                                  return Container(
                                    width: 40,
                                    padding: const EdgeInsets.only(top:16.0,bottom: 16),
                                    child: Text("${surveyList[index-1]!.answers[index2]+1}"),
                                  );
                                },itemCount: surveyList[index-1]!.answers.length,),
                              ),
                            )
                          ],
                        ),
                      );
                  },itemCount: surveyList.length+1,),
                ),
              ],
            );
          }
        }
        )
    );
  }

  void _createExcel() {

    //Create a Excel document.
    //Creating a workbook.
    final excel.Workbook workbook = excel.Workbook();
    //Accessing via index.
    final excel.Worksheet sheet = workbook.worksheets[0];
    // Set the text value.

    sheet.getRangeByName('A1').setText("Week");
    sheet.getRangeByName('A1').columnWidth=25;
    sheet.getRangeByName('B1').setText("Q1");
    sheet.getRangeByName('C1').setText("Q2");
    sheet.getRangeByName('D1').setText("Q3");
    sheet.getRangeByName('E1').setText("Q4");
    sheet.getRangeByName('F1').setText("Q5");
    sheet.getRangeByName('G1').setText("Q6");
    sheet.getRangeByName('H1').setText("Q7");
    sheet.getRangeByName('I1').setText("Q8");
    sheet.getRangeByName('J1').setText("Q9");
    sheet.getRangeByName('K1').setText("Q10");
    sheet.getRangeByName('L1').setText("Q11");
    sheet.getRangeByName('M1').setText("Q12");
    sheet.getRangeByName('N1').setText("Q13");
    sheet.getRangeByName('O1').setText("Q14");
    sheet.getRangeByName('P1').setText("Q15");
    sheet.getRangeByName('Q1').setText("Q16");
    sheet.getRangeByName('R1').setText("Q17");
    sheet.getRangeByName('S1').setText("Q18");
    sheet.getRangeByName('T1').setText("Q19");
    sheet.getRangeByName('U1').setText("Q20");
    sheet.getRangeByName('V1').setText("Q21");

    int index=1;

    for(Survey? survey in surveyList){
      if(survey!=null) {
        index++;
        sheet.getRangeByName('A$index').setText(survey.week);
        sheet.getRangeByName('B$index').setText((survey.answers[0]+1).toString());
        sheet.getRangeByName('C$index').setText((survey.answers[1]+1).toString());
        sheet.getRangeByName('D$index').setText((survey.answers[2]+1).toString());
        sheet.getRangeByName('E$index').setText((survey.answers[3]+1).toString());
        sheet.getRangeByName('F$index').setText((survey.answers[4]+1).toString());
        sheet.getRangeByName('G$index').setText((survey.answers[5]+1).toString());
        sheet.getRangeByName('H$index').setText((survey.answers[6]+1).toString());
        sheet.getRangeByName('I$index').setText((survey.answers[7]+1).toString());
        sheet.getRangeByName('J$index').setText((survey.answers[8]+1).toString());
        sheet.getRangeByName('K$index').setText((survey.answers[8]+1).toString());
        sheet.getRangeByName('L$index').setText((survey.answers[10]+1).toString());
        sheet.getRangeByName('M$index').setText((survey.answers[11]+1).toString());
        sheet.getRangeByName('N$index').setText((survey.answers[12]+1).toString());
        sheet.getRangeByName('O$index').setText((survey.answers[13]+1).toString());
        sheet.getRangeByName('P$index').setText((survey.answers[14]+1).toString());
        sheet.getRangeByName('Q$index').setText((survey.answers[15]+1).toString());
        sheet.getRangeByName('R$index').setText((survey.answers[16]+1).toString());
        sheet.getRangeByName('S$index').setText((survey.answers[17]+1).toString());
        sheet.getRangeByName('T$index').setText((survey.answers[18]+1).toString());
        sheet.getRangeByName('U$index').setText((survey.answers[19]+1).toString());
        sheet.getRangeByName('V$index').setText((survey.answers[20]+1).toString());
      }
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
