import 'package:flutter/material.dart';
import 'package:instagram_clone/blocs/instagrambloc.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/screens/activity.dart';
import 'package:instagram_clone/screens/mainscreen.dart';
import 'package:instagram_clone/screens/searchscreen.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'addpost.dart';

class ProfileScreen extends StatefulWidget {
  User user;

  ProfileScreen(this.user);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String view = "grid";

  void changeView(String s) {
    view = s;
    print(view);
  }

  @override
  Widget build(BuildContext context) {
    InstagramBloc bloc = Provider.of<InstagramBloc>(context);
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        title:
            Text("${widget.user.email}", style: TextStyle(color: Colors.black)),
        backgroundColor: Color(0xFFFAFAFA),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ////////////
            new Container(
              //container for the first row
              //padding: EdgeInsets.symmetric(horizontal: 10.0, ),
              padding: EdgeInsets.only(left: 30, top: 40),
              child: Row(
                children: <Widget>[
                  new Container(
                      child: widget.user.profile_image_url != null
                          ? CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  NetworkImage(widget.user.profile_image_url),
                            )
                          : CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                  "https://i1.wp.com/frfars.org/wp-content/uploads/2018/12/place-holder-for-profile-picture-4.png?ssl=1"),
                            )),
                  new Container(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      "Posts        Followers        Following",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            new Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "${widget.user.bio}",
                textAlign: TextAlign.left,
              ),
            ),

            new Container(
              child: OutlineButton(
                padding: EdgeInsets.symmetric(horizontal: 150, vertical: 2),
                child: Text(
                  "Edit Profile",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onPressed: () {},
              ),
            ),

            new Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    child: IconButton(
                      icon: Icon(Icons.grid_on),
                      iconSize: 30,
                      onPressed: () {
                        changeView("grid");
                        setState(() {
                          
                        });
                      },
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    child: IconButton(
                      icon: Icon(Icons.list),
                      iconSize: 40,
                      onPressed: () {
                        changeView("list");
                        setState(() {
                          
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            view == "grid"
                ? Expanded(
                    child: GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(bloc.my_posts.length, (index) {
                      return Center(
                        child: Image.network(bloc.my_posts[index].image_url),
                      );
                    }),
                  ))
                : Expanded(
                    ///////////////////////////////
                    child: ListView.builder(
                        itemCount: bloc.my_posts.length,
                        itemBuilder: (_, i) {
                          Post p = bloc.my_posts[i];
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
                                              backgroundImage: NetworkImage(
                                                  p.profile_image_url),
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
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          padding: EdgeInsets.all(7.0),
                                          onPressed: () {}))
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
                                padding: EdgeInsets.only(
                                    top: 10.0, bottom: 10.0, left: 10.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text("${p.likes_count} likes",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
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
                                        child:
                                            Text("${p.username}  ${p.caption}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                )),
                                      ),
                                      /* new Container(
                        padding: EdgeInsets.only(bottom: 20.0, left: 10.0),
                        child: Text(
                          p.caption,
                          softWrap: true,
                        ),
                      ),*/
                                    ]),
                              ),
                            ],
                          );
                        }))
          ],
        ),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                },
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
