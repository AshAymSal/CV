class TypingModel {
  bool? typing;

  TypingModel({this.typing});

  Map<String, dynamic> toMap() {
    return {
      'typing': this.typing,
    };
  }

  factory TypingModel.fromMap(Map<String, dynamic> map) {
    return TypingModel(
      typing: map['typing'] as bool,
    );
  }
}
