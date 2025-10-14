part of 'seat_cushion_features_line.dart';

typedef TriggerDownloadFile =
    Future<void> Function(AppLocalizations appLocalizations);

typedef TriggerClear = Future<void> Function(AppLocalizations appLocalizations);

class SeatCushionFeaturesLineController extends ChangeNotifier {
  final List<StreamSubscription> _sub = [];

  final _downloadFileLock = Lock();
  bool _isDownloadingFile = false;
  bool get isDownloadingFile => _isDownloadingFile;
  @protected
  late final TriggerDownloadFile triggerDownloadFile;

  late bool _isClearing;
  bool get isClearing => _isClearing;
  @protected
  final TriggerClear triggerClear;

  late bool _isRecording;
  bool get isRecording => _isRecording;
  @protected
  final VoidCallback triggerRecord;

  SeatCushionFeaturesLineController({
    required TriggerDownloadFile downloadFile,
    required bool isClearing,
    required Stream<bool> isClearingStream,
    required bool isRecording,
    required Stream<bool> isRecordingStream,
    required this.triggerClear,
    required this.triggerRecord,
  }) {
    _isClearing = isClearing;
    triggerDownloadFile = (context) => _downloadFileLock.synchronized(() async {
      _isDownloadingFile = true;
      notifyListeners();
      await downloadFile(context);
      _isDownloadingFile = false;
      notifyListeners();
    });
    _isRecording = isRecording;
    _sub.addAll([
      isClearingStream.listen((b) {
        isClearing = b;
        notifyListeners();
      }),
      isRecordingStream.listen((b) {
        _isRecording = b;
        notifyListeners();
      }),
    ]);
  }

  @override
  void dispose() {
    for (final s in _sub) {
      s.cancel();
    }
    super.dispose();
  }
}
