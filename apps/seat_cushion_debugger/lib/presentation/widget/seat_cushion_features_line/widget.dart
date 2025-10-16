part of 'seat_cushion_features_line.dart';

class SeatCushionFeaturesLine extends StatelessWidget {
  const SeatCushionFeaturesLine({super.key});
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final themeExtension = themeData.extension<SeatCushionFeaturesLineTheme>();
    final appLocalizations = AppLocalizations.of(context)!;

    final isClearing = context.select<SeatCushionFeaturesLineController, bool>(
      (c) => c.isClearing,
    );
    final triggerClear = context
        .select<SeatCushionFeaturesLineController, TriggerClear>(
          (c) => c.triggerClear,
        );
    final clearButton = IconButton(
      onPressed: (isClearing) ? null : () => triggerClear(appLocalizations),
      icon: Icon(themeExtension?.clearIcon),
      color: themeExtension?.clearColor,
    );

    final isDownloadingFile = context
        .select<SeatCushionFeaturesLineController, bool>(
          (c) => c.isDownloadingFile,
        );
    final triggerDownloadFile = context
        .select<SeatCushionFeaturesLineController, TriggerDownloadFile>(
          (c) => c.triggerDownloadFile,
        );
    final downloadButton = IconButton(
      onPressed: (isDownloadingFile)
          ? null
          : () => triggerDownloadFile(appLocalizations),
      icon: Icon(themeExtension?.downloadIcon),
      color: themeExtension?.downloadColor,
    );

    final isRecording = context.select<SeatCushionFeaturesLineController, bool>(
      (c) => c.isRecording,
    );
    final triggerRecord = context
        .select<SeatCushionFeaturesLineController, VoidCallback>(
          (c) => c.triggerRecord,
        );
    final recordButton = IconButton(
      onPressed: triggerRecord,
      icon: Icon(themeExtension?.recordIcon),
      color: (isRecording) ? themeExtension?.recordColor : null,
    );

    return Row(children: [clearButton, Spacer(), recordButton, downloadButton]);
  }
}
