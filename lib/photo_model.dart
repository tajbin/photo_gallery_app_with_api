class PhotoModel{
  int? albumId;
  int? id;
  String? title;
  String? imgUrl;
  String? thumbnailImgUrl;

  PhotoModel.fromJson(Map<String, dynamic> json) {
    albumId =json["albumId"];
    id =json["id"];
    title =json["title"];
    imgUrl =json["url"];
    thumbnailImgUrl =json["thumbnailUrl"];
}
}