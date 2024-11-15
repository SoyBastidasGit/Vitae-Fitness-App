class ProfileModel {
  final String name;
  final String lastname;
  final String email;
  final DateTime birthDate;
  final String password;

  ProfileModel({
    required this.name,
    required this.lastname,
    required this.email,
    required this.birthDate,
    required this.password,
  });
}

class VideoItem {
  final String title;
  final String url;
  final String urlImage;

  VideoItem({required this.title, required this.url, required this.urlImage});
}
