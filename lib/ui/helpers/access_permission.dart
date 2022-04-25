import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:product_ecommer/bloc/product/product_bloc.dart';

import '../../bloc/user/user_bloc.dart';

class AccessPermission {
  final ImagePicker _picker = ImagePicker();

  Future<void> permissionAccessGalleryOrCameraForProfile(
      PermissionStatus status, BuildContext context, ImageSource source) async {
    switch (status) {
      case PermissionStatus.granted:
        final XFile? imagePath = await _picker.pickImage(source: source);
        if (imagePath != null) {
          BlocProvider.of<UserBloc>(context)
              .add(OnUpdateProfilePictureEvent(imagePath.path));
        }
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
        break;
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
    }
  }

  Future<void> permissionAccessGalleryOrCameraForProduct(
      PermissionStatus status, BuildContext context, ImageSource source) async {
    switch (status) {
      case PermissionStatus.granted:
        final XFile? imagePath = await _picker.pickImage(source: source);
        if (imagePath != null) {
          BlocProvider.of<ProductBloc>(context)
              .add(OnSelectPathImageProductEvent(imagePath.path));
        }
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
        break;
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
    }
  }
}
