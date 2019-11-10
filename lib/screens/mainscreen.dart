import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:instagram_clone/blocs/instagrambloc.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/screens/activity.dart';
import 'package:instagram_clone/screens/searchscreen.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'addpost.dart';
import 'PorfileScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  User u;

  @override
  Widget build(BuildContext context) {
    InstagramBloc bloc = Provider.of<InstagramBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Instagram",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Instagram',
            fontSize: 40,
          ),
        ),
        backgroundColor: Color(0xFFFAFAFA),
      ),
      body: ListView.builder(
        itemCount: bloc.timeline.length,
        itemBuilder: (_, i) {
          Post p = bloc.timeline[i];
          //////////////////////////////////////////////////
          return Column(
            children: <Widget>[
              new Container(
                //container for the first row
                //padding: EdgeInsets.symmetric(horizontal: 10.0, ),
                padding: EdgeInsets.only(left: 10, top: 40),
                child: Row(children: <Widget>[
                  new Container(
                      child: p.profile_image_url != null
                          ? CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  NetworkImage(p.profile_image_url),
                            )
                          : CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                  "https://i1.wp.com/frfars.org/wp-content/uploads/2018/12/place-holder-for-profile-picture-4.png?ssl=1"),
                            )),
                  new Container(
                      //username

                      child: FlatButton(
                    child: Text(
                      p.username,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: EdgeInsets.all(7.0),
                    onPressed: () async {
                      p.user_id == bloc.myAccount.id
                          ? u = bloc.myAccount
                          : u = await bloc.fetchUserAccount(p.user_id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen(u)),
                      );
                    },
                  )),
                  new Container(
                      padding: EdgeInsets.only(left: 180), child: IconButton(
                        icon: Icon(FontAwesomeIcons.ellipsisV),
                        iconSize: 30,
                        onPressed: () async{
                          u = await bloc.fetchUserAccount(p.user_id);
                          p.user_id == u.id
                          ?bloc.deletePost(p.id)
                          :print("Not your post cant delete");
                        },
                      ))
                ]),
              ),
              new Container(
                //image
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Image.network(p.image_url),
              ),
              new Container(
                //icons heart, comment, share
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(children: <Widget>[
                  p.liked
                      ? IconButton(
                          icon: Icon(
                            FontAwesomeIcons.solidHeart,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            bloc.toggle(p.id, false);
                            p.liked = !p.liked;
                            setState(() {});
                            p.likes_count--;
                          },
                        )
                      : IconButton(
                          icon: Icon(FontAwesomeIcons.heart),
                          onPressed: () {
                            bloc.toggle(p.id, true);
                            p.liked = !p.liked;
                            setState(() {});
                            p.likes_count++;
                          },
                        ),
                  Icon(FontAwesomeIcons.comment),
                  Spacer(flex: 1),
                  Icon(FontAwesomeIcons.paperPlane),
                  Spacer(flex: 20),
                ]),
              ),
              new Container(
                //like section
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("${p.likes_count} likes",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ]),
              ),
              //end of like section
              new Container(
                ///username and comment section
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text("${p.username}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      new Container(
                        padding: EdgeInsets.only(bottom: 20.0, left: 10.0),
                        child: Text(
                          p.caption,
                          softWrap: true,
                        ),
                      ),
                    ]),
                    
              ),
             
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFFAFAFA),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: IconButton(
                icon: Icon(Icons.home),
                iconSize: 40,
                color: Colors.black,
                onPressed: () {},
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: IconButton(
                icon: Icon(Icons.search),
                iconSize: 40,
                color: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => searchscreen()),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: IconButton(
                icon: Icon(FontAwesomeIcons.plusSquare),
                iconSize: 40,
                color: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FilePickerDemo()),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: IconButton(
                icon: Icon(FontAwesomeIcons.heart),
                iconSize: 40,
                color: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => activityScreen()),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: IconButton(
                icon: Icon(FontAwesomeIcons.user),
                iconSize: 40,
                color: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileScreen(bloc.myAccount)),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
