
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mc_jsi/core/constants.dart';
import 'package:mc_jsi/core/functions.dart';
import 'package:mc_jsi/core/inh.dart';
import 'package:mc_jsi/ui/widgets.dart/bottom_menu.dart';
import 'package:mc_jsi/ui/widgets.dart/drawer.dart';
import 'package:mc_jsi/ui/widgets.dart/profile_appbar.dart';
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  File avatarfile;
  bool progress = false;
   void progressChanged(bool value) => setState(() { 
    progress = value;
  }
 );
  imageSelectorGallery(File filename) async {
      Navigator.pop(context);
      filename = await ImagePicker.pickImage(
        source: ImageSource.gallery,
      );
      
      
      if(filename != null){
      print("You selected gallery image : " + filename.path);
      setState(() {
        progressChanged(true);
        avatarfile = filename;
        Future.delayed(const Duration(seconds: 2), () {
          print('upload fonk çalıştı');
           _upload();
        });
       
      });
      }
      else{
        setState(() {
          progressChanged(false);
        });
      }
      
    }




    

    imageSelectorCamera(File filename) async {
      Navigator.pop(context);
      filename = await ImagePicker.pickImage(
        source: ImageSource.camera,
      );
      
      
      if(filename != null){
        print("You selected camera image : " + filename.path);
        setState(() {
        progressChanged(true);
        avatarfile = filename;
        Future.delayed(const Duration(seconds: 2), () {
          print('upload fonk çalıştı');
           _upload();
        });
       
      });
      }
      else{
        setState(() {
          progressChanged(false);
        });
      }
    }
   void _upload() {

        if (avatarfile == null) {
          print('resim dosyasını alamadık');
          return;
          }
        String base64Image ;
        FlutterImageCompress.compressAndGetFile(
                  avatarfile.absolute.path, avatarfile.path,
                  quality: 88, minWidth: 400).then((data) {
            img.Image photo = img.decodeImage(avatarfile.readAsBytesSync());
            base64Image = base64Encode(img.encodeJpg(photo));
            http.post(Constants.generalBaseUrl+'/api/user.php', body: {
              "process":"add_avatar",
              "userId" : Cookie.of(context).user_id,
              "avatar": base64Image,
        }).then((http.Response response) {
          print('***body: '+response.body+'**********************');
           setState(() {
               progressChanged(false);
             });
           var parsedd = json.decode(response.body);
           for (var item in parsedd) {
             print(item['status']);
            
           }

           
           
        }).catchError((err) {
          print(err.toString());
        });
          });
        
      }
  @override
  void initState() {
    super.initState();
   
  }
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomMenu(context,_scaffoldKey),
      backgroundColor: Colors.white,
      key:_scaffoldKey,
      endDrawer: drawer(context),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              actions: <Widget>[
                new Container(),
              ],
              leading: Container(),
              brightness: Brightness.dark,
              expandedHeight: screenH(0.3, context),
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.all(0),
                  background: appBarProfile(context, true,
                  Constants.generalBaseUrl + Cookie.of(context).userAvatarUrl)
                  ),
            ),
            
          ];
        },
        
      body: 
    
       SingleChildScrollView(
                child: Stack(
                  children: [
                    Center(
                          child:Column(
                            children: <Widget>[
                            
                            Text(Cookie.of(context).userNameLastname.toUpperCase()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                              Icon(Icons.file_upload,color: Colors.yellow[700],),
                              FlatButton(
                                child: Text('Profilbild hochladen',style: TextStyle(color: Colors.yellow[700],),),
                                onPressed: (){
                                   Alert(context: context, 
                                        title: "PROFIL FOTO", 
                                        desc: "Bitte wählen Sie eine Quelle",
                                        buttons: [
                                          DialogButton(
                                            onPressed: (){
                                              imageSelectorGallery(avatarfile);
                                              },
                                              color: Colors.blue,
                                            child: Icon(Icons.perm_media),
                                          ),
                                          DialogButton(
                                            
                                            onPressed: () {imageSelectorCamera(avatarfile);},
                                            child: Icon(Icons.camera_alt),
                                          ),
                                        ],
                                        ).show();
                                },
                              )
                            ],),
                            GestureDetector(onTap: (){
                                Navigator.pushNamed(context, Constants.ROUTE_EDIT_PROFILE);
                              },
                              child: card(context,'Informationen bearbeiten')),
                            GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, Constants.ROUTE_PASSWORD);
                              },
                              child: card(context, 'Passwort ändern')),
                           
                               GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, Constants.ROUTE_ADDRESS);
                              },
                             child: card(context, 'Meine Adresse'),),
                           
                          ],
                        ),
                      
                    ),
               progress==false?Container():  Container(
                   width: screenW(1, context),
                   height: screenH(1, context),
                   child: Center(child: CircularProgressIndicator(),),
                 )      
                  ]
                ))
            
         
    )
    );
  }
}
Widget card (context,String content){
  return
  Container(
                        width: double.infinity,
                        height: screenH(0.08, context),
                        margin: EdgeInsets.only(
                          left: screenW(0.05, context),
                          right: screenW(0.05, context),
                          top: screenW(0.05, context),
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                          10
                          ),
                          boxShadow: [
                              BoxShadow(
                                color: Colors.grey[300],
                                blurRadius: 10.0, 

                                offset: Offset(
                                  1.0, // horizontal, move right 10
                                  1.0, // vertical, move down 10
                                ),
                              ),
                            ],
                        ),
                        child: Text(content));
}


class Foods {
  final title;
  final asset;
  Foods({this.title,this.asset});
}