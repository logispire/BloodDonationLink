import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blood_donation_link/FunctionIconButton.dart';
import 'package:blood_donation_link/MyTextFormField.dart';
import 'package:blood_donation_link/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_cropper_for_web/image_cropper_for_web.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(const MyApp());
  });
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "JCI Blood Donation",
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Blood Donation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ImagePicker picker = ImagePicker();
  File? pickedImage;
  File? companyLog0;
  Uint8List? file1;
  Uint8List? companyList;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    // precacheImage(AssetImage("images/Placeholder.png"), context);
  }

  //todo remove this
  TextEditingController textEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  uploadImage() async {
    // WEB
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker
        .pickImage(
      source: ImageSource.gallery,
    )
        .then((value) {
      if (value != null) {
        cropImageVertical(value);
      }
    });
  }

  uploadCompanyImage() async {
    // WEB
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      cropImageHorizontal(image);
    }
  }

  cropImageHorizontal(XFile pickedImage) async {
    CroppedFile? croppedFile = await ImageCropper()
        .cropImage(sourcePath: pickedImage.path, aspectRatioPresets: [
      CropAspectRatioPreset.square,
    ], uiSettings: [
      WebUiSettings(
        context: context,
        presentStyle: CropperPresentStyle.page,
        boundary: Boundary(
          width: 450,
          height: 450,
        ),
        viewPort: ViewPort(width: 389, height: 151, type: 'square'),
        enableExif: true,
        enableZoom: true,
        showZoomer: true,
      ),
    ]).then((value) async {
      if (value != null) {
        var f = await value.readAsBytes();
        setState(() {
          companyList = f;
        });
      }
    });
  }

  cropImageVertical(XFile pickedImage) async {
    CroppedFile? croppedFile = await ImageCropper()
        .cropImage(sourcePath: pickedImage.path, aspectRatioPresets: [
      CropAspectRatioPreset.square,
    ], uiSettings: [
      WebUiSettings(
        context: context,
        presentStyle: CropperPresentStyle.page,
        boundary: Boundary(
          width: MediaQuery.of(context).size.width.toInt(),
          height: 400,
        ),
        viewPort: ViewPort(width: 300, height: 300, type: 'rectangle'),
        enableExif: true,
        enableZoom: true,
        showZoomer: true,
      ),
    ]).then((value) async {
      if (value != null) {
        var f = await value.readAsBytes();
        setState(() {
          file1 = f;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:Colors.white,
      body: Center(
        child: SizedBox(
          height: size.height,
          width: 500,
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Screenshot(
                    controller: screenshotController,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 150,
                          left: 326,
                          height: 147,
                          width: 147,
                          child: file1 == null
                              ? Container(
                                  width: 100,
                                  height: 100,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        "images/avatar.png",
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: MemoryImage(file1!))),
                                ),
                        ),
                        Opacity(
                          opacity: 1.0,
                          child: Image.asset(
                            "images/Placeholder.png",
                            width: 500,
                            height: 500,
                          ),
                        ),
                        Positioned(
                          width: 210,
                          height: 20,
                          top: 308,
                          left: 285,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                // border: Border.all(width: 2,color: Colors.white)
                                ),
                            child: AutoSizeText(
                              textEditingController.text.trim(),
                              minFontSize: 10,
                              style: const TextStyle(
                                  fontSize: 19.5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                  child: MyTextFormField(
                    label: "Your Name",
                    controller: textEditingController,
                    hintText: "Enter your Name Here",
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.name,
                    maxLines: 1,
                    maxLength: 20,
                    onChanged: (value) {
                      setState(() {});
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter a name";
                      }
                      return null;
                    },
                  ),
                ),
                FunctionIconButton(
                  onPressed: () async {
                    await uploadImage();
                  },
                  icon: CupertinoIcons.person_alt,
                  label: "Upload User's Image",
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 200),
                  child: FunctionIconButton(
                      onPressed: () async {
                        if (file1 == null) {
                          Fluttertoast.showToast(
                              msg: "Please Upload Profile Image",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          return;
                        }
                        if (formKey.currentState!.validate()) {
                          await screenshotController.capture().then((value) {
                            if (value == null) {
                              Fluttertoast.showToast(
                                  msg: "Failed to generate Image",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                            final base64data = base64Encode(value!.toList());
                            final a = AnchorElement(
                                href: 'data:image/jpeg;base64,$base64data');
                            a.download = 'download.jpg';
                            a.click();
                            a.remove();
                          });
                        }
                      },
                      label: "Download Image",
                      icon: CupertinoIcons.cloud_download_fill,),
                ),
                Center(
                  child:
                  Column(
                    children: [
                      Text("Developed By:",style: TextStyle(
                        fontSize: 10,color: Colors.grey.withOpacity(0.7)
                      ),),

                      Image.asset("images/logo.webp",height: 30,),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text("Logispire IT Solution",style: TextStyle(
                          color: Color(0xff00285b)
                        ),),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}
