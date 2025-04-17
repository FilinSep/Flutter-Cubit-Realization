# Flutter Stupid Cubit Pattern Realization

To make this bullshit work, I used **StreamBuilder**, what i don't advise you to do, because **StreamBuilder** already has tools for working with states, use **snapshot.connectionState** or use something like **notifier** or better use **BlocBuilder** with **flutter_bloc**.

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
## Another example (with states)
Cubit:
```
import 'package:dio/dio.dart';
import 'source.dart';

enum States { initial, loading, loaded }

class CubitState {
  final States state;
  final dynamic data;

  CubitState({required this.state, this.data});
}

class MyCubit extends CubitPattern {
  @override
  Future<void> onListen() async {
    /// Since StreamBuilder loses some snapshots, use should write all logic in this overrided method

    // Return to StreamBuilder an initial state
    emit(CubitState(state: States.initial));

    // You should use DI, repositories and models. Anyway this is an example
    Dio dio = Dio();

    // Set loading state
    emit(CubitState(state: States.loading));
    // Let wait some seconds to see loading, because we will get answer from API instantly
    await Future.delayed(Duration(seconds: 2));
    // Getting answer
    var answer = await dio.get('https://jsonplaceholder.typicode.com/todos/1');
    // Set loaded state with data
    emit(CubitState(state: States.loaded, data: answer.data));
  }
}

```

Page:
```
// DO NOT USE CUBIT PATTERN WITH STREAM BUILDER
// IT ALREADY HAS A CONNECTION STATE
// This is just an example to show how it works
StreamBuilder(
  stream: MyCubit().stream,
  builder: (context, snapshot) {
    if (!snapshot.hasData) {
      return Text('Hello, StreamBuilder lost my snapshot again!');
    }

    if (snapshot.data.state == States.loading) {
      // On loading state
      return CircularProgressIndicator();
    } else if (snapshot.data.state == States.loaded) {
      // When our todo api loaded
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'TO DO:',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          Text(
            snapshot.data.data['title'],
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      );
    }
    // When initial state
    return Text('Initial state');
  },
)
```
