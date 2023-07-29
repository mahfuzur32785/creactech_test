import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tests/core/error/remote_name.dart';
import 'package:tests/screen/home/controller/home_controller_cubit.dart';
import 'package:tests/utils/custom_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeControllerCubit, HomeControllerState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state is HomeControllerLoading) {
            print("Loading0");
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is HomeControllerError) {
            print("Loading1");
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              ),
            );
          }
          if (state is HomeControllerLoaded) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
                leading: const Icon(Icons.menu),
                centerTitle: true,
                title: const Text(
                  "Movie Online",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage('https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8bWVufGVufDB8fDB8fHww&w=1000&q=80'),
                      backgroundColor: Color(0xFFD1DFC3),
                    ),
                  )
                ],
              ),
              body: Container(
                  padding: const EdgeInsets.all(15),
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
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected = index;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: selected == index
                                      ? Colors.black
                                      : Colors.white,
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Text(
                                  "${state.homeModel.genres[index]}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: selected == index
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                alignment: Alignment.center,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                          itemCount: state.homeModel.genres.length,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "4 ${state.homeModel.genres[selected]} movies",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RouteNames.homeDetailsPage,
                                        arguments:
                                            state.homeModel.movies[index]);
                                  },
                                  child: Container(
                                    height: 150,
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade300),
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: CustomImage(
                                            width: 100,
                                            // height: double.infinity,
                                            path: state.homeModel.movies[index]
                                                .posterUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.homeModel.movies[index]
                                                    .title,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                  "Year: ${state.homeModel.movies[index].year}"),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                  "Director: ${state.homeModel.movies[index].director}")
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                              itemCount: state.homeModel.movies.length))
                    ],
                  )),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
