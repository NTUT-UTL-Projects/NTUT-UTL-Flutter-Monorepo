part of '../stream_util.dart';

Stream<T> mergeStreams<T>(List<Stream<T>> streams) {
  StreamController<T> controller = StreamController<T>();
  List<StreamSubscription<T>> subscriptions = [];

  void handleData(T data) {
    if (!controller.isClosed) {
      controller.add(data);
    }
  }

  void handleError(Object error, StackTrace stackTrace) {
    if (!controller.isClosed) {
      controller.addError(error, stackTrace);
    }
  }

  void handleDone() {
    for (var s in subscriptions) {
      s.cancel();
    }
    controller.close();
  }

  void subscribeToStream(Stream<T> stream) {
    final s = stream.listen(
      handleData,
      onError: handleError,
      onDone: handleDone,
    );
    subscriptions.add(s);
  }

  streams.forEach(subscribeToStream);

  controller.onCancel = () async {
    await Future.wait(subscriptions.map((s) => s.cancel()));
  };

  return controller.stream;
}
