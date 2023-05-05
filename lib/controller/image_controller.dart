import 'dart:io';
import 'package:canteen_ordering_user/widgets/loading_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;

class ImageController{
  String url = '';
  Future<String> uploadImageToFirebase(String foldName , String fileName , File image,context) async {
    loadingDialogue(context: context);
    fStorage.Reference reference = fStorage.FirebaseStorage.instance
        .ref()
        .child(foldName)
        .child(fileName);
    fStorage.UploadTask uploadTask =
    reference.putFile(File(image.path));
    fStorage.TaskSnapshot taskSnapshot =
    await uploadTask.whenComplete(() {});
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

 }