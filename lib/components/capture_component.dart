import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CaptureComponent extends StatefulWidget {
  @override
  _CaptureComponentState createState() => _CaptureComponentState();
}

class _CaptureComponentState extends State<CaptureComponent> {
  File imageFile;

  _openCamera() async {
    var userImage = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = userImage;
    });
  }

  // Future<void> _dialogue(BuildContext context) {
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       title: Text('Camera Access'),
  //       content: SingleChildScrollView(
  //         child: ListBody(
  //           children: [
  //             GestureDetector(
  //               child: Text('Please allow access to Camera'),
  //               onTap: () => _openCamera(),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Somaiya',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                      color: Colors.teal[800],
                    )),
                Text('Tracker',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                      color: Colors.teal[900],
                    ))
              ]),
        ),
        imageFile == null
            ? Padding(
                padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
                child:
                    Text('💡 Capture an image near you to know your location',
                        style: TextStyle(
                          fontSize: 16.0,
                        )),
              )
            : SizedBox(),
        Container(
          height: 400.0,
          padding: EdgeInsets.only(left: 5.0, right: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: imageFile == null
              ? Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Click '),
                        Icon(Icons.camera),
                        Text(' to capture an image'),
                      ]),
                )
              : Hero(
                  tag: 'captured image',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.file(
                      imageFile,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
        ),
        Center(
            child: Padding(
          child: Text(imageFile == null ? '' : 'Image identified as KJSCE - A',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              )),
          padding: EdgeInsets.only(top: 20.0),
        )),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            imageFile == null
                ? SizedBox()
                : RaisedButton(
                    onPressed: () => null,
                    child: Row(
                      children: [
                        Text(
                          'Navigate Further',
                        )
                      ],
                    ),
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(3.0)),
                  ),
            imageFile == null
                ? SizedBox()
                : RaisedButton(
                    onPressed: () => null,
                    child: Row(
                      children: [
                        Text(
                          'Info about Place',
                        )
                      ],
                    ),
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(3.0)),
                  ),
            RaisedButton(
              onPressed: () => _openCamera(),
              child: Icon(
                Icons.camera,
                color: Colors.white,
                size: 50.0,
              ),
              color: Colors.grey[600],
              shape: CircleBorder(),
            ),
          ]),
        )
      ],
    );
  }
}
