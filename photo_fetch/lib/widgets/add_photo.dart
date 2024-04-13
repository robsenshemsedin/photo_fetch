import 'package:flutter/material.dart';
import 'package:photo_fetch/enums/enums.dart';
import 'package:photo_fetch/models/photo_model.dart';
import 'package:photo_fetch/resources/resources.dart';
import 'package:photo_fetch/widgets/widgets.dart';

class AddPhoto extends StatefulWidget {
  final ValueSetter<Photo> addPhoto;

  const AddPhoto({
    super.key,
    required this.addPhoto,
  });

  @override
  State<AddPhoto> createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  final imageUrlController = TextEditingController();

  final imageTitleController = TextEditingController();
  bool isChanged = false;
  late Photo photo;

  @override
  void initState() {
    photo = Photo(
      title: imageTitleController.text,
      url: imageUrlController.text,
    );
    super.initState();
  }

  void onChanged() {
    setState(() {
      isChanged = true;
    });
  }

  @override
  void dispose() {
    imageTitleController.clear();
    imageUrlController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: PaddingSizes.sm, horizontal: PaddingSizes.xs),
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
          Align(
            alignment: Alignment.centerRight,
            child: EditingButton(
                callback: isChanged
                    ? () {
                        photo.title = imageTitleController.text;
                        photo.url = imageUrlController.text;
                        widget.addPhoto(photo);
                      }
                    : null,
                buttonType: EditButtonType.save),
          ),
        ],
      ),
    );
  }
}
