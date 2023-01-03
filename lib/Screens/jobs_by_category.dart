import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_job_portal/Screens/job_details.dart';
import 'package:online_job_portal/constants.dart';
import 'dart:async';
import 'package:online_job_portal/models/Jobs.dart';
import 'package:http/http.dart' as http;
class JobsByCategory extends StatefulWidget {
   JobsByCategory({super.key, required this.title,required this.id});
   String title;
   String id;
   
  @override
  State<JobsByCategory> createState() => _JobsByCategoryState();
}

class _JobsByCategoryState extends State<JobsByCategory>
  {
    Future<List<Jobs>> getJobsByCategory() async{
        List<Jobs>? jobList;
        var respo = await http.get(Uri.parse(Constant.url + 'jobs/category/' + widget.id));
        if(respo.statusCode == 200){
        print("id:"+ widget.id + "\n" + respo.body);

          var data = jsonDecode(respo.body)['data'] as List;
          jobList = data.map<Jobs>((json) => Jobs.fromJson(json)).toList(); 
        }
        return jobList!;
    }

@override
  void initState() {
  getJobsByCategory();
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title}"),
        backgroundColor: Color(0xff696b9e),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: FutureBuilder(
          future: getJobsByCategory(),
          builder: (context,snapshot){
          return (snapshot.data!=null) ? 
          listJobsWidget(snapshot.data) : Center(child: CircularProgressIndicator());
          },
      ),
      ),
    );
  }

  Widget listJobsWidget(List<Jobs>? data){
      if(data!.isEmpty){
        return nojobsFound(widget.title);
       }
      
   return Container(
      child: RefreshIndicator(
        onRefresh: () { 
          return Future.delayed(Duration(seconds: 2),(() {
           setState(() {
            getJobsByCategory();
           });
        
            ScaffoldMessenger.of(context).showSnackBar( 
              SnackBar(
                elevation: 90,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)
                ),
                behavior: SnackBarBehavior.floating, 
                backgroundColor: Constant.primary,
                duration: Duration(seconds: 1),
                content: const Text('Page Refreshed',style: TextStyle(fontSize: 15,color: Colors.white),),
            
            )
            );
            
            }));
         },
   
      child: ListView.builder(
      itemCount: data.length,
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
                    color: Colors.white
                  ),
                  height: 110,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(right: 15,top: 15,bottom: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: 2,color: Constant.primary),
                        ),
                        child: Image.network(Constant.imgUrl + data[position].image.toString(),
                          width: 50,
                          height: 50,
                        ),
                      ),
                          Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data[position].subcategoryName.toString(),
                      style: TextStyle(
                          color: Constant.primary,
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
                                color: Constant.primary, fontSize: 15, letterSpacing: .3)),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Constant.secondary,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text('${data[position].companyAddress}',
                            style: TextStyle(
                                color: Constant.primary, fontSize: 13, letterSpacing: .3)),
                      ],
                    ),
                  ],
                ),
              )
                    ],
                  ),
                ),
        );
      })
      )
   );
  }
  }
  
  Widget nojobsFound(String title) {
     return Center(
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Image.asset('assets/images/ic_emptybox.png',
           ),
           SizedBox(height: 10,),
           Center(child: 
               Text("no jobs found",
               style: TextStyle(letterSpacing: .2),)
               ),
         ],
       ),
     );
  }
