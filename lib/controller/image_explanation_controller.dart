import 'package:get/get.dart';

import '../model/explanation_info.dart';

class ImageExplanationController extends GetxController{
  final RxString _currentExplanation = "".obs;
  final RxList<ExplanationInfo> _records = <ExplanationInfo>[].obs;

  RxString get currentExplanation => _currentExplanation;
  RxList<ExplanationInfo> get records => _records;

  set explanationSetter(String value) => _currentExplanation.value = value;

  void addExplanation(){
    _records.add(ExplanationInfo(explanation: _currentExplanation.value));
    _records.refresh();
  }

  void removeRecord(DateTime date){
    _records.removeWhere((e) => e.writtenDate.isAtSameMomentAs(date));
    _records.refresh();
  }

}