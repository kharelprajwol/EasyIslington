// import 'package:flutter/material.dart';
// import '../models/post.dart';
// import '../widgets/post_list.dart';

// class DiscussionScreen extends StatelessWidget {
//   final List<Post> posts;

//   DiscussionScreen({required this.posts});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Posts'),
//       ),
//       body: PostList(posts: posts),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ForumScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forum'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Recent Posts',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        'MSQL not working',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 8.0),
                          Text(
                            'Author: Prajwol Kharel',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            'Date: 2022-02-25',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => PostScreen(),
                        //   ),
                        // );
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              child: Text('Create Post'),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => CreatePostScreen(),
                //   ),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
