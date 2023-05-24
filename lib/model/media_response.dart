class MediaListResponse {
  final String title;
  final String body;

  MediaListResponse({required this.title, required this.body});

  factory MediaListResponse.fromJson(Map<String, dynamic> json) {
    return MediaListResponse(
      title: json['title'] ?? "",
      body: json['body'] ?? "",
    );
  }
}

// extension FinalImageUrl on MediaListResponse {
//   String? get finalUrl {
//     return hdurl;
//   }
// }
