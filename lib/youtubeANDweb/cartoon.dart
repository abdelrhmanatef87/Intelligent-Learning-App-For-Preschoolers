import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intelligent_learning/youtubeANDweb/video_list.dart';
import 'package:intelligent_learning/youtubeANDweb/videomodel.dart';


class CartoonVideo extends StatefulWidget {
  @override
  _CartoonVideoState createState() => _CartoonVideoState();
}

class _CartoonVideoState extends State<CartoonVideo> {
  @override
  void initState() {
    super.initState();
    // fetchVideoIds('PLM1j2JqVBQfneP1sowXOz_G3y9DHnnnv8');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cartoon videos'),
      ),
      body: ListView.builder(
        itemCount: VideosList.videoCard.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VideoList(
                            controllers: VideosList.videoCard[index].videosIDs,
                          )),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.asset(
                      VideosList.videoCard[index].imagePath,
                      fit: BoxFit.fill,
                      height: 180,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      VideosList.videoCard[index].cartoonName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void fetchVideoIds(String playlistIDs) async {
    List<String> videoIds = [];

    String apiKey = 'AIzaSyBoSXAR4AcGYpPkDPUKSKA0yyqRk-7O0EA';
    String? nextPageToken; // Make nextPageToken nullable
    bool hasMorePages = true;

    while (hasMorePages) {
      String url =
          'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=$playlistIDs&fields=items(snippet(resourceId(videoId)))&key=$apiKey';

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final items = jsonData['items'];
        for (final item in items) {
          final videoId = item['snippet']['resourceId']['videoId'];
          videoIds.add(videoId);
        }

        nextPageToken = jsonData['nextPageToken'];
        hasMorePages = nextPageToken != null &&
            nextPageToken
                .isNotEmpty; // Add a check for non-null and non-empty nextPageToken
      } else {
        throw Exception('Failed to fetch videoIds from the API');
      }
    }
    print(videoIds.length);
    print(videoIds);
  }
}


