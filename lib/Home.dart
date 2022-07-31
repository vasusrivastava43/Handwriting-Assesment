import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String result = "";
  File? image;
  ImagePicker? imagePicker;
  late double imgWidth;
  late double imgHeight;

  //String path="";

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  pickImageFromGallery() async {
    XFile? xFile = await imagePicker!.pickImage(source: ImageSource.gallery);
    File rotatedImage =
        await FlutterExifRotation.rotateImage(path: xFile!.path);
    setState(() {
      image = rotatedImage;
      // path=xFile.path;
    });
    //calculateSize(image!);
  }

  pickImageFromCamera() async {
    XFile? xFile = await imagePicker!.pickImage(source: ImageSource.camera);
    File rotatedImage =
        await FlutterExifRotation.rotateImage(path: xFile!.path);
    setState(() {
      image = rotatedImage;
      // path=xFile.path;
    });
    // calculateSize(image!);
  }

  // calculateSize(File image)async {
  //   var decodedImage = await decodeImageFromList(image.readAsBytesSync());
  //   setState(() {
  //     imgWidth = double.parse(decodedImage.width.toString());
  //     imgHeight = double.parse(decodedImage.height.toString());
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var physicalScreenSize = window.physicalSize;
    var physicalWidth = physicalScreenSize.width;
    var physicalHeight = physicalScreenSize.height;

    return Scaffold(
      backgroundColor: Colors.lightBlue[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                    width: physicalWidth * .28,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: InkWell(
                                  onTap: () {
                                    pickImageFromGallery();
                                  },
                                  child: Image.asset("assets/gallery.png")),
                            ),
                            // Container(
                            //   height: 100,
                            //   width: 100,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(50),
                            //     color: Colors.grey
                            //   ),
                            //   child: IconButton(
                            //     onPressed: (){
                            //       pickImageFromGallery();
                            //     },
                            //     icon: const Icon(Icons.image,size: 50,),
                            //     color: Colors.white,
                            //     alignment: Alignment.center,
                            //   ),
                            // ),
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: InkWell(
                                  onTap: () {
                                    pickImageFromCamera();
                                  },
                                  child: Image.asset("assets/diaphragm.png")),
                              //child: Image.asset("assets/diaphragm.png"),
                            )
                            // Container(
                            //   height: 100,
                            //   width: 100,
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(100),
                            //       color: Colors.grey
                            //   ),
                            //   child: FlatButton(
                            //     onPressed: (){
                            //       pickImageFromCamera();
                            //     },
                            //     child: Image.asset("assets/diaphragm.png",alignment: Alignment.center,fit: BoxFit.cover),
                            //     color: Colors.white,
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              "Import",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "Scan",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                    ])),
              ),
              // const SizedBox(height: 10,),
              // Container(
              //   height: 20,
              //   width: physicalWidth,
              //   decoration: const BoxDecoration(
              //     color: Colors.grey,
              //   ),
              // ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10, bottom: 20),
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    child: image != null
                        ?
                        // Stack(
                        //   children: [
                        //     Center(child: CircularProgressIndicator(),),
                        //     Center(child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image:'$path' ,))
                        // ],)
                        Container(
                            child: Image.file(
                              image!,
                              /*width: imgWidth,height: imgHeight,*/ fit:
                                  BoxFit.cover,
                            ),
                          )
                        : Center(
                            child: SizedBox(
                            height: physicalHeight * .25,
                            width: physicalWidth * .75,
                            child: Center(
                                child: Image.asset("assets/qr-code.png")),
                          )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
