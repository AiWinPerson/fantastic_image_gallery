class ExplanationInfo{
  final String explanation;
  late final DateTime writtenDate;

  ExplanationInfo({required this.explanation,}){
    writtenDate = DateTime.now();
  }

}