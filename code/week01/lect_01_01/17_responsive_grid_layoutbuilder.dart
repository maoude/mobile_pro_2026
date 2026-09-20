// Source: 002_lect_01_01.tex, section 4.1 Layout and Composition - Responsive Grids with LayoutBuilder
// Flutter widget; needs an import of package:flutter/material.dart.

class BusinessCardGrid extends StatelessWidget {
  const BusinessCardGrid({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final count = c.maxWidth > 600 ? 3 : 2;
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (_, i) => const Placeholder(),
        );
      },
    );
  }
}
