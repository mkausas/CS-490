# Project 1 - *Flicks*

**Flicks** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: 5 hours spent in total

## User Stories

The following **required** functionality is complete:

- [X] User can view a list of movies currently playing in theaters from The Movie Database.
- [X] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [X] User sees a loading state while waiting for the movies API.
- [X] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [ ] User sees an error message when there's a networking error.
- [X] Movies are displayed using a CollectionView instead of a TableView.
- [X] User can search for a movie.
- [ ] All images fade in as they are loading.
- [X] Customize the UI.

The following **additional** features are implemented:

- [X] Each video has a more info page
- [X] Percentage ratings with color changes
- [X] Displays lang
- [X] Allows for viewing of tableview and collection view modes

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

![alt tag](https://raw.githubusercontent.com/mkausas/CS-490/master/MovieViewer/demo.gif "Video Walkthrough")

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Issues included using the KVN pods as they would not run in the main thread if I tried activating them in viewDidLoad, tabviewcontroller and navigationcontroller were not playing nicely together, and it was my first time using collectionviews. 

## License

Copyright [2016] [Marty Kausas]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
