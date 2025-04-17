import 'package:customcubit/cubit/cubit.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(CubitApp());
}

class CubitApp extends StatelessWidget {
  const CubitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData.dark(), home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MyCubit cubit = MyCubit();

  @override
  void initState() {
    super.initState();
    cubit.doSomething();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cubit Pattern Realization'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(height: 1.0, width: 300, color: Colors.white60),
        ),
      ),
      body: Center(
        // StreamBuilder is a bad and very evil widget >:(
        child: StreamBuilder(
          stream: cubit.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            return Text(snapshot.data);
          },
        ),
      ),
    );
  }
}
