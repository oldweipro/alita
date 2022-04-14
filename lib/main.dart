import 'package:alita/provider/alita_provider.dart';
import 'package:alita/provider/theme_provider.dart';
import 'package:alita/util/AlitaRouteDelegate.dart';
import 'package:alita/util/alita_defend.dart';
import 'package:alita/db/alita_cache.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  AlitaDefend().run(const AlitaApp());
}

class AlitaApp extends StatefulWidget {
  const AlitaApp({Key? key}) : super(key: key);

  @override
  State<AlitaApp> createState() => _AlitaAppState();
}

class _AlitaAppState extends State<AlitaApp> {
  final AlitaRouteDelegate _routeDelegate = AlitaRouteDelegate();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AlitaCache>(
        //进行初始化，预初始化缓存单例
        future: AlitaCache.preInit(),
        builder: (BuildContext context, AsyncSnapshot<AlitaCache> snapshot) {
          //定义route
          var widget = snapshot.connectionState == ConnectionState.done
              ? Router(routerDelegate: _routeDelegate)
              : const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
          return MultiProvider(
              providers: topProviders,
              child: Consumer<ThemeProvider>(builder: (BuildContext context,
                  ThemeProvider themeProvider, Widget? child) {
                return MaterialApp(
                  home: widget,
                  theme: themeProvider.getTheme(),
                  darkTheme: themeProvider.getTheme(isDarkMode: true),
                  themeMode: themeProvider.getThemeMode(),
                  title: "Alita",
                );
              }));
        });
  }
}
