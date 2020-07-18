import 'package:flutter/material.dart';
import 'package:todoeyflutter/model/stage.dart';

mixin ModelState on ChangeNotifier {
  Stage _stage;

  Stage get stage {
    return _stage;
  }

  updateStage({Stage stage}) {
    _stage = stage;
  }

  updateStageAndNotify({Stage stage}) {
    updateStage(stage: stage);
    notifyListeners();
  }
}