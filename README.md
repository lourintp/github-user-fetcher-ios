# TOPi - Mobile Developer Test

## Goal
- To develop a mobile application able to display a table with the most starred repositories of a language in github. 
- The URL with the repos: https://api.github.com/search/repositories?q=language:Java&sort=stars&page=1
- If you are testing for an iOS position, you can use Swift and/or Objetive-C. For Android, use Java.

Reference layout:

![Alt text](https://dl.dropboxusercontent.com/s/wkabn63i7zp61t5/layout.png)

## Required
- The layout must work on any iPhone/Android in portrait mode
- JSON Mapping -> Object
- At least one unit test
- Create a search filter in the toolbar (using material design pattern on Android) which filter the list with any sub-string of the repository name or user name.
- Give the user the option to sort the list by: name, number of stars.

## Extra Points
- Image caching
- UI testing
- Use gitflow
- MVVM
- Android extra points: Constraint Layout, JAVA 8 lambda, Card View for list rows, dagger 2