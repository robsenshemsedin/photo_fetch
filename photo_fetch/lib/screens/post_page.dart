import 'package:flutter/material.dart';
import 'package:photo_fetch/models/photo_model.dart';
import 'package:photo_fetch/resources/app_styles.dart';
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
                itemCount: snapshot.data!.length,
                itemBuilder: ((context, index) {
                  return PhotoCard(
                    photo: snapshot.data![index],
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
                AddPhoto(addPhoto: (Photo photo) {
                  debugPrint(photo.title);
                  debugPrint(photo.url);
                  Navigator.pop(context);
                })
              ],
            ),
          ),
        );
      },
    );
  }
}
