class DiseaseDetailsModel {
  String name, definition, causes, symptoms, treatment, recommendations;
  DiseaseDetailsModel({
    this.treatment,
    this.recommendations,
    this.name,
    this.causes,
    this.definition,
    this.symptoms,
  });
  Map<String, dynamic> toMap() => {
        "treatment": treatment,
        "recommendations": recommendations,
        "causes": causes,
        "definition": definition,
        "symptoms": symptoms,
        "name": name,
      };

  //to receive the data we need to pass it from Map to json
  //para recibir los datos necesitamos pasarlo de Map a json
  factory DiseaseDetailsModel.fromMap(Map<String, dynamic> json) =>
      new DiseaseDetailsModel(
        treatment: json["treatment"],
        recommendations: json["recommendations"],
        name: json["name"],
        causes: json["causes"],
        definition: json["definition"],
        symptoms: json["symptoms"],
      );
}
