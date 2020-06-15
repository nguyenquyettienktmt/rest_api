class GetJSNews{
  int id;
  String title;
  String desc;
  String datetime;
  String urlImage;

  GetJSNews({this.id,this.title,this.desc,this.datetime,this.urlImage});

  factory GetJSNews.fromJson(Map<String,dynamic> item){
    return GetJSNews(
        id: item["ID"],
        title: item["tieude"],
        desc:item["mota"],
        datetime: item["ngayhienthi"],
        urlImage: item["urlHinhAnh"]
    );
  }

  Map<String, dynamic> toJson() =>{
    "ID": id,
    "tieude": title,
    "mota": desc,
    "ngayhienthi": datetime,
    "urlHinhAnh": urlImage
  };
}