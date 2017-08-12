---
title: "Trapping Rain Water"
date: 2017-08-07
tags: ["LeetCode", "Hard", "Python", "Pointer"]
draft: false
---

## Trapping Rain Water
###### LeetCode #42
<br/>
#### Description
Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it is able to trap after raining.

For example, <br/>
Given [0,1,0,2,1,0,1,3,2,1,2,1], return 6.<br/>

#### My Thoughts
I would like to do this problem with two pointers, one points to left wall and another to right wall. If I can find out left and right wall for every part that can trap water, then I can easily compute total water I can get.

Therefore, I need two helper functions, findRightWall and countWater. I'll explain them later.

In main function, I just have to do a while loop start from left pointer points to 0, and until it points to last index of given array. And there are three steps in while loop:

1. Find the right index which creates a water container with left index.  (with findRightWall function)
2. Compute how much water I can get and add to total water. (with countWater function)
3. Move left pointer to where right pointer is and keep looping.

```
def trap(self, height):
    self.water = 0
    leftWallIndex = 0
    rightWallIndex = 1

    while leftWallIndex < len(height)-1:
        rightWallIndex = findRightWall(leftWallIndex)
        countWater(leftWallIndex, rightWallIndex)
        leftWallIndex = rightWallIndex

    return self.water
```

For function countWater, we just have to run a for loop to calculate it.

For findRightWall, I thought about where should right wall be at first. And there are some points I get:

* There should be no other walls higher than both left and right wall between them.
* I have to find the right-most right wall everytime.

For example, if I get an array [5, 0, 3, 0, 4, 0, 3]. Then it is easy to find out that there are two containers (0, 4) and (4, 6). If I don't find the right-most right wall everytime, I may get (0, 2), (2, 4) and (4, 6) which meet first point but they are not the correct answer.

Then I have to think about how to do it:

1. Start right pointer from right-most index everytime.
2. If any wall between left and right wall is higher than left or right wall, then change right pointer to that index.
3. Keep finding new right pointer until there is no higher wall between left and right wall or until right pointer equal to left pointer + 1.
4. Return this new right pointer.

```
def findRightWall(leftWallIndex):
    rightWallIndex = len(height)-1
    while (rightWallIndex-1 > leftWallIndex):
        middleWallIndex = height[leftWallIndex+1:rightWallIndex].index(max(height[leftWallIndex+1:rightWallIndex])) 
        middleWallIndex = middleWallIndex + leftWallIndex + 1
        #print middleWall
        if (middleWallIndex) and (height[middleWallIndex] > height[leftWallIndex] or height[middleWallIndex] > height[rightWallIndex]):
            rightWallIndex = middleWallIndex
        else:
            break
    return rightWallIndex
```
<br/>

#### Solution
```
class Solution(object):
    def trap(self, height):
        """
        :type height: List[int]
        :rtype: int
        """
        self.water = 0
        leftWallIndex = 0
        rightWallIndex = 1
        
        def findRightWall(leftWallIndex):
            rightWallIndex = len(height)-1
            while (rightWallIndex-1 > leftWallIndex):
                middleWallIndex = height[leftWallIndex+1:rightWallIndex].index(max(height[leftWallIndex+1:rightWallIndex])) 
                middleWallIndex = middleWallIndex + leftWallIndex + 1
                #print middleWall
                if (middleWallIndex) and (height[middleWallIndex] > height[leftWallIndex] or height[middleWallIndex] > height[rightWallIndex]):
                    rightWallIndex = middleWallIndex
                else:
                    break
            return rightWallIndex
        
        def countWater(leftWallIndex, rightWallIndex):
            wallHeight = min(height[leftWallIndex], height[rightWallIndex])
            for index in range(leftWallIndex+1, rightWallIndex):
                self.water = self.water + wallHeight - height[index]
        
        while leftWallIndex < len(height)-1:
            rightWallIndex = findRightWall(leftWallIndex)
            #print(leftWall, rightWall)
            countWater(leftWallIndex, rightWallIndex)
            leftWallIndex = rightWallIndex
            
        return self.water
```