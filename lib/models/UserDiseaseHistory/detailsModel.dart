class DetailsModel {
  String id, userId, masterId, diseaseName, createdAt, ratio;

  DetailsModel({
    this.id,
    this.userId,
    this.masterId,
    this.diseaseName,
    this.createdAt,
    this.ratio,
  });
  Map<String, dynamic> toMap() => {
        "id": id,
        " userId": userId,
        "diseaseName": diseaseName,
        "createdAt": createdAt,
        "ratio": ratio,
        "masterId": masterId,
      };

  //to receive the data we need to pass it from Map to json
  //para recibir los datos necesitamos pasarlo de Map a json
  factory DetailsModel.fromMap(Map<String, dynamic> json) => new DetailsModel(
        id: json["id"],
        userId: json[" userId"],
        masterId: json["masterId"],
        diseaseName: json["diseaseName"],
        createdAt: json["createdAt"],
        ratio: json["ratio"],
      );
}
