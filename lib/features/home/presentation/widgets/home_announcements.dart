import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/home/data/models/announcement_model.dart';
import 'package:limitless_code_template/features/home/presentation/widgets/home_announcement_banner.dart';

/// "Management announcements" title with a "1 of 3" counter and a swipeable
/// carousel that peeks the next banner (Figma "Announcements Section").
class HomeAnnouncements extends StatefulWidget {
  const HomeAnnouncements({required this.announcements, super.key});

  final List<AnnouncementModel> announcements;

  @override
  State<HomeAnnouncements> createState() => _HomeAnnouncementsState();
}

class _HomeAnnouncementsState extends State<HomeAnnouncements> {
  // Figma: 300-wide banners + 12 gap inside the 353 content width.
  final _controller = PageController(viewportFraction: 312 / 353);
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.announcements;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8.h,
      children: [
        Row(
          children: [
            Expanded(
              child: AppText(
                context.localizations.homeAnnouncements,
                style: context.typography.title3XS,
              ),
            ),
            AppText(
              context.localizations.countOf(_page + 1, items.length),
              style: context.typography.bodyXS,
              color: context.colors.textCaption,
            ),
          ],
        ),
        SizedBox(
          height: 98.h,
          child: PageView.builder(
            controller: _controller,
            padEnds: false,
            itemCount: items.length,
            onPageChanged: (page) => setState(() => _page = page),
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsetsDirectional.only(end: 12.w),
              child: HomeAnnouncementBanner(
                announcement: items[index],
                // Figma alternates the decorative truck's grey.
                decorationColor: index.isEven
                    ? context.colors.brandPrimarySoft
                    : context.colors.brandPrimary200,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
