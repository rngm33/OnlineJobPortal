import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:online_job_portal/Screens/login.dart';
import 'package:online_job_portal/constants.dart';
import 'package:online_job_portal/models/Jobs.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;
class JobDetails extends StatefulWidget {
   JobDetails({super.key}); 

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {

  @override
  Widget build(BuildContext context) {
        final jobs = ModalRoute.of(context)!.settings.arguments as Jobs;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
      toolbarHeight: 0,
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle.light),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 40,
              margin: EdgeInsets.only(top: 34),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // SizedBox(width: 10,),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context,true);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black54,)),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Text("Job Details",style: TextStyle(color: Colors.black54,fontSize: 20),),
                    ),
                    Icon(Icons.bookmark,color: Colors.black54,)
                  ],
                ),
              ),
              
            ),
      
           Column(
             children: [
               Stack(
                      children: [
                        Container(
                          height: 160,
                          margin: EdgeInsets.symmetric(vertical: 70,horizontal: 15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey.shade50,
                          ),
                        ),
                          Center(
                               child: Container(
                                margin: EdgeInsets.only(top: 15),
                                 child: CircleAvatar(
                                 radius: 60,
                                 backgroundColor: Colors.white,
                                 child: CircleAvatar(
                                  radius: 55,
                                 child: ClipOval(
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  color: Colors.white,
                                  child: Image.network(
                                    Constant.imgUrl+ "${jobs.image}",
                                    width: 200.0,
                                    height: 200.0,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              )
                                //  backgroundColor: Colors.white,

                                //  backgroundImage: NetworkImage(Constant.imgUrl+ "${jobs.image}")
                                 ),
                                 ),
                               ),
                             ),
                           
                          Container(
                            margin: EdgeInsets.only(top: 145),
                            child: Center(
                              child: Text(jobs.subcategoryName.toString(),
                              style: TextStyle(fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              letterSpacing: 2)
                              )
                              )
                              ),
                             
                             Container(
                             margin: EdgeInsets.only(top: 182,left: 45,right: 45),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(jobs.companyName.toString() ,style: TextStyle(fontSize: 14,
                              fontWeight: FontWeight.bold,color: Colors.black54)),
                        
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(".", style: TextStyle(fontSize: 25,
                                fontWeight: FontWeight.bold,color: Colors.grey)),
                        ),
                        
                        Text(jobs.companyAddress.toString(), style: TextStyle(fontSize: 14,
                              fontWeight: FontWeight.bold,color: Colors.black54)),
                        
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(".", style: TextStyle(fontSize: 25,
                                fontWeight: FontWeight.bold,color: Colors.grey)),
                        ),
                 
                        Text("1 day ago", style: TextStyle(fontSize: 14,
                              fontWeight: FontWeight.bold,color: Colors.black54)),
                 
                      ],
                      ),
                             ),
                     
                     Container(
                     margin: EdgeInsets.only(left: 28,right: 28 ,top: 250),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                             Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.amber.shade50,
                                borderRadius: BorderRadius.circular(50)
                              ),
                              child: Icon(Icons.monetization_on_outlined)),
                              SizedBox(height: 10,),
                              Text("salary",style: TextStyle(fontSize: 14,
                              fontWeight: FontWeight.bold,color: Colors.grey)),
                              SizedBox(height: 7,),
                              Text(jobs.salary.toString(),style: TextStyle(fontSize: 14,
                              fontWeight: FontWeight.bold,color: Colors.black54))
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(50)
                              ),
                                child: Icon(Icons.timer_sharp)),
                              SizedBox(height: 10,),
                              Text("Job Type",style: TextStyle(fontSize: 14,
                              fontWeight: FontWeight.bold,color: Colors.grey)),
                              SizedBox(height: 7,),
                              Text(jobs.jobtype.toString(),style: TextStyle(fontSize: 14,
                              fontWeight: FontWeight.bold,color: Colors.black54))
                            ],
                          ),
                          Column(
                            children: [
                             Container(
                               height: 40,
                               width: 40,
                               decoration: BoxDecoration(
                                color: Colors.brown.shade50,
                                borderRadius: BorderRadius.circular(50)
                              ),
                              child: Icon(Icons.print_rounded)),
                              SizedBox(height: 10,),
                              Text("Position",style: TextStyle(fontSize: 14,
                              fontWeight: FontWeight.bold,color: Colors.grey)),
                              SizedBox(height: 7,),
                              Text("Junior",style: TextStyle(fontSize: 14,
                              fontWeight: FontWeight.bold,color: Colors.black54))
                            ],
                          )
                        ],
                      ),
                             ),
                             ]
                             ),
             ],
           ),
              
            Container(
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.only(top: 16,left: 15),
              child: Text("Description",
              style: TextStyle(fontSize: 22,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54)
                      )
                      ),
                       Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 8,left: 0,right: 15),
                            child: Column(
                              children: [
                                 buildJobDesc(jobs)
                              ],
                            ),
                          
                        ),
                      
                       Align(
                        // alignment: Alignment.bottomCenter,
                         child: Container(
                          margin: EdgeInsets.only(top: 0,left: 20,right: 20),
                          width: double.infinity,
                           child: ElevatedButton(
                            onPressed: (() {
                              Navigator.push(context,MaterialPageRoute(builder: (_) => LoginPage()));
                            }),
                            child: Text("Apply Now"),
                             ),
                         ),
                       ),
                      
              ],
            
          
        ),
      ),
      
    );
    
  }

                    Widget buildJobDesc(Jobs jobs) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                          //   Padding(
                          //   padding: const EdgeInsets.only(bottom: 50),
                          //   child: Text(".", 
                          //   style: TextStyle(fontSize: 25,
                          //         fontWeight: FontWeight.bold,
                          //         color: Colors.black54)),
                          // ),
                          SizedBox(width: 10,),
                              Expanded(
                                child: Html(
                                data: "${jobs.description}",
                                 ),
                                ),
                              
                            ],
                          );
                          }
}

