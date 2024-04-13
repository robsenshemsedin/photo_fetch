import 'package:flutter/material.dart';
import 'package:photo_fetch/enums/enums.dart';
import 'package:photo_fetch/models/models.dart';
import 'package:photo_fetch/resources/resources.dart';
import 'package:photo_fetch/services/services.dart';
import 'package:photo_fetch/widgets/widgets.dart';

class PhotoCard extends StatefulWidget {
  final Photo photo;

  const PhotoCard({super.key, required this.photo});

  @override
  State<PhotoCard> createState() => _PhotoCardState();
}

class _PhotoCardState extends State<PhotoCard> {
  bool isEditing = false;
  late Photo photo;
  @override
  void initState() {
    photo = widget.photo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(PaddingSizes.xs),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
            top: Radius.circular(BorderRadiusSizes.sm)),
        child: Container(
          color: Theme.of(context).colorScheme.surfaceVariant,
          child: Column(
            children: [
              SizedBox(
                  height: 280,
                  width: double.infinity,
                  child: Image.network(
                    photo.url,
                    fit: BoxFit.fill,
                  )),
              !isEditing
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PhotoTitle(title: photo.title),
                        PopupMenuButton<int>(
                          onSelected: (item) => onSelected(context, item),
                          itemBuilder: (context) => [
                            PopupMenuItem<int>(
                              value: 0,
                              child: Row(
                                children: [
                                  const Icon(Icons.edit),
                                  const SizedBox(width: 8),
                                  Text(EditButtonType.edit.name.toUpperCase()),
                                ],
                              ),
                            ),
                            PopupMenuItem<int>(
                              value: 1,
                              child: Row(
                                children: [
                                  const Icon(Icons.delete),
                                  const SizedBox(width: 8),
                                  Text(
                                      EditButtonType.delete.name.toUpperCase()),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  : EditPhotoDetail(
                      cancleEditing: setIsEditing,
                      updatePhoto: updatePhoto,
                      photo: photo,
                    )
            ],
          ),
        ),
      ),
    );
  }

  setIsEditing() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  updatePhoto(Photo updatedPhoto) {
    setState(() {
      photo = updatedPhoto;
    });
  }

  Future<void> deletePhoto() async {
    updatePhoto(await FetchPhoto.deletePhoto(photo));
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        setIsEditing();
        break;
      case 1:
        deletePhoto();
        break;
    }
  }
}
