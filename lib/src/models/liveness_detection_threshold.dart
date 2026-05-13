import 'package:equatable/equatable.dart';
import 'dart:convert';

abstract class LivenessDetectionThreshold extends Equatable {
  const LivenessDetectionThreshold();
  LivenessDetectionThreshold fromDict(Map<String, dynamic> map);
  Map<String, dynamic> toMap();
  @override
  List<Object> get props => [];
}

class LivenessThresholdSmile extends LivenessDetectionThreshold {
  final double probability;

  LivenessThresholdSmile({this.probability = 0.75}) : super() {
    assert(
      probability < 1.0 || probability > 0.0,
      'Smile Probability has to be between 1.0 and 0.0',
    );
  }

  LivenessThresholdSmile copyWith({double? probability}) {
    return LivenessThresholdSmile(probability: probability ?? this.probability);
  }

  @override
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{}..addAll({'probability': probability});

    return result;
  }

  @override
  factory LivenessThresholdSmile.fromMap(Map<String, dynamic> map) {
    return LivenessThresholdSmile(
      probability: map['probability']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LivenessThresholdSmile.fromJson(String source) =>
      LivenessThresholdSmile.fromMap(json.decode(source));

  @override
  String toString() => 'LivenessThresholdSmile(probability: $probability)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LivenessThresholdSmile && other.probability == probability;
  }

  @override
  int get hashCode => probability.hashCode;

  @override
  LivenessThresholdSmile fromDict(Map<String, dynamic> map) {
    return LivenessThresholdSmile(
      probability: map['probability']?.toDouble() ?? 0.0,
    );
  }
}

class LivenessThresholdBlink extends LivenessDetectionThreshold {
  final double leftEyeProbability;
  final double rightEyeProbability;

  LivenessThresholdBlink({
    this.leftEyeProbability = 0.25,
    this.rightEyeProbability = 0.25,
  }) : super() {
    assert(
      leftEyeProbability < 1.0 || leftEyeProbability > 0.0,
      'Left Probability has to be between 1.0 and 0.0',
    );
    assert(
      rightEyeProbability < 1.0 || rightEyeProbability > 0.0,
      'Right Probability has to be between 1.0 and 0.0',
    );
  }

  LivenessThresholdBlink copyWith({
    double? leftEyeProbability,
    double? rightEyeProbability,
  }) {
    return LivenessThresholdBlink(
      leftEyeProbability: leftEyeProbability ?? this.leftEyeProbability,
      rightEyeProbability: rightEyeProbability ?? this.rightEyeProbability,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{}
      ..addAll({'leftEyeProbability': leftEyeProbability})
      ..addAll({'rightEyeProbability': rightEyeProbability});

    return result;
  }

  factory LivenessThresholdBlink.fromMap(Map<String, dynamic> map) {
    return LivenessThresholdBlink(
      leftEyeProbability: map['leftEyeProbability']?.toDouble() ?? 0.0,
      rightEyeProbability: map['rightEyeProbability']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LivenessThresholdBlink.fromJson(String source) =>
      LivenessThresholdBlink.fromMap(json.decode(source));

  @override
  String toString() =>
      'LivenessThresholdBlink(leftEyeProbability: $leftEyeProbability, rightEyeProbability: $rightEyeProbability)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LivenessThresholdBlink &&
        other.leftEyeProbability == leftEyeProbability &&
        other.rightEyeProbability == rightEyeProbability;
  }

  @override
  int get hashCode =>
      leftEyeProbability.hashCode ^ rightEyeProbability.hashCode;

  @override
  LivenessDetectionThreshold fromDict(Map<String, dynamic> map) {
    return LivenessThresholdBlink(
      leftEyeProbability: map['leftEyeProbability']?.toDouble() ?? 0.0,
      rightEyeProbability: map['rightEyeProbability']?.toDouble() ?? 0.0,
    );
  }
}

class LivenessThresholdHead extends LivenessDetectionThreshold {
  /// Yaw angle threshold — used for Look Left / Look Right steps.
  final double rotationAngle;

  /// Pitch angle threshold — used for Look Up / Look Down steps.
  /// Default is intentionally smaller than [rotationAngle] because the neck
  /// tilts up/down with less range than it rotates left/right.
  final double pitchAngle;

  LivenessThresholdHead({
    this.rotationAngle = 30.0,
    this.pitchAngle = 12.0,
  }) : super() {
    assert(
      rotationAngle > 0.0 && rotationAngle < 180.0,
      'rotationAngle must be between 0 and 180 degrees',
    );
    assert(
      pitchAngle > 0.0 && pitchAngle < 180.0,
      'pitchAngle must be between 0 and 180 degrees',
    );
  }

  LivenessThresholdHead copyWith({double? rotationAngle, double? pitchAngle}) {
    return LivenessThresholdHead(
      rotationAngle: rotationAngle ?? this.rotationAngle,
      pitchAngle: pitchAngle ?? this.pitchAngle,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{}
      ..addAll({'rotationAngle': rotationAngle})
      ..addAll({'pitchAngle': pitchAngle});

    return result;
  }

  factory LivenessThresholdHead.fromMap(Map<String, dynamic> map) {
    return LivenessThresholdHead(
      rotationAngle: map['rotationAngle']?.toDouble() ?? 30.0,
      pitchAngle: map['pitchAngle']?.toDouble() ?? 12.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LivenessThresholdHead.fromJson(String source) =>
      LivenessThresholdHead.fromMap(json.decode(source));

  @override
  String toString() =>
      'LivenessThresholdHead(rotationAngle: $rotationAngle, pitchAngle: $pitchAngle)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LivenessThresholdHead &&
        other.rotationAngle == rotationAngle &&
        other.pitchAngle == pitchAngle;
  }

  @override
  int get hashCode => rotationAngle.hashCode ^ pitchAngle.hashCode;

  @override
  LivenessDetectionThreshold fromDict(Map<String, dynamic> map) {
    return LivenessThresholdHead(
      rotationAngle: map['rotationAngle']?.toDouble() ?? 30.0,
      pitchAngle: map['pitchAngle']?.toDouble() ?? 12.0,
    );
  }
}
