import 'dart:async';

class SyncNotifier {
  final _controller = StreamController<String>.broadcast();

  Stream<String> get stream => _controller.stream;

  void notifyTableChanged(String table) {
    print("1HOLAAAAAAAAAAAAAAAAAAAAAAA");
    _controller.add(table);
  }

  void dispose() {
    _controller.close();
  }
}