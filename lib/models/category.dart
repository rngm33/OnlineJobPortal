class JobsCategory{
int? id;
String? name;
String? image;
String? created_at;
String? updated_at;

JobsCategory(this.id,this.name,this.image,this.created_at,this.updated_at);

JobsCategory.fromJson(Map<String,dynamic> json){
  id= json['id'];
  name = json['name'];
  image= json['image'];
  created_at = json['created_at'];
  updated_at= json['updated_at'];
}

}