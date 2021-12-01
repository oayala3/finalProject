import 'dart:convert';
import "dart:io";
import 'dart:typed_data';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import "package:scoped_model/scoped_model.dart";
import "package:flutter_slidable/flutter_slidable.dart";
import "package:intl/intl.dart";
import "package:path/path.dart";
import '../avatar.dart';
import "../utils.dart" as utils;
import "postals_db_worker.dart";
import "postals_model.dart" show Postal, PostalsModel, postalsModel;
import 'package:gallery_view/gallery_view.dart';
import 'package:share/share.dart';

class PostalsList extends StatelessWidget {
  Widget build(BuildContext inContext) {
    return ScopedModel<PostalsModel>(
        model: postalsModel,
        child: ScopedModelDescendant<PostalsModel>(builder:
            (BuildContext inContext, Widget inChild, PostalsModel inModel) {
          return Scaffold(
              floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.add, color: Colors.white),
                  onPressed: () async {
                    File image = File(join(Avatar.docsDir.path, "image"));
                    if (image.existsSync()) {
                      image.deleteSync();
                    }
                    postalsModel.entityBeingEdited = Postal();
                    postalsModel.setChosenDate(null);
                    postalsModel.setStackIndex(1);
                  }),
              body: Container(
                  color: Colors.black,
              child:GridView.builder(
                  itemCount: postalsModel.entityList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 0 ),
                  itemBuilder: (BuildContext inContext, index) {
                    Postal postal = postalsModel.entityList[index];
                    return Column(children: [
                      Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: .25,
                        child: GestureDetector(
                          onTap: ()  async {
                            File avatarFile = File(join(Avatar.docsDir.path, "image"));
                            if (avatarFile.existsSync()) {
                              avatarFile.deleteSync();
                            }
                            postalsModel.entityBeingEdited = await PostalsDBWorker.db.get(postal.id);
                            if (postalsModel.entityBeingEdited.time == null) {
                              postalsModel.setChosenDate(null);
                            } else {
                              List dateParts = postalsModel.entityBeingEdited.time.split(",");
                              DateTime time = DateTime(
                                  int.parse(dateParts[0]), int.parse(dateParts[1]), int.parse(dateParts[2])
                              );
                              postalsModel.setChosenDate(DateFormat.yMMMMd("en_US").format(time.toLocal()));
                            }
                            postalsModel.setStackIndex(1);
                          }, // handle your image tap here
                          child: Image.file(
                            File(join(
                                Avatar.docsDir.path, postal.id.toString())),
                            fit: BoxFit.cover,
                            // this is the solution for border
                            width: 110.0,
                            height: 110.0,
                          ),
                        ),
                          secondaryActions : [
                            IconSlideAction(
                                caption : "Delete",
                                color : Colors.red,
                                icon : Icons.delete,
                                onTap : () => _deleteContact(inContext, postal)
                            ),
                            IconSlideAction(
                                caption : "Share",
                                color : Colors.blueAccent,
                                icon : Icons.share,
                                onTap : () => _sharePostal(postal)
                            )
                          ]
                      )
                    ]);
                  })));
        }));
  }

  ///Re use of the delete code
  Future _deleteContact(BuildContext inContext, Postal inContact) async {
    return showDialog(
        context: inContext,
        barrierDismissible: false,
        builder: (BuildContext inAlertContext) {
          return AlertDialog(
              title: Text("Delete Postal"),
              content: Text(
                  "Are you sure you want to delete ${inContact.location}?"),
              actions: [
                FlatButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      // Just hide dialog.
                      Navigator.of(inAlertContext).pop();
                    }),
                FlatButton(
                    child: Text("Delete"),
                    onPressed: () async {
                      File avatarFile = File(
                          join(Avatar.docsDir.path, inContact.id.toString()));
                      if (avatarFile.existsSync()) {
                        avatarFile.deleteSync();
                      }
                      await PostalsDBWorker.db.delete(inContact.id);
                      Navigator.of(inAlertContext).pop();
                      Scaffold.of(inContext).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                          content: Text("Postal deleted")));
                      postalsModel.loadData("contacts", PostalsDBWorker.db);
                    })
              ]);
        });
  }
  Future _sharePostal(Postal inContact) async {
    File  avatarFile= File(join(Avatar.docsDir.path, inContact.id.toString()));
    Uint8List imagebyte = avatarFile.readAsBytesSync();
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/image1.jpg';
    File(path).writeAsBytesSync(imagebyte.buffer.asUint8List());
    await Share.shareFiles([path], text: 'Postal Description: ${inContact.description}, Postal Location: ${inContact.location}, Postal date: ${inContact.time}');
  }

  Future<Image> convertFileToImage(File picture) async {
    List<int> imageBase64 = picture.readAsBytesSync();
    String imageAsString = base64Encode(imageBase64);
    Uint8List uint8list = base64.decode(imageAsString);
    Image image = Image.memory(uint8list);
    return image;
  }
}
