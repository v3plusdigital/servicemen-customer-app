import 'dart:io';

import 'package:flutter/material.dart';

import '../utils/image_picker_helper.dart';

void showImagePickerBottomSheet(
    BuildContext context, Function(File file) onImageSelected) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Take Photo"),
              onTap: () async {
                Navigator.pop(context);
                final file = await ImagePickerHelper.pickFromCamera();
                if (file != null) onImageSelected(file);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Choose from Gallery"),
              onTap: () async {
                Navigator.pop(context);
                final file = await ImagePickerHelper.pickFromGallery();
                if (file != null) onImageSelected(file);
              },
            ),
          ],
        ),
      );
    },
  );
}
