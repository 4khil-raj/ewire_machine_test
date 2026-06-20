import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/cart/cart_counter_bloc.dart';
import '../controller/theme/theme_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool showCartIcon;
  final VoidCallback? onCartPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.showCartIcon = true,
    this.onCartPressed,
  });
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: showBackButton
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            )
          : null,
      actions: [
        BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            final isDark =
                state.themeMode == ThemeMode.dark ||
                (state.themeMode == ThemeMode.system &&
                    MediaQuery.platformBrightnessOf(context) ==
                        Brightness.dark);
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                child: IconButton(
                  icon: Icon(
                    isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                    size: 20,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onPressed: () {
                    BlocProvider.of<ThemeBloc>(context).add(ToggleThemeEvent());
                  },
                ),
              ),
            );
          },
        ),
        if (showCartIcon)
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: BlocBuilder<CartCounterBloc, CartCounterState>(
              builder: (context, state) {
                final count = state is CartCounterLoadedState
                    ? state.totalCount
                    : 0;
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.shopping_bag_outlined,
                          size: 20,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        onPressed:
                            onCartPressed ??
                            () {
                              if (ModalRoute.of(context)?.settings.name !=
                                  '/cart') {
                                Navigator.pushNamed(context, '/cart');
                              }
                            },
                      ),
                    ),
                    if (count > 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            '$count',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
      ],
    );
  }
}
