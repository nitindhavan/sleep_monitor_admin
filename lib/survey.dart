import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sleep_monitor_admin/models/Survey.dart';
import 'package:sleep_monitor_admin/models/User.dart';

import 'multi_month_report.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({Key? key,required this.user}) : super(key: key);

  final User user;

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  bool isWeekly=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        title: Row(
          children: [
            Text('Sleep Monitor Admin'),
            Expanded(child: GestureDetector(onTap: (){
              setState(() {
                isWeekly=!isWeekly;
              });
            },child: Container(alignment: Alignment.centerRight,child: Icon(Icons.change_circle_outlined))))
          ],
        ),
        backgroundColor: Colors.blue.shade300,
      ),
      body: isWeekly ? Container(
        margin: EdgeInsets.all(32),
        padding: EdgeInsets.all(16),
        width: double.infinity,
        child: FutureBuilder(builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }
          if(!snapshot.data!.snapshot.exists){
            return const Center(child: Text("Survey Submitted yet"),);
          }else{
            List<Survey> surveyList=[];
            List<Widget> weekList=[];
            for(DataSnapshot snap in snapshot.data!.snapshot.children) {
              Survey survey = Survey.fromJson(snap.value as Map);
              surveyList.add(survey);
            }
            surveyList.sort((a, b) => a.week.compareTo(b.week));
            for(int i=1 ; i<=12;i++){
              weekList.add(Expanded(child: Text('Week $i',textAlign: TextAlign.center,)));
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text("Sleep Duration",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 16,),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Bar(height: durationScore(surveyList[0].answers)*2,label: Text('Week 1'),topLabel: Text('${durationScore(surveyList[0].answers)}'),),
                          if(surveyList.length>1)Bar(height: durationScore(surveyList[1].answers)*2,label: Text('Week 2'),topLabel: Text('${durationScore(surveyList[1].answers)}'),),
                          if(surveyList.length>2)Bar(height: durationScore(surveyList[2].answers)*2,label: Text('Week 3'),topLabel: Text('${durationScore(surveyList[2].answers)}'),),
                          if(surveyList.length>3)Bar(height: durationScore(surveyList[3].answers)*2,label: Text('Week 4'),topLabel: Text('${durationScore(surveyList[3].answers)}'),),
                          if(surveyList.length>4)Bar(height: durationScore(surveyList[4].answers)*2,label: Text('Week 5'),topLabel: Text('${durationScore(surveyList[4].answers)}'),),
                          if(surveyList.length>5)Bar(height: durationScore(surveyList[5].answers)*2,label: Text('Week 6'),topLabel: Text('${durationScore(surveyList[5].answers)}'),),
                          if(surveyList.length>6)Bar(height: durationScore(surveyList[6].answers)*2,label: Text('Week 7'),topLabel: Text('${durationScore(surveyList[6].answers)}'),),
                          if(surveyList.length>7)Bar(height: durationScore(surveyList[7].answers)*2,label: Text('Week 8'),topLabel: Text('${durationScore(surveyList[7].answers)}'),),
                          if(surveyList.length>8)Bar(height: durationScore(surveyList[8].answers)*2,label: Text('Week 9'),topLabel: Text('${durationScore(surveyList[8].answers)}'),),
                          if(surveyList.length>9)Bar(height: durationScore(surveyList[9].answers)*2,label: Text('Week 10'),topLabel: Text('${durationScore(surveyList[9].answers)}'),),
                          if(surveyList.length>10)Bar(height:durationScore(surveyList[10].answers)*2,label: Text('Week 11'),topLabel: Text('${durationScore(surveyList[10].answers)}'),),
                          if(surveyList.length>11)Bar(height:durationScore(surveyList[11].answers)*2,label: Text('Week 12'),topLabel: Text('${durationScore(surveyList[11].answers)}'),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 32,),
                  Text("Nap",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 16,),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height: 200,),
                          Bar(height: (surveyList[0].answers[4])*50,label: Text('Week 1'),topLabel: Text(getNapData(surveyList[0].answers,4),)),
                          if(surveyList.length>1)Bar(height: (surveyList[1].answers[4])*50,label: Text('Week 2'),topLabel: Text(getNapData(surveyList[1].answers,4),)),
                          if(surveyList.length>2)Bar(height: (surveyList[2].answers[4])*50,label: Text('Week 3'),topLabel: Text(getNapData(surveyList[2].answers,4),)),
                          if(surveyList.length>3)Bar(height: (surveyList[3].answers[4])*50,label: Text('Week 4'),topLabel: Text(getNapData(surveyList[3].answers,4),)),
                          if(surveyList.length>4)Bar(height: (surveyList[4].answers[4])*50,label: Text('Week 5'),topLabel: Text(getNapData(surveyList[4].answers,4),)),
                          if(surveyList.length>5)Bar(height: (surveyList[5].answers[4])*50,label: Text('Week 6'),topLabel: Text(getNapData(surveyList[5].answers,4),)),
                          if(surveyList.length>6)Bar(height: (surveyList[6].answers[4])*50,label: Text('Week 7'),topLabel: Text(getNapData(surveyList[6].answers,4),)),
                          if(surveyList.length>7)Bar(height: (surveyList[7].answers[4])*50,label: Text('Week 8'),topLabel: Text(getNapData(surveyList[7].answers,4),)),
                          if(surveyList.length>8)Bar(height: (surveyList[8].answers[4])*50,label: Text('Week 9'),topLabel: Text(getNapData(surveyList[8].answers,4),)),
                          if(surveyList.length>9)Bar(height: (surveyList[9].answers[4])*50,label: Text('Week 10'),topLabel: Text(getNapData(surveyList[9].answers,4),)),
                          if(surveyList.length>10)Bar(height:(surveyList[10].answers[4])*50,label: Text('Week 11'),topLabel: Text(getNapData(surveyList[10].answers,4),),),
                          if(surveyList.length>11)Bar(height:(surveyList[11].answers[4])*50,label: Text('Week 12'),topLabel: Text(getNapData(surveyList[11].answers,4),)),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 32,),
                  Text("Physical exercise / Sports Activity",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 16,),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height: 200,),
                          Bar(height: (surveyList[0].answers[5])*50,label: Text('Week 1'),topLabel: Text(getNapData(surveyList[0].answers,5),)),
                          if(surveyList.length>1)Bar(height: (surveyList[1].answers[5])*50,label: Text('Week 2'),topLabel: Text(getNapData(surveyList[1].answers,5),)),
                          if(surveyList.length>2)Bar(height: (surveyList[2].answers[5])*50,label: Text('Week 3'),topLabel: Text(getNapData(surveyList[2].answers,5),)),
                          if(surveyList.length>3)Bar(height: (surveyList[3].answers[5])*50,label: Text('Week 4'),topLabel: Text(getNapData(surveyList[3].answers,5),)),
                          if(surveyList.length>4)Bar(height: (surveyList[4].answers[5])*50,label: Text('Week 5'),topLabel: Text(getNapData(surveyList[4].answers,5),)),
                          if(surveyList.length>5)Bar(height: (surveyList[5].answers[5])*50,label: Text('Week 6'),topLabel: Text(getNapData(surveyList[5].answers,5),)),
                          if(surveyList.length>6)Bar(height: (surveyList[6].answers[5])*50,label: Text('Week 7'),topLabel: Text(getNapData(surveyList[6].answers,5),)),
                          if(surveyList.length>7)Bar(height: (surveyList[7].answers[5])*50,label: Text('Week 8'),topLabel: Text(getNapData(surveyList[7].answers,5),)),
                          if(surveyList.length>8)Bar(height: (surveyList[8].answers[5])*50,label: Text('Week 9'),topLabel: Text(getNapData(surveyList[8].answers,5),)),
                          if(surveyList.length>9)Bar(height: (surveyList[9].answers[5])*50,label: Text('Week 10'),topLabel: Text(getNapData(surveyList[9].answers,5),)),
                          if(surveyList.length>10)Bar(height:(surveyList[10].answers[5])*50,label: Text('Week 11'),topLabel: Text(getNapData(surveyList[10].answers,5),),),
                          if(surveyList.length>11)Bar(height:(surveyList[11].answers[5])*50,label: Text('Week 12'),topLabel: Text(getNapData(surveyList[11].answers,5),)),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 32,),
                  Text("Junk Food",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 16,),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height: 200,),
                          Bar(height: (surveyList[0].answers[6])*50,label: Text('Week 1'),topLabel: Text(getNapData(surveyList[0].answers,6),)),
                          if(surveyList.length>1)Bar(height: (surveyList[1].answers[6])*50,label: Text('Week 2'),topLabel: Text(getNapData(surveyList[1].answers,6),)),
                          if(surveyList.length>2)Bar(height: (surveyList[2].answers[6])*50,label: Text('Week 3'),topLabel: Text(getNapData(surveyList[2].answers,6),)),
                          if(surveyList.length>3)Bar(height: (surveyList[3].answers[6])*50,label: Text('Week 4'),topLabel: Text(getNapData(surveyList[3].answers,6),)),
                          if(surveyList.length>4)Bar(height: (surveyList[4].answers[6])*50,label: Text('Week 5'),topLabel: Text(getNapData(surveyList[4].answers,6),)),
                          if(surveyList.length>5)Bar(height: (surveyList[5].answers[6])*50,label: Text('Week 6'),topLabel: Text(getNapData(surveyList[5].answers,6),)),
                          if(surveyList.length>6)Bar(height: (surveyList[6].answers[6])*50,label: Text('Week 7'),topLabel: Text(getNapData(surveyList[6].answers,6),)),
                          if(surveyList.length>7)Bar(height: (surveyList[7].answers[6])*50,label: Text('Week 8'),topLabel: Text(getNapData(surveyList[7].answers,6),)),
                          if(surveyList.length>8)Bar(height: (surveyList[8].answers[6])*50,label: Text('Week 9'),topLabel: Text(getNapData(surveyList[8].answers,6),)),
                          if(surveyList.length>9)Bar(height: (surveyList[9].answers[6])*50,label: Text('Week 10'),topLabel: Text(getNapData(surveyList[9].answers,6),)),
                          if(surveyList.length>10)Bar(height:(surveyList[10].answers[6])*50,label: Text('Week 11'),topLabel: Text(getNapData(surveyList[10].answers,6),),),
                          if(surveyList.length>11)Bar(height:(surveyList[11].answers[6])*50,label: Text('Week 12'),topLabel: Text(getNapData(surveyList[11].answers,6),)),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 32,),
                  Text("Cafinated Beverages",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 16,),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height: 200,),
                          Bar(height: (surveyList[0].answers[7])*50,label: Text('Week 1'),topLabel: Text(getNapData(surveyList[0].answers,7),)),
                          if(surveyList.length>1)Bar(height: (surveyList[1].answers[7])*50,label: Text('Week 2'),topLabel: Text(getNapData(surveyList[1].answers,7),)),
                          if(surveyList.length>2)Bar(height: (surveyList[2].answers[7])*50,label: Text('Week 3'),topLabel: Text(getNapData(surveyList[2].answers,7),)),
                          if(surveyList.length>3)Bar(height: (surveyList[3].answers[7])*50,label: Text('Week 4'),topLabel: Text(getNapData(surveyList[3].answers,7),)),
                          if(surveyList.length>4)Bar(height: (surveyList[4].answers[7])*50,label: Text('Week 5'),topLabel: Text(getNapData(surveyList[4].answers,7),)),
                          if(surveyList.length>5)Bar(height: (surveyList[5].answers[7])*50,label: Text('Week 6'),topLabel: Text(getNapData(surveyList[5].answers,7),)),
                          if(surveyList.length>6)Bar(height: (surveyList[6].answers[7])*50,label: Text('Week 7'),topLabel: Text(getNapData(surveyList[6].answers,7),)),
                          if(surveyList.length>7)Bar(height: (surveyList[7].answers[7])*50,label: Text('Week 8'),topLabel: Text(getNapData(surveyList[7].answers,7),)),
                          if(surveyList.length>8)Bar(height: (surveyList[8].answers[7])*50,label: Text('Week 9'),topLabel: Text(getNapData(surveyList[8].answers,7),)),
                          if(surveyList.length>9)Bar(height: (surveyList[9].answers[7])*50,label: Text('Week 10'),topLabel: Text(getNapData(surveyList[9].answers,7),)),
                          if(surveyList.length>10)Bar(height:(surveyList[10].answers[7])*50,label: Text('Week 11'),topLabel: Text(getNapData(surveyList[10].answers,7),),),
                          if(surveyList.length>11)Bar(height:(surveyList[11].answers[7])*50,label: Text('Week 12'),topLabel: Text(getNapData(surveyList[11].answers,7),)),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 32,),
                  Text("Mood",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 16,),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height: 200,),
                          Bar(height: (surveyList[0].answers[8])*50,label: Text('Week 1'),topLabel: getMoodData(surveyList[0].answers,8,),color: Colors.white,),
                          if(surveyList.length>1)Bar(height: (surveyList[1].answers[8])*50,label: Text('Week 2'),topLabel: getMoodData(surveyList[1].answers,8,),color: Colors.white,),
                          if(surveyList.length>2)Bar(height: (surveyList[2].answers[8])*50,label: Text('Week 3'),topLabel: getMoodData(surveyList[2].answers,8,),color: Colors.white,),
                          if(surveyList.length>3)Bar(height: (surveyList[3].answers[8])*50,label: Text('Week 4'),topLabel: getMoodData(surveyList[3].answers,8,),color: Colors.white,),
                          if(surveyList.length>4)Bar(height: (surveyList[4].answers[8])*50,label: Text('Week 5'),topLabel: getMoodData(surveyList[4].answers,8,),color: Colors.white,),
                          if(surveyList.length>5)Bar(height: (surveyList[5].answers[8])*50,label: Text('Week 6'),topLabel: getMoodData(surveyList[5].answers,8,),color: Colors.white,),
                          if(surveyList.length>6)Bar(height: (surveyList[6].answers[8])*50,label: Text('Week 7'),topLabel: getMoodData(surveyList[6].answers,8,),color: Colors.white,),
                          if(surveyList.length>7)Bar(height: (surveyList[7].answers[8])*50,label: Text('Week 8'),topLabel: getMoodData(surveyList[7].answers,8,),color: Colors.white,),
                          if(surveyList.length>8)Bar(height: (surveyList[8].answers[8])*50,label: Text('Week 9'),topLabel: getMoodData(surveyList[8].answers,8,),color: Colors.white,),
                          if(surveyList.length>9)Bar(height: (surveyList[9].answers[8])*50,label: Text('Week 10'),topLabel: getMoodData(surveyList[9].answers,8,),color: Colors.white,),
                          if(surveyList.length>10)Bar(height:(surveyList[10].answers[8])*50,label: Text('Week 11'),topLabel: getMoodData(surveyList[10].answers,8,),color: Colors.white,),
                          if(surveyList.length>11)Bar(height:(surveyList[11].answers[8])*50,label: Text('Week 12'),topLabel: getMoodData(surveyList[11].answers,8),color: Colors.white,),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 32,),
                  Text("Screen Time",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 16,),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height: 200,),
                          Bar(height: (surveyList[0].answers[9])*50,label: Text('Week 1'),topLabel: Text(getScreenData(surveyList[0].answers,9),)),
                          if(surveyList.length>1)Bar(height: (surveyList[1].answers[9])*50,label: Text('Week 2'),topLabel: Text(getScreenData(surveyList[1].answers,9),)),
                          if(surveyList.length>2)Bar(height: (surveyList[2].answers[9])*50,label: Text('Week 3'),topLabel: Text(getScreenData(surveyList[2].answers,9),)),
                          if(surveyList.length>3)Bar(height: (surveyList[3].answers[9])*50,label: Text('Week 4'),topLabel: Text(getScreenData(surveyList[3].answers,9),)),
                          if(surveyList.length>4)Bar(height: (surveyList[4].answers[9])*50,label: Text('Week 5'),topLabel: Text(getScreenData(surveyList[4].answers,9),)),
                          if(surveyList.length>5)Bar(height: (surveyList[5].answers[9])*50,label: Text('Week 6'),topLabel: Text(getScreenData(surveyList[5].answers,9),)),
                          if(surveyList.length>6)Bar(height: (surveyList[6].answers[9])*50,label: Text('Week 7'),topLabel: Text(getScreenData(surveyList[6].answers,9),)),
                          if(surveyList.length>7)Bar(height: (surveyList[7].answers[9])*50,label: Text('Week 8'),topLabel: Text(getScreenData(surveyList[7].answers,9),)),
                          if(surveyList.length>8)Bar(height: (surveyList[8].answers[9])*50,label: Text('Week 9'),topLabel: Text(getScreenData(surveyList[8].answers,9),)),
                          if(surveyList.length>9)Bar(height: (surveyList[9].answers[9])*50,label: Text('Week 10'),topLabel: Text(getScreenData(surveyList[9].answers,9),)),
                          if(surveyList.length>10)Bar(height:(surveyList[10].answers[9])*50,label: Text('Week 11'),topLabel: Text(getScreenData(surveyList[10].answers,9),),),
                          if(surveyList.length>11)Bar(height:(surveyList[11].answers[9])*50,label: Text('Week 12'),topLabel: Text(getScreenData(surveyList[11].answers,9),)),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            );

          }
          return Container();
        },future: FirebaseDatabase.instance.ref('surveys').orderByChild('uid').equalTo(widget.user.uid).once(),),
      ) : MultiMonthReport(user: widget.user.uid,),
    );
  }

  List<num> getData(List<Survey> surveyList) {
    List<num> list=[];
    for(int i=1;i<=12;i++){
      String text='Week$i';
      bool contains=false;
      for(Survey s in surveyList) {
        if(s.week==text) {
          list.add(durationScore(s.answers));
          contains=true;
        }
      }
      if(!contains) list.add(0);
    }

    return list;
  }

  int durationScore(List<int> answerList) {
    int totalDuration=63;
    totalDuration-= 5 * answerList[0];
    totalDuration+= 5 *answerList[1];
    totalDuration-= 2 * answerList[2];
    totalDuration+= 2 *answerList[3];
    return totalDuration;
  }

  String getNapData(List<int> answerList,int index) {
    int answer=answerList[index];
    print(answer);
    switch (answer){
      case 0:
        return '0 times';
      case 1:
        return '1-2 Times';
      case 2:
        return '3-4 times';
      case 3:
        return '5-6 times';
      default:
        return 'Everyday';
    }
  }
  String getScreenData(List<int> answerList,int index) {
    int answer=answerList[index];
    print(answer);
    switch (answer){
      case 0:
        return '0-2 Hours';
      case 1:
        return '3-5 Hours';
      case 2:
        return '6-8 Hours';
      case 3:
        return '9-12 Hours';
      default:
        return 'More than 12 Hrs';
    }
  }
  Widget getMoodData(List<int> answerList,int index) {
    int answer=answerList[index];
    print(answer);
    switch (answer){
      case 0:
        return Column(
          children: [
            Image.asset('picture5.png',height: 50,width: 50,),
          ],
        );
      case 1:
        return Column(
          children: [
            Image.asset('picture4.png',height: 50,width: 50,),
          ],
        );
      case 2:
        return Column(
          children: [
            Image.asset('picture3.png',height: 50,width: 50,),
          ],
        );
      case 3:
        return Column(
          children: [
            Image.asset('picture1.png',height: 50,width: 50,),
          ],
        );
      default:
        return Column(
          children: [
            Image.asset('picture2.png',height: 50,width: 50,),
          ],
        );
    }
  }

}

class Bar extends StatelessWidget {
  const Bar({Key? key,required this.height,this.label,this.topLabel,this.color}) : super(key: key);

  final int height;

  final Color? color;
  final Widget? label;
  final Widget? topLabel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(topLabel!=null)topLabel!,
        Container(height: height.toDouble(),width: 60,color: color ?? Colors.blue,margin: EdgeInsets.all(16),),
        if(label!=null)label!,
        SizedBox(height: 16,)
      ],
    );
  }
}

