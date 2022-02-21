class PictureModel {
  late int page;
  late int perPage;
  late List<Photos> photos;
  late int totalResults;
  late String? nextPage;
  late String? prevPage;

  PictureModel({required this.page, required this.perPage, required this.photos, required this.totalResults, required this.nextPage, required this.prevPage});

  PictureModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos.add(Photos.fromJson(v));
      });
    }
    totalResults = json['total_results'];
    nextPage = json['next_page'];
    prevPage = json['prev_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['per_page'] = perPage;
    if (photos != null) {
      data['photos'] = photos.map((v) => v.toJson()).toList();
    }
    data['total_results'] = totalResults;
    data['next_page'] = nextPage;
    data['prev_page'] = prevPage;
    return data;
  }
}

class Photos {
  late final int id;
  late final int width;
  late final int height;
  late final String? url;
  late final String? photographer;
  late final String? photographerUrl;
  late final int photographerId;
  late final String? avgColor;
  late final Src src;

  Photos(
      {required this.id,
      required this.width,
      required this.height,
      required this.url,
      required this.photographer,
      required this.photographerUrl,
      required this.photographerId,
      required this.avgColor,
      required this.src});

  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    photographer = json['photographer'];
    photographerUrl = json['photographer_url'];
    photographerId = json['photographer_id'];
    avgColor = json['avg_color'];
    src = (json['src'] != null ? Src.fromJson(json['src']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['width'] = width;
    data['height'] = height;
    data['url'] = url;
    data['photographer'] = photographer;
    data['photographer_url'] = photographerUrl;
    data['photographer_id'] = photographerId;
    data['avg_color'] = avgColor;
    if (src != null) {
      data['src'] = src.toJson();
    }
    return data;
  }
}

class Src {
  late final String? original;
  late final String? large2x;
  late final String? large;
  late final String? medium;
  late final String? small;
  late final String? portrait;
  late final String? landscape;
  late final String? tiny;

  Src({required this.original, required this.large2x, required this.large, required this.medium, required this.small, required this.portrait, required this.landscape, required this.tiny});

  Src.fromJson(Map<String, dynamic> json) {
    original = json['original'];
    large2x = json['large2x'];
    large = json['large'];
    medium = json['medium'];
    small = json['small'];
    portrait = json['portrait'];
    landscape = json['landscape'];
    tiny = json['tiny'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['original'] = original;
    data['large2x'] = large2x;
    data['large'] = large;
    data['medium'] = medium;
    data['small'] = small;
    data['portrait'] = portrait;
    data['landscape'] = landscape;
    data['tiny'] = tiny;
    return data;
  }
}