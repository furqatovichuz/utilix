import 'package:flutter/material.dart';

import '../core/l10n.dart';
import '../core/store.dart';
import '../core/tool.dart';

void openTool(BuildContext context, Tool tool) {
  StoreScope.of(context).markUsed(tool.id);
  Navigator.of(context).push(MaterialPageRoute(builder: tool.builder));
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Text(text,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700)),
        ),
      );
}

class ToolGrid extends StatelessWidget {
  const ToolGrid({super.key, required this.tools});
  final List<Tool> tools;

  @override
  Widget build(BuildContext context) => SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 220,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            mainAxisExtent: 156,
          ),
          itemCount: tools.length,
          itemBuilder: (_, i) => ToolCard(tool: tools[i]),
        ),
      );
}

class ToolCard extends StatelessWidget {
  const ToolCard({super.key, required this.tool});
  final Tool tool;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final store = StoreScope.of(context);
    final fav = store.isFavorite(tool.id);
    final scheme = Theme.of(context).colorScheme;
    return Card(
      color: tool.color.withValues(alpha: .12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => openTool(context, tool),
        onLongPress: () => store.toggleFavorite(tool.id),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: tool.color,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(tool.icon, color: Colors.white, size: 24),
                  ),
                  InkResponse(
                    onTap: () => store.toggleFavorite(tool.id),
                    child: Icon(
                      fav ? Icons.star_rounded : Icons.star_outline_rounded,
                      color: fav ? Colors.amber : scheme.outline,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(tool.name(l),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, height: 1.15)),
              const SizedBox(height: 2),
              Text(tool.description(l),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant)),
            ],
          ),
        ),
      ),
    );
  }
}

class MiniTool extends StatelessWidget {
  const MiniTool({super.key, required this.tool});
  final Tool tool;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 88,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => openTool(context, tool),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: tool.color,
                child: Icon(tool.icon, color: Colors.white),
              ),
              const SizedBox(height: 6),
              Text(tool.name(context.l10n),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11, height: 1.1)),
            ],
          ),
        ),
      );
}
