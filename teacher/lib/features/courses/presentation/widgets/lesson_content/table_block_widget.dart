import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'lesson_content_helpers.dart';

class TableBlockWidget extends StatelessWidget {
  const TableBlockWidget({
    required this.content,
    required this.withHeadings,
    super.key,
  });

  final List<dynamic> content;
  final bool withHeadings;

  @override
  Widget build(BuildContext context) {
    if (content.isEmpty) return const SizedBox.shrink();

    final borderSide = BorderSide(
      color: Theme.of(context).colorScheme.outlineVariant,
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: Table(
          defaultColumnWidth: const IntrinsicColumnWidth(),
          border: TableBorder(
            horizontalInside: borderSide,
            verticalInside: borderSide,
          ),
          children: List.generate(content.length, (rowIndex) {
            final row = content[rowIndex] as List<dynamic>;
            final isHeadingRow = withHeadings && rowIndex == 0;

            return TableRow(
              decoration: BoxDecoration(
                color: isHeadingRow
                    ? Theme.of(context).colorScheme.surfaceContainerHighest
                    : null,
              ),
              children: List.generate(row.length, (colIndex) {
                final cellText = row[colIndex].toString();

                return TableCell(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: LessonContentHelpers.parseHtmlToSpans(
                          context,
                          cellText,
                        ),
                        style: isHeadingRow
                            ? TextStyle(fontWeight: FontWeight.bold)
                            : null,
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}
