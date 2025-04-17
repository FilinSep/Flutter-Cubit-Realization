# Flutter Stupid Cubit Pattern Realization

To make this bullshit work, I used **StreamBuilder**, what i don't advise you to do. Better use something like **notifier** or **BlocBuilder** with **flutter_bloc**

## Example:
```dart
class MyCubit extends CubitPattern {
  @override
  // Add state to stream at start of listening
  void onListen() {
    emit('Cubit is listened');
  }

  // Event, to set states use emit, like in flutter_bloc
  Future<void> doSomething() async {
    await Future.delayed(Duration(seconds: 2));
    emit('waiting 2 seconds');
    await Future.delayed(Duration(seconds: 2));
    emit('then waiting 3 seconds');
    await Future.delayed(Duration(seconds: 3));
    emit('Done!');
  }
}
```
