import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter_truyenfull/apiResponse/Category.dart';
import 'package:flutter_truyenfull/apiResponse/Chapter.dart';
import 'package:flutter_truyenfull/apiResponse/ChapterDetails.dart';
import 'package:flutter_truyenfull/apiResponse/Comic.dart';
import 'package:flutter_truyenfull/apiResponse/ComicDetails.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';

part 'ApiService.g.dart';

const String baseUrl = "https://truyen-clone.getdata.one/";

@RestApi(baseUrl: baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  static ApiService create() {
    final dio = Dio();

    if (!foundation.kIsWeb) {
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }

    dio.options.connectTimeout = const Duration(seconds: 60);
    dio.interceptors.add(PrettyDioLogger());

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioError dioError, ErrorInterceptorHandler handler) => {
          if (dioError.response != null && dioError.response?.statusCode != 200)
            {
              print("Dio Error: ${dioError.response!.statusCode}"),
            },
        },
      ),
    );

    return ApiService(
      dio,
      baseUrl: baseUrl,
    );
  }

  // Get comic by category
  @GET("/category/id/{category_id}/story?page={page}&limit=10")
  Future<List<Comic>> getComicsByCategory(
    @Path("category_id") int id,
    @Path("page") int page,
  );

  // Get  category
  @GET("/category")
  Future<List<Category>> getCategory();

  // Get comic by id
  @GET("/story/id/{comic_id}")
  Future<ComicDetails> getComicDetailsById(
    @Path("comic_id") int id,
  );

  // Get chapters of comic
  @GET("/story/{slug}/chapters")
  Future<List<Chapter>> getChaptersOfComic(
    @Path("slug") String slug,
  );

  // Get chapter details
  @GET("/chapter/id/{chapter_id}")
  Future<ChapterDetails> getChapterDetails(
    @Path("chapter_id") int id,
  );
}

// flutter packages pub run build_runner build --delete-conflicting-outputs
