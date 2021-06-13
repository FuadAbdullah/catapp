import 'dart:async';
import 'package:catapp/model/core/catphoto.dart';
import 'package:flutter/cupertino.dart';
import 'package:catapp/model/helper/catphotohelper.dart';
import 'package:catapp/model/glitch/glitch.dart';
import 'package:dartz/dartz.dart';

class CatProvider extends ChangeNotifier {
  final _helper = CatPhotoHelper();
  final _streamController = StreamController<Either<Glitch, CatPhoto>>();
  String _title = 'Cute Kittens';
  Stream<Either<Glitch, CatPhoto>> get catPhotoStream {
    return _streamController.stream;
  }

  Future<void> getTwentyRandomPhoto() async {
    for (int i = 0; i < 20; i++) {
      final catHelperResult = await _helper.getRandomCatPhoto();
      _streamController.add(catHelperResult);
    }
  }

  void refreshGrid() {
    getTwentyRandomPhoto();
  }

  void setAppTitle(title) {
    this._title = title;
  }

  String appTitle() {
    return _title;
  }
}

