import 'package:flutter/material.dart';
import 'package:test_youtube/models/video_model.dart';
import 'package:test_youtube/screens/video_screen.dart';
import 'package:test_youtube/services/api_service.dart';

class SearchScreen extends StatefulWidget {
  final String searchString;
  SearchScreen(this.searchString);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Video>? videos;

  @override
  void initState() {
    super.initState();
    _initVideos();
  }

  _initVideos() async {
    List<Video> tmp_videos =
        await APIService.instance.fetchVideosFromSearching(widget.searchString);
    setState(() {
      videos = tmp_videos;
    });
  }

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreen(video.id),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        height: 140.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Image(
              width: 150.0,
              image: NetworkImage(video.thumbnailUrl),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                video.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.searchString}'),
      ),
      body: videos != null
          ? NotificationListener<ScrollNotification>(
              child: ListView.builder(
                itemCount: videos?.length,
                itemBuilder: (BuildContext context, int index) {
                  Video video = videos![index];
                  return _buildVideo(video);
                },
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor, // Red
                ),
              ),
            ),
    );
  }
}
