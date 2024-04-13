import 'package:flutter/material.dart';
import 'package:photo_fetch/enums/enums.dart';
import 'package:photo_fetch/models/models.dart';
import 'package:photo_fetch/resources/resources.dart';
import 'package:photo_fetch/services/services.dart';
import 'package:photo_fetch/widgets/widgets.dart';

class EditPhotoDetail extends StatefulWidget {
  final Photo photo;
  final ValueSetter<Photo> updatePhoto;
  final VoidCallback cancleEditing;

  const EditPhotoDetail({
    super.key,
    required this.photo,
    required this.updatePhoto,
    required this.cancleEditing,
  });

  @override
  State<EditPhotoDetail> createState() => _EditPhotoDetailState();
}

class _EditPhotoDetailState extends State<EditPhotoDetail> {
  final imageUrlController = TextEditingController();

  final imageTitleController = TextEditingController();
  bool isChanged = false;
  late Photo photo;

  @override
  void initState() {
    imageTitleController.text = widget.photo.title;
    imageUrlController.text = widget.photo.url;
    photo = widget.photo;
    super.initState();
  }

  void onChanged() {
    setState(() {
      isChanged = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: PaddingSizes.xl),
      child: Column(
        children: [
          TextField(
            onChanged: (_) => onChanged(),
            decoration: AppStyles.textFieldDecoration.copyWith(
              label: const Text('Title'),
              hintText: 'Enter photo title',
            ),
            controller: imageTitleController,
          ),
          const SizedBox(height: PaddingSizes.sm),
          TextField(
              onChanged: (_) => onChanged(),
              controller: imageUrlController,
              decoration: AppStyles.textFieldDecoration.copyWith(
                  label: const Text('Url'), hintText: 'Enter photo url')),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              EditingButton(
                  callback: widget.cancleEditing,
                  buttonType: EditButtonType.cancel),
              EditingButton(
                  callback: isChanged
                      ? () async {
                          photo.title = imageTitleController.text;
                          photo.url = imageUrlController.text;
                          final updatedPhoto = await FetchPhoto.updatePhoto(
                            photo,
                          );
                          widget.updatePhoto(updatedPhoto);
                          widget.cancleEditing();
                        }
                      : null,
                  buttonType: EditButtonType.save),
            ],
          )
        ],
      ),
    );
  }
}
