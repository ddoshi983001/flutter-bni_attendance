import 'package:bni_attendance/data/data.dart';
import 'package:bni_attendance/helpers/constants.dart';
import 'package:bni_attendance/views/screens/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Map<int, int> indexHash = {};
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Constants.width,
      padding: EdgeInsets.symmetric(horizontal: Constants.width! * 0.04, vertical: Constants.height! * 0.02),
      color: Color(0xffCF2130),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'BNI Attendance',
              style: TextStyle(
                color: Colors.white,
                fontSize: Constants.width! * 0.05,
                fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: Constants.height! * 0.01,),
            Text(
              DateFormat('dd-MM-yyyy').format(DateTime.now()),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Constants.width! * 0.04,
                  fontWeight: FontWeight.w400
              ),
            ),
            SizedBox(height: Constants.height! * 0.04,),
            Wrap(
              children: List.generate(Data.usersData.length, (index){
                return GestureDetector(
                  onTap: () async {
                    var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => Camera()));
                    if(result == true){
                      indexHash[index] = 1;
                      setState((){});
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: Constants.width! * 0.02),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.green, width: indexHash.containsKey(index) == true ? 2 : 0),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage('assets/userImages/${Data.usersData[index][1]}'),
                                backgroundColor: Colors.white,
                              ),
                            ),
                            if(indexHash.containsKey(index) == true)...[
                              Positioned(
                                child: Icon(Icons.thumb_up_alt, color: Colors.green,),
                                left: Constants.width! * 0.11,
                                bottom: Constants.height! * 0.05,
                              )
                            ]

                          ],
                        ),
                        SizedBox(height: Constants.height! * 0.01,),
                        Container(
                          width: Constants.width! * 0.16,
                          child: Text(
                            Data.usersData[index][0],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Constants.width! * 0.03,
                                fontWeight: FontWeight.w600
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: Constants.height! * 0.03,)
                      ],
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
