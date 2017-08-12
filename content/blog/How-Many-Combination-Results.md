---
title: "How Many Combination Results"
date: 2017-08-07
tags: ["Python", "Stack", "Iteration", "Recursion"]
draft: false
---

## How Many Combination Results
<br/>
#### Description
Given an array of numbers, put [+, -, *, /] randomly between every two numbers. Compute and list all possible results.

<br/>
#### My Thoughts
I think I can do it both iteratively and recursively. If I want to do it iteratively, then I need a stack or a queue. While I do it recursively, then I just have to push result into array when I finish computing last number. Let me explain what I have to do iteratively and recursively.

##### Iteration

1. Push first number into stack.
2. Loop index i from second number to last number:
	1. Pop the stack and compute it with ith number with operator [+, -, *, /].
	2. Push this value into temporary stack.
	3. Keep poping the stack until nothing left.
3. Move all elements from temporary stack into stack.
4. Keep looping until index i equals to last index.

##### Recursion

1. Boundary condition: after computing last number, push the computing result into array and return.
2. General condition: call recursive function with index + 1 and value = value [+, -, *, /] nums[index]

<br/>
#### Solution
##### Iteration
```
def combination(nums):
	results = []
	results.push([nums[0]])
	for index in range(1, len(nums)):
		tmpResults = []
		while (value = results.pop()):
			if (value + nums[index]) not in tmpResults:
				tmpResults.push(value + nums[index])
			if (value - nums[index]) not in tmpResults:
				tmpResults.push(value - nums[index])
			if (value * nums[index]) not in tmpResults:
				tmpResults.push(value * nums[index])
			if (value / nums[index]) not in tmpResults:
				tmpResults.push(value / nums[index])
		results = tmpResults
	return results
```

##### Recursion
```
def combination(nums):
	results = []

	def DFS(curIndex, value):
		if(curIndex == nums.length-1):
			if (value + nums[curIndex]) not in results:
				results.push(value + nums[curIndex])
			if (value - nums[curIndex]) not in results:
				results.push(value - nums[curIndex])
			if (value * nums[curIndex]) not in results:
				results.push(value * nums[curIndex])
			if (value / nums[curIndex]) not in results:
				results.push(value / nums[curIndex])
		else:
			DFS(curIndex + 1, value + nums[curIndex])
			DFS(curIndex + 1, value - nums[curIndex])
			DFS(curIndex + 1, value * nums[curIndex])
			DFS(curIndex + 1, value / nums[curIndex])

	DFS(1, nums[0])
	return results
```