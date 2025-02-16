import 'package:flutter/material.dart';
import 'package:myapp/states/AppState.dart';
import 'package:provider/provider.dart';

class HistoryListView extends StatefulWidget {
  const HistoryListView({Key? key}) : super(key: key);

  @override
  State<HistoryListView> createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView> {
  final _key = GlobalKey();
  static const Gradient _maskingGradient = LinearGradient(
    colors: [Colors.transparent, Colors.black],
    stops: [0, 0.5],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    appState.historyListKey = _key;
    return ShaderMask(
        shaderCallback: (bounds) => _maskingGradient.createShader(bounds),
        blendMode: BlendMode.dstIn,
        child: AnimatedList(
          key: _key,
          reverse: true,
          padding: const EdgeInsets.only(top: 100),
          initialItemCount: appState.history.length,
          itemBuilder: (context, index, animation) {
            final pair = appState.history[index];
            return SizeTransition(
                sizeFactor: animation,
                child: Center(
                  child: TextButton.icon(
                      icon: appState.favorites.contains(pair)
                          ? Icon(Icons.favorite)
                          : SizedBox(),
                      onPressed: () {
                        appState.toggleFavorite(pair);
                      },
                      label: Text(
                        pair.asLowerCase,
                        semanticsLabel: pair.asPascalCase,
                      )),
                ));
          },
        ));
  }
}
