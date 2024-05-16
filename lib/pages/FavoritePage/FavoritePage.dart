import 'package:flutter/material.dart';
import 'package:myapp/states/AppState.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    final theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!
        .copyWith(color: theme.colorScheme.onPrimaryContainer);

    if (appState.favorites.isEmpty) {
      return Center(child: Text("No favorites yet", style: style));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Text(
              'You have '
              '${appState.favorites.length} favorites:',
              style: style),
        ),
        Expanded(
            child: GridView(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400, childAspectRatio: 400 / 80),
                children: [
              ...appState.favorites.map((t) => Material(
                  color: Colors.transparent,
                  child: ListTile(
                    leading: IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        semanticLabel: "Delete",
                      ),
                      color: theme.colorScheme.primary,
                      onPressed: () {
                        appState.removeFavorite(t);
                      },
                    ),
                    title: Text(
                      t.asLowerCase,
                      semanticsLabel: t.asPascalCase,
                    ),
                  ))),
            ]))
      ],
    );
  }
}
