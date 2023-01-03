import 'package:flutter/material.dart';

class myProfile extends StatelessWidget {
  static final String path = "lib/src/pages/profile/profile8.dart";
 List<String> avatars = [
  'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F1.jpg?alt=media',
  'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F4.jpg?alt=media',
];
 List<String> images = [
  'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F1.jpg?alt=media',
  'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F2.jpg?alt=media',
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        //   leading: IconButton(
        //   icon: Icon(Icons.arrow_back, color: Colors.white),
        //   onPressed: () => Navigator.of(context).pop(),
        // ), 
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ProfileHeader(
                avatar: NetworkImage(avatars[0]),
                coverImage: NetworkImage(images[1]),
                title: "Rbn Gtm",
                subtitle: "Dev",
                actions: <Widget>[
                  MaterialButton(
                    color: Colors.white,
                    shape: CircleBorder(),
                    elevation: 0,
                    child: Icon(Icons.edit),
                    onPressed: () {
                      print("pop");
                    },
                  )
                ],
              ),
              const SizedBox(height: 10.0),
              UserInfo(),
              Padding(
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 13),
                child: Column(
                  children: [
                      userSetting,
                      SizedBox(height: 10),
                      userLogOut(context),
                    
                  ],
                ),
              ),

            // UserInfo(),
            ],
          ),
        ));
  }
}

final userSetting = ElevatedButton(
  onPressed: (){
print("lol");
  },
   style: ElevatedButton.styleFrom(
    primary: Colors.blueGrey,
    // fixedSize: Size.fromWidth(100),
    padding: EdgeInsets.all(6),
  ), 
  child: Padding(
    padding: const EdgeInsets.all(12.0),
    child: Row(
children: [
    Icon(
      Icons.lock_rounded
    ),
    SizedBox(width: 20),
    Expanded(
      child: Text("Change Password")),
      Icon(Icons.arrow_forward_ios)
],
    ),
  ));

Widget userLogOut(BuildContext ctx){
 return ElevatedButton(
  onPressed: (){
    print("lol");
    _customAlertDialog(ctx, AlertDialogType.INFO);
    // CustomAlertDialog();
  },
   style: ElevatedButton.styleFrom(
    primary: Colors.deepOrangeAccent,
    // fixedSize: Size.fromWidth(100),
    padding: EdgeInsets.all(6),
  ), 
  child: Padding(
    padding: const EdgeInsets.all(12.0),
    child: Row(
children: [
    Icon(
      Icons.logout
    ),
    SizedBox(width: 20),
    Expanded(
      child: Text("Sign Out")),
      Icon(Icons.arrow_forward_ios)
],
    ),
  ));
}

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: Text(
              "User Information",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                     ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                            leading: Icon(Icons.my_location),
                            title: Text("Location"),
                            subtitle: Text("Kathmandu"),
                          ),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text("Email"),
                            subtitle: Text("sudeptech@gmail.com"),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text("Phone"),
                            subtitle: Text("99--99876-56"),
                          ),
                          // ListTile(
                          //   leading: Icon(Icons.person),
                          //   title: Text("About Me"),
                          //   subtitle: Text(
                          //       "This is a about me link and you can khow about me in this section."),
                          // ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final ImageProvider<dynamic> coverImage;
  final ImageProvider<dynamic> avatar;
  final String title;
  final String? subtitle;
  final List<Widget>? actions;

  const ProfileHeader(
      {Key? key,
      required this.coverImage,
      required this.avatar,
      required this.title,
      this.subtitle,
      this.actions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Ink(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(image: coverImage as ImageProvider<Object>, fit: BoxFit.cover),
          ),
        ),
        Ink(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.black38,
          ),
        ),
         
        if (actions != null)
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions!,
            ),
          ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 133),
          child: Column(
            children: <Widget>[
              Avatar(
                image: avatar,
                radius: 60,
                backgroundColor: Colors.white,
                borderColor: Colors.grey.shade300,
                borderWidth: 4.0,
              ),
               const SizedBox(height: 5.0),
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 5.0),
                Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ]
            ],
          ),
        )
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final ImageProvider<dynamic> image;
  final Color borderColor;
  final Color? backgroundColor;
  final double radius;
  final double borderWidth;

  const Avatar(
      {Key? key,
      required this.image,
      this.borderColor = Colors.grey,
      this.backgroundColor,
      this.radius = 30,
      this.borderWidth = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      // fit: StackFit.expand,
      
      children: [
        CircleAvatar(
        radius: radius + borderWidth,
        backgroundColor: borderColor,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: backgroundColor != null
              ? backgroundColor
              : Theme.of(context).primaryColor,
          child: CircleAvatar(
            radius: radius - borderWidth,
            backgroundImage: image as ImageProvider<Object>?,
          ),
      
        ),
        
      ),

   Padding(
     padding: EdgeInsets.only(top: 100,left: 95),
     child: InkWell(
       child: Icon(
        
        Icons.camera_alt_rounded,
        color: Colors.blueGrey,),
        onTap: () {
          print("lol");
        },
     ),
   )
      ],
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          // leading: const BackButton(color: Colors.white),
           leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded),
                onPressed: () {
                 Navigator.of(context).pop(true);
                },
                tooltip: '',
              );
            },
          ),
          automaticallyImplyLeading: false,
          title: Text('Profile'),)),

    );
  }
enum AlertDialogType {
  SUCCESS,
  ERROR,
  WARNING,
  INFO,
}
  void _customAlertDialog(BuildContext context, AlertDialogType type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          type: type,
          title: "Confirm Logout",
          content: "Are you sure want to logout from this app?",
        );
      },
    );
  }
  IconData _getIconForType(AlertDialogType type) {
    switch (type) {
      case AlertDialogType.WARNING:
        return Icons.warning;
      case AlertDialogType.SUCCESS:
        return Icons.check_circle;
      case AlertDialogType.ERROR:
        return Icons.error;
      case AlertDialogType.INFO:
      default:
        return Icons.info_outline;
    }
  }

  Color _getColorForType(AlertDialogType type) {
    switch (type) {
      case AlertDialogType.WARNING:
        return Colors.orange;
      case AlertDialogType.SUCCESS:
        return Colors.green;
      case AlertDialogType.ERROR:
        return Colors.red;
      case AlertDialogType.INFO:
      default:
        return Colors.blue;
    }
  }
class CustomAlertDialog extends StatelessWidget {
 final AlertDialogType type;
  final String title;
  final String content;
  final Widget? icon;
  final String buttonLabel;
  final TextStyle titleStyle = TextStyle(
      fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold);

        CustomAlertDialog(
      {Key? key,
      required this.title,
      required this.content,
      this.icon,
      this.type = AlertDialogType.INFO,
      this.buttonLabel = "YES"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
       
          child: Container(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.all(32.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 10.0),
                  icon ??
                      Icon(
                        _getIconForType(type),
                        color: _getColorForType(type),
                        size: 50,
                      ),
                  const SizedBox(height: 16.0,width: double.infinity,),
                  Text(
                    title,
                    style: titleStyle,
                    textAlign: TextAlign.center,
                  ),
                  // Divider(),
                  SizedBox(height: 22,),
                  Text(
                    content,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                    TextButton(onPressed: (){
                    Navigator.pop(context,true);
                  }, 
                  child: Text("CANCEL",style: TextStyle(color: Colors.grey),)),
                     TextButton(
                      child: Text(buttonLabel,style: TextStyle(color: Color(0xff696b9e)),),
                      onPressed: () => Navigator.pop(context, true),
                    ),
                
                    ],
                  )
                 
               
                ],
              ),
            ),
          ),
        );
  }
}  
