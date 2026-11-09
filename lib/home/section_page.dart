import 'package:flutter/material.dart';

import '../core/l10n.dart';
import '../core/registry.dart';
import '../core/tool.dart';
import 'tool_widgets.dart';

/// Bitta bo'limning asboblari.
class SectionPage extends StatelessWidget {
  const SectionPage({super.key, required this.category});
  final ToolCategory category;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final tools = allTools.where((t) => t.category == category).toList();
    return Scaffold(
      appBar: AppBar(title: Text(category.label(l))),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          ToolGrid(tools: tools),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
