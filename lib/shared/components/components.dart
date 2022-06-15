import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/modules/web_view/web_view_screen.dart';
import 'package:newsapp/shared/cubit/cubit.dart';

Widget defultFormField({
  required dynamic control,
  required dynamic inputType,
  required dynamic labelText,
  required dynamic prefixIcon,
  required dynamic validate,
  dynamic onChange,
  dynamic onTap,
  dynamic myFocusNode,
}) =>
    TextFormField(
      focusNode: myFocusNode,
      controller: control,
      keyboardType: inputType,
      onChanged: onChange,
      style: TextStyle(
        color: Colors.grey,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        prefixIcon: prefixIcon,
      ),
      onTap: onTap,
      validator: validate,
    );

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: 200.0,
              width: 400.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(
                      '${article['urlToImage'] ?? 'https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png'}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '${article['publishedAt']}',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            Text(
              '${article['title']}',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            // SizedBox(
            //   height: 20.0,
            // ),
            // Row(
            //   children: [
            //     RawMaterialButton(
            //       onPressed: () {
            //         NewsCubit.get(context)
            //             .shareContent(content: "${article['url']}");
            //       },
            //       fillColor: Colors.white,
            //       child: Icon(
            //         Icons.share,
            //         size: 25.0,
            //         color: Colors.deepOrange,
            //       ),
            //       padding: EdgeInsets.all(10.0),
            //       shape: CircleBorder(),
            //     )
            //   ],
            // ),
          ],
        ),
      ),
    );

Widget articleBuilder(list, BuildContext context) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticleItem(list[index], context),
          separatorBuilder: (context, index) => Container(
                color: Colors.grey[300],
                height: 1.0,
                width: double.infinity,
              ),
          itemCount: list.length),
      fallback: (context) => Center(child: CircularProgressIndicator()),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
