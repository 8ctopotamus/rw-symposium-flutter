import 'package:meta/meta.dart';

class Question {
  final String question;
  final List<String> upvotes;
  
  Question({
    @required this.question,
    this.upvotes,
  });

  Map<String, dynamic> toJson() =>
  {
    'question': question,
  };
}
