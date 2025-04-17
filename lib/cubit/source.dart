import 'dart:async';

class CubitPattern {
  CubitPattern() {
    _controller.onListen = onListen;
  }

  dynamic state;

  final StreamController _controller = StreamController.broadcast();
  Stream<dynamic> get stream {
    return _controller.stream;
  }

  void onListen() {}

  void emit(dynamic newState) {
    state = newState;
    _controller.add(state);
  }
}
