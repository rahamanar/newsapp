import 'package:flutter/material.dart';
import 'package:newsapp_ar/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _notifier = ValueNotifier<ThemeModel>(ThemeModel(ThemeMode.light));

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeModel>(
      valueListenable: _notifier,
      builder: (_, model, __) {
        final mode = model.mode;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(), // Provide light theme.
          darkTheme: ThemeData.dark(), // Provide dark theme.
          themeMode: mode, // Decides which theme to show.
          home: Scaffold(
              appBar: AppBar(
                title: Text('NewsApp'),
                actions: [
                  GestureDetector(
                      onTap: () {
                        _notifier.value = ThemeModel(mode == ThemeMode.light
                            ? ThemeMode.dark
                            : ThemeMode.light);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(Icons.lightbulb),
                      ))
                ],
              ),
              body: Home()),
        );
      },
    );
  }
}

class ThemeModel with ChangeNotifier {
  final ThemeMode _mode;
  ThemeMode get mode => _mode;

  ThemeModel(this._mode);
}
