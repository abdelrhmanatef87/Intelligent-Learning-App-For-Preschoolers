import 'dart:convert';

class UserFields {
  static final String userId = 'User id';
  static final String username = 'Username';
  static final String email = 'Email';
  static final String gender = 'Gender';
  static final String review = 'Review';
  static final String positive = 'Positive';
  static final String negative = 'Negative';
  static final String choose = 'Choose';
  static final String complete = 'Complete';
  static final String match = 'Match';
  static final String listen = 'Listen';
  static final String read = 'Read';
  static final String duration = 'Duration';
  static final String closeApp = '#use app';
  static final String avgusage = 'Average usage of the app';

  static final List<String> Info = [
    userId, username, email, gender, review, positive, negative, choose,
    complete, match, listen, read, duration, closeApp, avgusage
  ];

  static List<String> getFields() {
    return Info;
  }
}

class User_Info {
  final String userId;
  final String username;
  final String email;
  final String gender;
  final String review;
  final double positive;
  final double negative;
  final int choose;
  final int complete;
  final int match;
  final int listen;
  final int read;
  final String duration;
  final int closeApp;
  final String avgDuration;

  const User_Info(
      {required this.userId,
      required this.username,
      required this.email,
      required this.gender,
      required this.review,
      required this.positive,
      required this.negative,
      required this.choose,
      required this.complete,
      required this.match,
      required this.listen,
      required this.read,
      required this.duration,
      required this.closeApp,
      required this.avgDuration});

  Map<String, dynamic> toJson() => {
        UserFields.userId: userId,
        UserFields.username: username,
        UserFields.email: email,
        UserFields.gender: gender,
        UserFields.review: review,
        UserFields.positive: positive,
        UserFields.negative: negative,
        UserFields.choose: choose,
        UserFields.complete: complete,
        UserFields.match: match,
        UserFields.listen: listen,
        UserFields.read: read,
        UserFields.duration: duration,
      };

  User_Info copy(
          {String? userId,
          String? username,
          String? email,
          String? gender,
          String? review,
          double? positive,
          double? negative,
          int? choose,
          int? complete,
          int? match,
          int? listen,
          int? read,
          String? duration,
          int? closeApp,
          String? avgDuration}) =>
      User_Info(
          userId: userId ?? this.userId,
          username: username ?? this.username,
          email: email ?? this.email,
          gender: gender ?? this.gender,
          review: review ?? this.review,
          positive: positive ?? this.positive,
          negative: negative ?? this.negative,
          choose: choose ?? this.choose,
          complete: complete ?? this.complete,
          match: match ?? this.match,
          listen: listen ?? this.match,
          read: read ?? this.read,
          duration: duration ?? this.duration,
          closeApp: closeApp ?? this.closeApp,
          avgDuration: avgDuration ?? this.avgDuration);

  static User_Info fromJson(Map<String, dynamic> json) => User_Info(
      userId: json[UserFields.userId],
      username: json[UserFields.username],
      email: json[UserFields.email],
      gender: json[UserFields.gender],
      review: json[UserFields.review],
      positive: jsonDecode(json[UserFields.positive]).toDouble(),
      negative: jsonDecode(json[UserFields.negative]).toDouble(),
      choose: jsonDecode(json[UserFields.choose]),
      complete: jsonDecode(json[UserFields.complete]),
      match: jsonDecode(json[UserFields.match]),
      listen: jsonDecode(json[UserFields.listen]),
      read: jsonDecode(json[UserFields.read]),
      duration: jsonDecode(UserFields.duration),
      closeApp: json[UserFields.closeApp],
      avgDuration: jsonDecode(UserFields.avgusage));
}
