# 2018 IGN Code Foo Application
### Submitted by Michael Pujol

**Hello Team IGN!**

Thank you very much for taking the time to go through my application for the Code Foo program.

All information can be found in this repository except for my introduction, which I'll link below.

## 1. [Introduction](https://youtu.be/B0laZfZ08r4)
## 2. [The Eiffel Tower of Geomags](https://github.com/mpujol/IGN-Code-Foo-Application/blob/master/Geomags/The%20Eiffel%20Tower%20of%20Geomags%E2%84%A2.docx)
Sacrebleu! The Infinity War damaged a lot of worldwide monuments, including the Eiffel Tower. For some unknown reason (to be revealed in Infinity War 2), all we have left for building materials are Geomags™. The country of France has tasked you with building a new Eiffel Tower with Geomags™. About how many Geomags™ would you need? How would you build it? Describe each step in your thought process.

## 3. [The Chicken Crosses the Road](https://github.com/mpujol/IGN-Code-Foo-Application/blob/master/The%20Chicken%20Crosses%20The%20Road.playground/Contents.swift)
Henny Penny, the chicken, wants to cross the road to go see his favorite historical documentary, Chicken Little. Although, the road often has potholes created by falling sky pieces. Chicken City doesn’t have enough corn in the budget to fix all the potholes, so Henny needs to be careful not to trip when crossing.

Create a program that will count how many paths Henny can take to cross the road with these rules:

A road is defined as a 4 x 4 Coordinate Grid
Any coordinate on the grid can contain a pothole
The grid should have at least one pothole
Henny randomly starts on a coordinate of the Zero Y-edge of the Coordinate Grid — so the left side [0]∪[0, 3]
The starting coordinate cannot have a pothole
Henny can only move right (+X), down (-Y), and up (+Y). Henny cannot move left (-X) or diagonally
Henny cannot backtrack to a coordinate that was already used
Henny cannot travel through a pothole, and must go around
A path is complete once the right side is reached [3]∪[0, 3]
Henny might not be able to reach the other side (no ticket refunds)
Solve for at least one randomly generated starting point, you do not need to solve for all starting positions
Display AT LEAST the grid, the valid paths, and the final answer.

>Explain how you implemented the solution. Does your solution work with larger grids?

*Absolutely! You have full controll of the grid size. I'll go over my approach after a few notes*

I've included some additional information & bonus functions in the playground file.
You should be able to the following:
- generate a grid by specifying number of row an columns
- solve for the number of paths with a random starting point in a given grid.
- solve for the number of paths with a specific starting point in a given grid. 
- solve for the number of paths with all starting points (left most coordinates) in a given grid

**My Approach:**

The general breakdown of finding a path is as follows:
1. (initial check) Evaluate the current location to see if it's valid (i.e. not a goal/obstacle)
2. Move up, left or right and evaluate the next location.
3. Evaluate a potential move and add that location to the queue.
4. Get the next item in the queue and repeat the process from step 2. 
5. If the goal is met add in that location object to an array of valid paths.
6. Once all moves are evaluated. End with a count of valid paths (if any).

**Specifics**

*Location Object* - Stores current path & Status which prevents an infinite loop of going up and down.

*Queue* - Array that acts as a To-Do list by starting with the initial position which would be pulled off and evaluated. Once evaluated valid moves would then be added to the queue. process continues till goal is reached or no valid locations are found. 

>Line 157 while (queue.count > 0) { //Pops off first location in queue and explores valid locations. if found, adds to queue until goal is reached or no additional valid locations are found

## 4. [Apps](https://github.com/mpujol/IGN-Code-Foo-Application/tree/master/IGN%20Code%20Foo%202018%20-%20App)
Build a native app (iOS or Android) that displays the content and matches this design as close as possible (don’t worry about the icons). Each item should open a webview for the corresponding content when tapped, except comments.

>Add further features or user interactions you think would make sense. Defend your proposals.

This was just fun. The additional features would be more on the actual code but these features are worth mentioning.
- UIRefreshControl for the collectionView
- Added the custom UI to mimic the IGN App
- API Service File
  - Loading the number of comments function (I noticed the IGN app wasn't pulling comments which is why I mentioned it here)

Overall this was my first venture into creating an app without the use of a storyboard. My understanding is that this approach would make it easier for collaboration & version control.


## 5. Some Stats

>How did you hear about this application?

A friend of mine had applied for your 2016 program. He knew I developed on iOS as a hobby and strived to turn it into a career, so he sent me a link. 

## 6. Bonus Round!

Apologies.. I don't have anything to add here due to time contraints. I did want to highlight the APP portion of the application since it is a good representation of my ability to create assets as well as develop. 

That's about everything. Thanks again for going through everything I've submitted and I do hope to hear back form you guys.

Hope you have a great day! :+1:

Regards,

Mike


