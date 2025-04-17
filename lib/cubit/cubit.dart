import 'source.dart';

class MyCubit extends CubitPattern {
  @override
  void onListen() {
    emit('Cubit is listened');
  }

  Future<void> doSomething() async {
    await Future.delayed(Duration(seconds: 2));
    emit('waiting 2 seconds');
    await Future.delayed(Duration(seconds: 2));
    emit('then waiting 3 seconds');
    await Future.delayed(Duration(seconds: 3));
    emit('Done!');
  }
}
