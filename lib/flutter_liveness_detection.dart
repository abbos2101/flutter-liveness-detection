import 'package:flutter/material.dart';

import 'src/core/services/liveness_cooldown_service.dart';
import 'src/models/liveness_detection_config.dart';
import 'src/models/liveness_detection_threshold.dart';
import 'src/presentation/views/liveness_detection_view.dart';
import 'src/presentation/widgets/liveness_cooldown_widget.dart';

export 'package:camera/camera.dart';

export 'src/models/liveness_detection_config.dart';
export 'src/models/liveness_detection_label_model.dart';

class FlutterLivenessDetection {
  FlutterLivenessDetection._();

  static final instance = FlutterLivenessDetection._();

  List<LivenessDetectionThreshold> _thresholds = _defaultThresholds();

  static List<LivenessDetectionThreshold> _defaultThresholds() => [
    LivenessThresholdBlink(leftEyeProbability: 0.25, rightEyeProbability: 0.25),
    LivenessThresholdHead(rotationAngle: 30.0),
    LivenessThresholdSmile(probability: 0.65),
  ];

  List<LivenessDetectionThreshold> get thresholdConfig => _thresholds;

  void configureThresholds(List<LivenessDetectionThreshold> thresholds) {
    _thresholds = thresholds.isEmpty ? _defaultThresholds() : thresholds;
  }

  void resetThresholds() => _thresholds = _defaultThresholds();

  Future<String?> livenessDetection({
    required BuildContext context,
    required LivenessDetectionConfig config,
  }) async {
    if (config.enableCooldownOnFailure) {
      LivenessCooldownService.instance.configure(
        maxFailedAttempts: config.maxFailedAttempts,
        cooldownMinutes: config.cooldownMinutes,
      );
      final cooldownState = await LivenessCooldownService.instance
          .getCooldownState();
      if (cooldownState.isInCooldown && context.mounted) {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LivenessCooldownWidget(
              cooldownState: cooldownState,
              isDarkMode: config.isDarkMode,
              maxFailedAttempts: config.maxFailedAttempts,
            ),
          ),
        );
        return null;
      }
    }

    if (!context.mounted) return null;

    final String? capturedFacePath = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LivenessDetectionView(config: config),
      ),
    );

    if (config.enableCooldownOnFailure) {
      if (capturedFacePath != null) {
        await LivenessCooldownService.instance.recordSuccessfulAttempt();
      } else {
        await LivenessCooldownService.instance.recordFailedAttempt();
      }
    }

    return capturedFacePath;
  }
}
