class Jobss {
  List<Jobs>? data;

  Jobss({this.data});

  Jobss.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Jobs>[];
      json['data'].forEach((v) {
        data!.add(Jobs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Jobs {
  int? id;
  String? subcategoryName;
  String? userName;
  String? categoryId;
  String? jobtype;
  String? noVaccancy;
  String? description;
  String? salary;
  String? image;
  String? companyName;
  String? companyEmail;
  String? companyPhone;
  String? companyAddress;
  String? createdAt;
  String? updatedAt;

  Jobs(
      {this.id,
      this.subcategoryName,
      this.userName,
      this.categoryId,
      this.jobtype,
      this.noVaccancy,
      this.description,
      this.salary,
      this.image,
      this.companyName,
      this.companyEmail,
      this.companyPhone,
      this.companyAddress,
      this.createdAt,
      this.updatedAt});

   Jobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subcategoryName = json['subcategory_name'];
    userName = json['user_name'];
    categoryId = json['category_id'];
    jobtype = json['jobtype'];
    noVaccancy = json['no_vaccancy'];
    description = json['description'];
    salary = json['salary'];
    image = json['image'];
    companyName = json['company_name'];
    companyEmail = json['company_email'];
    companyPhone = json['company_phone'];
    companyAddress = json['company_address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['subcategory_name'] = this.subcategoryName;
    data['user_name'] = this.userName;
    data['category_id'] = this.categoryId;
    data['jobtype'] = this.jobtype;
    data['no_vaccancy'] = this.noVaccancy;
    data['description'] = this.description;
    data['salary'] = this.salary;
    data['image'] = this.image;
    data['company_name'] = this.companyName;
    data['company_email'] = this.companyEmail;
    data['company_phone'] = this.companyPhone;
    data['company_address'] = this.companyAddress;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}