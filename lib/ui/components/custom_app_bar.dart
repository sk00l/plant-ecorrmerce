// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actionsWidget;
  final Widget? leadingWidget;
  final Widget? titleWidget;
  final bool centerTitle;
  final double? titleSpacing;
  final GestureTapCallback? onTapBack;
  final bool? automaticallyImplyLeading;
  const CustomAppBar({
    Key? key,
    this.title,
    this.actionsWidget,
    this.leadingWidget,
    this.titleWidget,
    this.centerTitle = false,
    this.titleSpacing,
    this.onTapBack,
    this.automaticallyImplyLeading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      automaticallyImplyLeading: automaticallyImplyLeading ?? false,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      title: titleWidget ??
          Text(
            title ?? "",
          ),
      leading: leadingWidget,
      actions: actionsWidget,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
