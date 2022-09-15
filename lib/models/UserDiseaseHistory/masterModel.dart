class MasterModel {
  String createdAt, id, userId;
  MasterModel({
    this.id,
    this.userId,
    this.createdAt,
  });
  Map<String, dynamic> toMap() => {
        "id": id,
        "userId": userId,
        "createdAt": createdAt,
      };

  //to receive the data we need to pass it from Map to json
  //para recibir los datos necesitamos pasarlo de Map a json
  factory MasterModel.fromMap(Map<String, dynamic> json) => new MasterModel(
        id: json["id"],
        userId: json["userId"],
        createdAt: json["createdAt"],
      );
}
