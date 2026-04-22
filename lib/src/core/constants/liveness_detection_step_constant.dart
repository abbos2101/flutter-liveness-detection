import 'package:flutter_liveness_detection/src/models/liveness_detection_step_item.dart';

var stepLiveness = <LivenessDetectionStepItem>[
  LivenessDetectionStepItem(step: .blink, title: 'Blink 2-3 Times'),
  LivenessDetectionStepItem(step: .lookUp, title: 'Look UP'),
  LivenessDetectionStepItem(step: .lookDown, title: 'Look DOWN'),
  LivenessDetectionStepItem(step: .lookRight, title: 'Look RIGHT'),
  LivenessDetectionStepItem(step: .lookLeft, title: 'Look LEFT'),
  LivenessDetectionStepItem(step: .smile, title: 'Smile'),
];
