# Project 1 - *Flicks*

**Flicks** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: 10 hours spent in total

## User Stories

The following **required** functionality is complete:

- [X] User can view a list of movies currently playing in theaters from The Movie Database.
- [X] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [X] User sees a loading state while waiting for the movies API.
- [X] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [X] User sees an error message when there's a networking error.
- [X] Movies are displayed using a CollectionView instead of a TableView.
- [X] User can search for a movie.
- [X] All images fade in as they are loading.
- [X] Customize the UI.

The following **additional** features are implemented:

- [X] Each video has a more info page
- [X] Percentage ratings with color changes
- [X] Displays lang
- [X] Allows for viewing of tableview and collection view modes
- [X] Using custom Segmented controller to switch between poster and table view
- [X] Put search bar into navigation bar 

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


# Project 2 - Flicks 2

Flicks2 is a movies app displaying box office and top rental DVDs using [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: 3 hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] User can view movie details by tapping on a cell.
- [X] User can select from a tab bar for either **Now Playing** or **Top Rated** movies.
- [X] Customize the selection effect of the cell.

The following **optional** features are implemented:

- [X] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [X] Customize the navigation bar. 

The following **additional** features are implemented:

- [X] Added a search bar into the navigation bar
- [X] Customized the UI and design
- [X] Added colored rating system to the main tableviewcontroller that changes based on percentage 



Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. 
2. 

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

![alt tag](https://raw.githubusercontent.com/mkausas/CS-490/master/MovieViewer/demo2.gif "Video Walkthrough")

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Learned about creating new views programatically including TabBarControllers and connecting them with NavigationControllers. Also, was the first time I used the AppDelegate in a project. 

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
