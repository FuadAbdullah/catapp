import 'dart:math';
import 'package:catapp/model/glitch/nointernetglitch.dart';
import 'package:flutter/material.dart';
import 'package:catapp/provider/catprovider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:catapp/getit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

class CatGrid extends StatefulWidget {
  const CatGrid({Key? key}) : super(key: key);

  @override
  _CatGridState createState() => _CatGridState();
}

class _CatGridState extends State<CatGrid> with AfterLayoutMixin {
  final provider = getIt<CatProvider>();
  List catPhotos = [], catPhotoTiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[50],
        appBar: AppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  catPhotoTiles.clear();
                  catPhotos.clear();
                  provider.refreshGrid();
                  provider.setAppTitle('Random Cat Images ${Random().nextInt(100)}');
                },
              )
            ],
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(provider.appTitle(), style: GoogleFonts.pacifico())),
        body: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: catPhotos.length == 0
                ? Center(child: CircularProgressIndicator())
                : StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: catPhotos.length,
                    itemBuilder: (context, index) {
                      return catPhotos[index];
                    },
                    staggeredTileBuilder: (index) => catPhotoTiles[index],
                  )));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    provider.getTwentyRandomPhoto();

    provider.catPhotoStream.listen((snapshot) {
      snapshot.fold((l) {
        if (l is NoInternetGlitch) {
          Color randomColor = Color.fromRGBO(Random().nextInt(255),
              Random().nextInt(255), Random().nextInt(255), 1);
          catPhotos.add(CatPhotoErrorTile(randomColor, "Unable to Connect"));
        }
      }, (r) {
        catPhotos.add(CatPhotoTile(r.url));
      });
      int count = Random().nextInt(4);
      catPhotoTiles.add(StaggeredTile.count(count, count.toDouble()));

      setState(() {});
    });
  }
}

class CatPhotoTile extends StatelessWidget {
  const CatPhotoTile(this.imageUrl);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Center(
            child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(const Radius.circular(10.0)),
                        image: DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover))))));
  }
}

class CatPhotoErrorTile extends StatelessWidget {
  const CatPhotoErrorTile(this.backgroundColor, this.errorMessage);

  final Color backgroundColor;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: backgroundColor,
        child: InkWell(
            onTap: () {},
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(errorMessage)))));
  }
}
