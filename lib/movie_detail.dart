import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_kobis/movie_api.dart';

class MovieDetail extends StatefulWidget {
  String movieCd;

  MovieDetail({super.key, required this.movieCd});

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  build(BuildContext context) {
    var movieApi = MovieApi();
    var movie = movieApi.searchDetail(moviecode: widget.movieCd);

    return Scaffold(
        appBar: AppBar(title: const Text('영화 상세 정보')),
        body: FutureBuilder(
            future: movie,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var movieData = snapshot.data;
                var movieInfo = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                          child: Center(
                            child: Text(movieData['movieNm'],
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '개봉일 : ${movieInfo['openDt']}',
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '영화 대표코드 : ${movieInfo['movieCd']}',
                                softWrap: true,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }

              //error가 발생하게 될 경우 반환하게 되는 부분
              else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Error: ${snapshot.error}', // 에러명을 텍스트에 뿌려줌
                    style: const TextStyle(fontSize: 15),
                  ),
                );
              }

              //해당 부분은 data를 아직 받아 오지 못했을 때 실행되는 부분
              else {
                return const Center(child: CircularProgressIndicator());
              } // CircularProgressIndicator : 로딩 에니메이션
            }));
  }
}
