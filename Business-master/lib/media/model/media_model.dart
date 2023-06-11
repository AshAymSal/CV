class MediaModel {
  int? id;
  String? filename;
  String? mediaType;
  String? modelType;
  String? modelId;

  MediaModel({
    this.id,
    this.filename,
    this.mediaType,
    this.modelType,
    this.modelId,
  });

  MediaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    filename = json['filename'];
    mediaType = json['mediaType'];
    modelType = json['model_type'];
    modelId = json['model_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['filename'] = this.filename;
    data['mediaType'] = this.mediaType;
    data['model_type'] = this.modelType;
    data['model_id'] = this.modelId;
    return data;
  }
}
