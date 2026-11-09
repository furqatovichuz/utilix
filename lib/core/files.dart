import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Foydalanuvchi tanlagan rasm: nom va baytlar.
class PickedImage {
  PickedImage(this.name, this.bytes);
  final String name;
  final Uint8List bytes;
}

/// Tizim fayl tanlagichi orqali rasm(lar) tanlash. Hech qanday ruxsat so'ramaydi.
Future<List<PickedImage>> pickImages({bool multiple = false}) async {
  final List<PlatformFile> files;
  if (multiple) {
    files = await FilePicker.pickFiles(type: FileType.image);
  } else {
    final one = await FilePicker.pickFile(type: FileType.image);
    files = one == null ? [] : [one];
  }
  return [
    for (final f in files) PickedImage(f.name, await f.readAsBytes()),
  ];
}

/// Tizim fayl tanlagichi orqali PDF fayl(lar) tanlash.
Future<List<PickedImage>> pickPdfs({bool multiple = true}) async {
  final List<PlatformFile> files;
  if (multiple) {
    files = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf'],
    );
  } else {
    final one = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: const ['pdf'],
    );
    files = one == null ? [] : [one];
  }
  return [
    for (final f in files) PickedImage(f.name, await f.readAsBytes()),
  ];
}

/// Bir nechta baytlar to'plamini fayl sifatida ulashadi.
Future<void> shareMany(
  Map<String, Uint8List> named,
  String mime,
) async {
  final dir = await getTemporaryDirectory();
  final files = <XFile>[];
  for (final e in named.entries) {
    final f = File('${dir.path}/${e.key}');
    await f.writeAsBytes(e.value, flush: true);
    files.add(XFile(f.path, mimeType: mime));
  }
  await SharePlus.instance.share(ShareParams(files: files));
}

/// Baytlarni vaqtinchalik faylga yozib, ulashish oynasini ochadi
/// (u yerdan "Saqlash", Drive, Telegram va hokazoga yuborish mumkin).
Future<void> shareBytes(
  BuildContext context,
  Uint8List bytes,
  String fileName,
  String mime,
) async {
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  await SharePlus.instance.share(
    ShareParams(files: [XFile(file.path, mimeType: mime)], subject: fileName),
  );
}

String humanSize(int bytes) {
  if (bytes < 1024) return '$bytes B';
  if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
  return '${(bytes / 1024 / 1024).toStringAsFixed(2)} MB';
}

void showMessage(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(text), behavior: SnackBarBehavior.floating));
}
