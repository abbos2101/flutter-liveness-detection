class LivenessDetectionLabelModel {
  final String? smile;
  final String? lookUp;
  final String? lookDown;
  final String? lookLeft;
  final String? lookRight;
  final String? blink;

  const LivenessDetectionLabelModel({
    this.smile,
    this.lookUp,
    this.lookDown,
    this.lookLeft,
    this.lookRight,
    this.blink,
  });

  factory LivenessDetectionLabelModel.fromJson(Map<String, dynamic> json) =>
      LivenessDetectionLabelModel(
        smile: json['smile'],
        lookUp: json['lookUp'],
        lookDown: json['lookDown'],
        lookLeft: json['lookLeft'],
        lookRight: json['lookRight'],
        blink: json['blink'],
      );

  Map<String, dynamic> toJson() => {
    'smile': smile,
    'lookUp': lookUp,
    'lookDown': lookDown,
    'lookLeft': lookLeft,
    'lookRight': lookRight,
    'blink': blink,
  };
}
