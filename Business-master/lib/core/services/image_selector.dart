import 'package:image_picker/image_picker.dart';

class ImageSelector {
  ImageSelector._();

  static final instance = ImageSelector._();

  Future<XFile?>? pickImage({required ImageSource source}) async {
    final ImagePicker _picker = ImagePicker();
    final pickedFIle = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFIle == null) return null;
    return pickedFIle;
  }
}
