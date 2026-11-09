import 'package:flutter/material.dart';

import '../core/l10n.dart';
import '../core/logo.dart';
import '../core/registry.dart';
import '../core/store.dart';
import '../core/tool.dart';
import 'language_page.dart';
import 'section_page.dart';
import 'tool_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final store = StoreScope.of(context);
    final scheme = Theme.of(context).colorScheme;
    final searching = _query.trim().isNotEmpty;

    final filtered = allTools
        .where((t) => t.matches(l, _query))
        .toList();
    final favorites = allTools.where((t) => store.isFavorite(t.id)).toList();
    final recent = [
      for (final id in store.recent) ...allTools.where((t) => t.id == id),
    ];

    final themeIcon = switch (store.themeMode) {
      ThemeMode.system => Icons.brightness_auto_rounded,
      ThemeMode.light => Icons.light_mode_rounded,
      ThemeMode.dark => Icons.dark_mode_rounded,
    };

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 8, 8),
                child: Row(
                  children: [
                    const UtilixLogo(size: 44),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Utilix',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.w800)),
                          Text(l.homeSubtitle(allTools.length),
                              style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 13)),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: l.languageTooltip,
                      icon: const Icon(Icons.language_rounded),
                      onPressed: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => const LanguagePage())),
                    ),
                    IconButton(
                      tooltip: l.themeTooltip,
                      icon: Icon(themeIcon),
                      onPressed: store.cycleTheme,
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: TextField(
                  onChanged: (v) => setState(() => _query = v),
                  decoration: InputDecoration(
                    hintText: l.searchHint,
                    prefixIcon: const Icon(Icons.search_rounded),
                  ),
                ),
              ),
            ),
            if (searching) ...[
              SectionTitle(l.sectionResults),
              if (filtered.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Icon(Icons.search_off_rounded, size: 48, color: scheme.outline),
                        const SizedBox(height: 8),
                        Text(l.nothingFound),
                      ],
                    ),
                  ),
                )
              else
                ToolGrid(tools: filtered),
            ] else ...[
              if (recent.isNotEmpty) ...[
                SectionTitle(l.sectionRecent),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 96,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: recent.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 12),
                      itemBuilder: (_, i) => MiniTool(tool: recent[i]),
                    ),
                  ),
                ),
              ],
              if (favorites.isNotEmpty) ...[
                SectionTitle(l.sectionFavorites),
                ToolGrid(tools: favorites),
              ],
              SectionTitle(l.sectionAllTools),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.95,
                  ),
                  itemCount: ToolCategory.values.length,
                  itemBuilder: (_, i) => _CategoryCard(category: ToolCategory.values[i]),
                ),
              ),
            ],
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.category});
  final ToolCategory category;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final tools = allTools.where((t) => t.category == category).toList();
    final preview = tools.take(3).map((t) => t.name(l)).join(' · ');
    final base = category.color;
    return Material(
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.antiAlias,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [base, Color.lerp(base, Colors.black, .28)!],
          ),
        ),
        child: InkWell(
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => SectionPage(category: category))),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .22),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(category.icon, color: Colors.white, size: 28),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .22),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text('${tools.length}',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                const Spacer(),
                Text(category.label(l),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        height: 1.15)),
                const SizedBox(height: 4),
                Text(preview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: .85), fontSize: 12, height: 1.2)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
