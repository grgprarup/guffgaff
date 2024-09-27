class UserProfile {
  String? userId;
  String? fullName;
  String? profPicURL;

  UserProfile({
    required this.userId,
    required this.fullName,
    required this.profPicURL,
  });

  UserProfile.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    fullName = json['fullName'];
    profPicURL = json['profPicURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['profPicURL'] = profPicURL;
    data['userId'] = userId;
    return data;
  }
}
