import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

final FirebaseStorage storage = FirebaseStorage.instance;

Future<XFile?> getImage() async {
  final ImagePicker _picker = ImagePicker();
  XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  return image;
}

Future<UploadTask> upload(String path) async {
  File file = File(path);
  try {
    String ref = 'images/img-${DateTime.now().toString()}.jpeg';
    final storageRef = FirebaseStorage.instance.ref();
    return storageRef.child(ref).putFile(
          file,
          SettableMetadata(
            cacheControl: "public, max-age=300",
            contentType: "image/jpeg",
            customMetadata: {
              "user": "123",
            },
          ),
        );
  } on FirebaseException catch (e) {
    throw Exception('Erro no upload: ${e.code}');
  }
}
