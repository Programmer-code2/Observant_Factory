import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../core/utils.dart';

class ImageService {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> capturePhoto() async {
    try {
      final XFile? img = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 80,
      );
      if (img == null) return null;
      final dir = await getApplicationDocumentsDirectory();
      final imgDir = Directory(p.join(dir.path, 'images'));
      if (!await imgDir.exists()) await imgDir.create(recursive: true);
      final ext = p.extension(img.path).isNotEmpty ? p.extension(img.path) : '.jpg';
      final target = p.join(imgDir.path, '${DateTime.now().millisecondsSinceEpoch}$ext');
      await File(img.path).copy(target);
      log('IMG', 'Saved photo to $target');
      return File(target);
    } catch (e) {
      log('IMG', 'Failed to capture photo: $e');
      return null;
    }
  }

  static Future<void> deleteImage(String path) async {
    try {
      final f = File(path);
      if (await f.exists()) await f.delete();
    } catch (e) {
      log('IMG', 'Failed to delete $path: $e');
    }
  }
}
