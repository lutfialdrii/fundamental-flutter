import 'package:flutter/material.dart';
import 'package:simple_http_request/datasource.dart';

import 'model/album.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  late Future<Album> _futureAlbum;
  @override
  void initState() {
    super.initState();
    _futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SimpleApp get data from Internet'),
      ),
      body: Center(
        child: FutureBuilder(
          future: _futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return CircularProgressIndicator();
            } else {
              if (snapshot.hasData) {
                return Text(snapshot.data!.title!);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return Text('');
              }
            }
          },
        ),
      ),
    );
  }
}
