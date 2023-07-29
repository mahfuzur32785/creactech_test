import 'package:flutter/material.dart';
import 'package:tests/model/home_model.dart';
import 'package:tests/utils/custom_image.dart';

class HomeDetailsScreen extends StatefulWidget {
  const HomeDetailsScreen({super.key, required this.movie});
  final Movie movie;

  @override
  State<HomeDetailsScreen> createState() => _HomeDetailsScreenState();
}

class _HomeDetailsScreenState extends State<HomeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: double.infinity,
                    child: CustomImage(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      path: widget.movie.posterUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey.shade700,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 6),
                            child: Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: Colors.white,
                        ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      child: Container(
                    width: double.infinity,
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        color: Colors.white
                    ),
                  ),

                  bottom: -15,left: 0,right: 0,)
                ],
              ),
              Container(
                  padding: EdgeInsets.only(left: 16,right: 16,top: 16),
                  color:Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 36,
                        width: double.infinity,
                        // color: Colors.red,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Text(
                                widget.movie.genres[index],
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              alignment: Alignment.center,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                          itemCount: widget.movie.genres.length,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          widget.movie.title,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text("Year: ${widget.movie.year}"),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Director:",
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(widget.movie.director),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Actors:",
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(widget.movie.actors),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Plot:",
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(widget.movie.plot,),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
