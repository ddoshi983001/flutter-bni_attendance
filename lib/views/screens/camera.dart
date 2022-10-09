import 'package:bni_attendance/helpers/utils.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../helpers/constants.dart';

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  List<CameraDescription>? cameras;
  CameraController? cameraController;
  bool isLoading = true;
  @override
  void initState() {
    startCamera();
    super.initState();
  }

  @override
  void dispose() {
    if(cameraController != null){
      cameraController!.dispose();
    }
    super.dispose();
  }
  @override
    Widget build(BuildContext context) {
    return isLoading == true || cameraController!.value.isInitialized == false ?
    Center(child: CircularProgressIndicator(),) :
    SafeArea(
      child: Scaffold(
        body: Container(
          width: Constants.width,
          padding: EdgeInsets.symmetric(horizontal: Constants.width! * 0.04, vertical: Constants.height! * 0.02),
          color: Color(0xffCF2130),
          child: Column(
            children: [
              SizedBox(height: Constants.height! * 0.02,),
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
              SizedBox(height: Constants.height! * 0.08,),
              Container(
                width: Constants.width! * 0.8,
                height: Constants.height! * 0.6,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3)
                ),
                child: CameraPreview(cameraController!),
              ),
              SizedBox(height: Constants.height! * 0.06,),
              GestureDetector(
                onTap: onCameraButtonClicked,
                child: Container(
                  width: Constants.width! * 0.15,
                  height: Constants.height! * 0.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    border: Border.all(color: Colors.white, width: 3)
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void startCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameras![1],
      ResolutionPreset.high,
      enableAudio: false,
    );

    cameraController!.initialize().then((value){
      if(!mounted){
        return;
      }
      setState((){
        isLoading = false;
      });
    });
  }

  void onCameraButtonClicked() async {
    cameraController!.takePicture().then((XFile? file){
      if(mounted == true){
        if(file != null){
          Utils.showSnackBar(context, 'Your attendance has been marked. Thank you!');
          Navigator.pop(context, true);
        }else{
          Utils.showSnackBar(context, 'The operation failed. Please try again!');
        }
      }
    });
  }
}
