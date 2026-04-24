import 'package:camera/camera.dart';
import 'package:flutter_liveness_detection_randomized_plugin/src/models/liveness_detection_label_model.dart';
import 'package:flutter_liveness_detection_randomized_plugin/src/models/liveness_ui_labels.dart';

class LivenessDetectionConfig {
  final int? durationLivenessVerify;
  final bool showDurationUiText;
  final bool useCustomizedLabel;
  final LivenessDetectionLabelModel? customizedLabel;
  final bool isEnableMaxBrightness;
  final int imageQuality;
  final ResolutionPreset cameraResolution;
  final bool isEnableSnackBar;
  final bool shuffleListWithSmileLast;
  final bool showCurrentStep;
  final bool isDarkMode;
  final LivenessUiLabels uiLabels;

  LivenessDetectionConfig._({
    required this.durationLivenessVerify,
    required this.showDurationUiText,
    required this.useCustomizedLabel,
    required this.customizedLabel,
    required this.isEnableMaxBrightness,
    required this.imageQuality,
    required this.cameraResolution,
    required this.isEnableSnackBar,
    required this.shuffleListWithSmileLast,
    required this.showCurrentStep,
    required this.isDarkMode,
    required this.uiLabels,
  });

  factory LivenessDetectionConfig({
    int? durationLivenessVerify = 45,
    bool showDurationUiText = false,
    bool useCustomizedLabel = false,
    LivenessDetectionLabelModel customizedLabel =
        const LivenessDetectionLabelModel(),
    bool isEnableMaxBrightness = true,
    int imageQuality = 100,
    ResolutionPreset cameraResolution = ResolutionPreset.high,
    bool isEnableSnackBar = true,
    bool shuffleListWithSmileLast = true,
    bool showCurrentStep = false,
    bool isDarkMode = true,
    LivenessUiLabels uiLabels = const LivenessUiLabels(),
    int? stepCount,
  }) {
    if (stepCount != null) {
      final json = customizedLabel.toJson();
      var emptyKeys = List.generate(json.length, (i) => json.keys.elementAt(i))
        ..shuffle();
      final removeCount = json.length - stepCount > 0
          ? json.length - stepCount
          : 0;
      emptyKeys = emptyKeys.sublist(0, removeCount)
        ..forEach((e) => json[e] = '');
      customizedLabel = LivenessDetectionLabelModel.fromJson(json);
    }

    return LivenessDetectionConfig._(
      durationLivenessVerify: durationLivenessVerify,
      showDurationUiText: showDurationUiText,
      useCustomizedLabel: useCustomizedLabel,
      customizedLabel: customizedLabel,
      isEnableMaxBrightness: isEnableMaxBrightness,
      imageQuality: imageQuality,
      cameraResolution: cameraResolution,
      isEnableSnackBar: isEnableSnackBar,
      shuffleListWithSmileLast: shuffleListWithSmileLast,
      showCurrentStep: showCurrentStep,
      isDarkMode: isDarkMode,
      uiLabels: uiLabels,
    );
  }
}
