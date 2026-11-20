/// One management announcement on the home carousel.
///
/// Assumed payload: `{"title": "...", "body": "..."}`.
class AnnouncementModel {
  const AnnouncementModel({required this.title, required this.body});

  AnnouncementModel.fromJson(Map<String, dynamic> json)
    : title = json['title'] as String? ?? '',
      body = json['body'] as String? ?? '';

  final String title;
  final String body;

  Map<String, dynamic> toJson() => {'title': title, 'body': body};
}
