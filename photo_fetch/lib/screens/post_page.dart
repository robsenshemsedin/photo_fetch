import 'package:flutter/material.dart';
import 'package:photo_fetch/models/models.dart';
import 'package:photo_fetch/resources/resources.dart';
import 'package:photo_fetch/services/services.dart';
import 'package:photo_fetch/widgets/widgets.dart';

class PostPage extends StatefulWidget {
  const PostPage({
    super.key,
  });

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          AppStrings.appName,
          style: AppStyles.appTitleStyle,
        ),
      ),
      body: FutureBuilder<List<Photo>>(
        future: FetchPhoto.getPhotos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: 5,
                itemBuilder: ((context, index) {
                  return PhotoCard(
                    photo: snapshot.data!.reversed.toList()[index],
                  );
                }));
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('An Error Occured!'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showBottomSheet,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        // This is used for the rounded corners
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(BorderRadiusSizes.lg),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom, // Adjusts with the keyboard
          ),
          child: SizedBox(
            height: 280, // Set the height of the bottom sheet
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: PaddingSizes.lg, vertical: PaddingSizes.xxs),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.addPost,
                        style: AppStyles.appTitleStyle.copyWith(fontSize: 22),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close))
                    ],
                  ),
                ),
                AddPhoto(addPhoto: addPhoto)
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> addPhoto(Photo photo) async {
    FetchPhoto.addPhoto(photo);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(AppStrings.snackBarMessage),
      backgroundColor: Colors.green,
    ));
    Navigator.pop(context);
  }
}
