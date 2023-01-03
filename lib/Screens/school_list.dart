import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:online_job_portal/Screens/custom_widget.dart';
import 'package:online_job_portal/Screens/job_details.dart';
import 'package:online_job_portal/Screens/jobs_by_category.dart';
import 'package:online_job_portal/Screens/profile_view.dart';
import 'package:online_job_portal/constants.dart';
import 'package:online_job_portal/models/Jobs.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:online_job_portal/models/category.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
   GlobalKey<ScaffoldState>? _scaffoldKey;
   final TextStyle dropdownMenuItem =
   const TextStyle(color: Colors.black, fontSize: 18);
   int _selectedIndex = 0;
  final primary = const Color(0xff696b9e);
  final secondary = const Color(0xfff29a94);
  String url = 'http://192.168.1.73:8000/api/';
   bool _isLoading=true;

  Future<List<Jobs>> getData() async {
  List<Jobs> jobsList = List.empty();
    var res = await http
        .get(Uri.parse('${Constant.url}jobs'));
      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        var rest = data["data"] as List;
        jobsList = rest.map<Jobs>((json) => Jobs.fromJson(json)).toList();
      }
    //  setState(() {
    //   _isLoading=false;
    // });
    return jobsList;
   
  }

  Future<List<JobsCategory>> getJobsCategory() async{
    List<JobsCategory> jList = List.empty();
    var res = await http.get(Uri.parse('${Constant.url}jobs/category'));
    if(res.statusCode == 200){
      var data = json.decode(res.body)['data'] as List;
      jList =  data.map<JobsCategory>((json) => JobsCategory.fromJson(json)).toList();
    }
    // print(jList.length);
    return jList;
  }

@override
  void initState() {
    getData();
    getJobsCategory();
    print("initState");
    _scaffoldKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    _scaffoldKey?.currentState?.dispose();
    super.dispose();
  }
   
  @override
  Widget build(BuildContext context) {
    return Container(
      key: _scaffoldKey,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 178),
                margin:EdgeInsets.only(bottom: 0),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: FutureBuilder(
                  future: getData(),
                  builder: (context, snapshot) {
                    return (snapshot.data!=null)?
                    jobsListView(snapshot.data) : 
                     const Center(child: CircularProgressIndicator());
                    // return buildList(context, index);
                  },
                   
                    ),
              ),
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: primary,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                  child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                   const Icon(
                    color: Colors.white,
                    Icons.list,
                      // height: 40,
                      // width: 40,
                      // image: NetworkImage('https://cdn-icons-png.flaticon.com/512/3315/3315296.png'),
                    ),
                   
                      const Text(
                        "Online Job Portal",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                  
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                  elevation: 4.0,
                  shape: const CircleBorder(),
                  clipBehavior: Clip.hardEdge,
                  color: Colors.transparent,
                  child: Ink.image(
                    image: NetworkImage('http://wallpapers.net/web/wallpapers/3d-girls-face-hd-wallpaper/180x180.jpg'),
                    fit: BoxFit.cover,
                    width: 40.0,
                    height: 40.0,
                    child: InkWell(
                      onTap: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => myProfile()),
                        );
                      },
                    ),
                  ),
              ),
                )
                      
                    ],
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  const SizedBox(
                    height: 110,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      child: TextField(
                        // controller: TextEditingController(text: locations[0]),
                        cursorColor: Theme.of(context).primaryColor,
                        style: dropdownMenuItem,
                        decoration: const InputDecoration(
                            hintText: "Search Jobs",
                            hintStyle: TextStyle(
                                color: Colors.black38, fontSize: 16),
                            prefixIcon: Material(
                              elevation: 0.0,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              child: Icon(Icons.search),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 13)),
                      ),
    
                    ),
                    
                  ),
                  SizedBox(height: 1,),
                  Container(
                    margin: EdgeInsets.only(left: 0,right:0),
                  //  padding: const EdgeInsets.only(top: 5),
                    height: 56,
                    width: double.infinity,
                    child: FutureBuilder(
                      future: getJobsCategory(),
                      builder: (builder,snapshot){
                      return snapshot.data!=null ? 
                      listViewJobsCat(snapshot.data) :
                      Center(child: CircularProgressIndicator(),);
                      } 
                    ),
                  
                  ),
                  
                ],
              )
            ],
          ),
        ),
      );
  }

 Widget buildMovieShimmer() =>
      ListTile(
        leading: CustomWidget.circular(height: 64, width: 64),
        title: Align(
          alignment: Alignment.centerLeft,
          child: CustomWidget.rectangular(height: 16,
            width: MediaQuery.of(context).size.width*0.3,),
        ),
        subtitle: CustomWidget.rectangular(height: 14),
      );

  Widget jobsListView(List<Jobs>? data) {
    return Container(
      child: RefreshIndicator(
        onRefresh: () { 
          return Future.delayed(Duration(seconds: 2),(() {
           setState(() {
            getData();
            getJobsCategory();
           });
        
            ScaffoldMessenger.of(context).showSnackBar( 
              SnackBar(
                elevation: 90,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)
                ),
                behavior: SnackBarBehavior.floating, 
                backgroundColor: primary,
                duration: Duration(seconds: 1),
                content: const Text('Page Refreshed',style: TextStyle(fontSize: 15,color: Colors.white),),
            
            )
            );
            
            }));
         },
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: data!.length,
          itemBuilder: (context,position){
          return InkWell(
          onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => JobDetails(),
           settings: RouteSettings(
                      arguments: data[position],
                    ),));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
          ),
          width: double.infinity,
          height: 110,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(right: 15,top: 15,bottom: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(width: 2, color: primary)
                    ),
                    child: Image.network("${Constant.imgUrl}${data[position].image}"
                  ,
                  width: 50,
                  height: 50,
                ),
              ),
              // Expanded(
              //   child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data[position].subcategoryName.toString(),
                      style: TextStyle(
                          color: primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: <Widget>[
                        // Icon(
                        //   Icons.location_on,
                        //   color: secondary,
                        //   size: 20,
                        // ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(data[position].companyName.toString(),
                            style: TextStyle(
                                color: primary, fontSize: 15, letterSpacing: .3)),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: secondary,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text('${data[position].companyAddress}',
                            style: TextStyle(
                                color: primary, fontSize: 13, letterSpacing: .3)),
                      ],
                    ),
                  ],
                ),
              // )
            ],
          ),
        ),
          );
          // }
        }),
      ),
    );
  }
  
  Widget listViewJobsCat(List<JobsCategory>? data) {
  return ListView.builder(
                      padding: EdgeInsets.all(10),
                      scrollDirection: Axis.horizontal,
                        itemCount: data?.length,
                        itemBuilder:(context, position) {
                          return Container(
                               decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(22)
                              ),
                               height: 40,
                              //  width: double.infinity,
                              // color: Colors.amber,
                              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 30),
                              margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                          
                              child: InkWell(
                                onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => 
                                JobsByCategory(
                                  title: data![position].name.toString(),
                                  id:data[position].id.toString() ,)));
                                  },
                                // child: Expanded(
                                  child: Center(
                                  child: Text('${data?[position].name}',
                                  style: TextStyle(color: Colors.white),
                                  )
                                  // )
                                  ),
                              ),
                            
                          );
                        },
                      );
  }
}