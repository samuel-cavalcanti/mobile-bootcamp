import 'package:flutter/material.dart';
import 'package:gallery_placeholder_app/models/picture.dart';
import 'package:gallery_placeholder_app/services/json_placeholder_service.dart';

class PicturesScreen extends StatefulWidget {
  final int albumId;

  const PicturesScreen({Key key, this.albumId}) : super(key: key);

  @override
  _PicturesScreenState createState() => _PicturesScreenState(albumId);
}

class _PicturesScreenState extends State<PicturesScreen> {
  final int albumId;
  final service = JsonPlaceholderService();

  _PicturesScreenState(this.albumId);

  Widget _buildPictures(List<Picture> pictures) {
    debugPrint('size of pictures: ${pictures.length}');
    return ListView.builder(
      itemCount: pictures.length,
      itemBuilder: (context, index) => Card(
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(pictures[index].thumbnailUrl),
            Text(
              pictures[index].title,
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pictures'),
      ),
      body: FutureBuilder(
        future: service.getPictures(albumId),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return _buildPictures(snapshot.data);
          else if (snapshot.hasError)
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: TextStyle(fontSize: 20),
              ),
            );

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
