class NotificationModel {
  final String title;
  final String subtitle;
  final DateTime? dateTime;
  final bool isRead;

  NotificationModel({
    required this.title,
    required this.subtitle,
    this.dateTime,
    this.isRead = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      dateTime: json['dateTime'] != null
          ? DateTime.parse(json['dateTime'])
          : null,
      isRead: json['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'dateTime': dateTime?.toIso8601String(),
      'isRead': isRead,
    };
  }

  NotificationModel copyWith({
    String? title,
    String? subtitle,
    DateTime? dateTime,
    bool? isRead,
  }) {
    return NotificationModel(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      dateTime: dateTime ?? this.dateTime,
      isRead: isRead ?? this.isRead,
    );
  }
}
