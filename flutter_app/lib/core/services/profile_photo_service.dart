import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfilePhotoService {
  final ImagePicker picker;

  ProfilePhotoService(this.picker);

  Future<String?> pickAndSavePhoto(String userId) async {
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
      maxWidth: 800,
    );

    if (image == null) return null;

    final directory = await getApplicationDocumentsDirectory();
    final photoDirectory = Directory('${directory.path}/profile_photos');

    await photoDirectory.create(recursive: true);

    final file = File('${photoDirectory.path}/$userId.jpg');
    await File(image.path).copy(file.path);

    return file.path;
  }
}
