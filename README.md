# MyResume - Experience Showcase
> A simple app that created with Swift language to showcase my own experiences in details including Working, Project as well as some other interesting experiences!

## Table of contents
* [Objective](#objective)
* [Description](#description)
  - [Section 1 - Map Tab](#section-1---map-tab)
  - [Section 2 - List Tab](#section-2---list-tab)
  - [Section 3 - Personal Tab](#section-3---personal-tab)
* [Acknowledgement](#acknowledgement)
* [Contact](#contact)

## Objective
- Provide a platform for recruiters to have a better understanding of who I am.
- Better demonstration of my own experiences that cannot be fit into one page of Resume.
- More interactive UI to present compared to looking through a piece of paper.
- Allow recruiters to evaluate my coding skills.

## Description
<!-- Images Section -->
<img src="/Images/lightmode.png" width="20%"> <img src="/Images/darkmode.png" width="20%">

- This app is built using Xcode 13.2, and the iOS 15 is used.
- **Combine Framework** is used as well, mainly to get the latest update of list of experiences.
```
// Example:
$searchText
    .combineLatest(experienceDataService.$exps, $selectedType)
    .debounce(for: .seconds(0.8), scheduler: DispatchQueue.main)
    .map(filterAndSortExps)
    .sink { [weak self] returnedExps in
        self?.experiences = returnedExps
    }
    .store(in: &cancellables)
```
- It is separated into three big parts, which are Map Tab, List Tab, and Personal Tab. Kindly check the correspond sections below for further information.
- There are three main types of experiences that I have separated into, which are **WORK**, **PROJECT** and **EDUCATION**.
- The details that can be found includes title, location, time, descriptions, and photos.
- The experiences are all listed in the code. 

### Section 1 - Map Tab
This tab mainly consists of a map, preview stack of the experience selected, and a header text of the current selected experience.

<!-- Images Section -->
<img src="/Images/maptab1.png" width="20%"> <img src="/Images/maptab2.png" width="20%"> <img src="/Images/maptab3.png" width="20%">

- The header can be tapped to show the list of experiences. Once tapped, it will bring you to the tapped experience.
- There are few types that can be selected in order to sort the experience type, and it will reflect the whole view as well.
- As for the preview stack, there is a _Details_ button, it will present a _DetailView_ of the current experience.

### Section 2 - List Tab
This tab consists of all the experience cards, a search bar and filtering picker.

<!-- Images Section -->
<img src="/Images/listtab1.png" width="20%"> <img src="/Images/listtab2.png" width="20%"> <img src="/Images/listtab3.png" width="20%">

- The filtering picker helps sort the experience type accordingly.
- The search bar allows user to filter the list using **Title**, **Location** or **Country**.
- The experience cards can be tapped to show the _DetailView_ as well.

### Section 3 - Personal Tab
This tab simply displays the personal information, with some additional info such as skills, certificates and so on.

<!-- Images Section -->
<img src="/Images/personaltab1.png" width="20%"> <img src="/Images/personaltab2.png" width="20%">

- It has different sections like personal details, education, summary and others.

## Acknowledgement
This project is largely inspired by **Swiftful Thinking**, whereas the design of the first tab was from _SwiftUI Map App (Beginner Level)_. 
Please do check it out! [_Click Here_](https://www.youtube.com/playlist?list=PLwvDm4Vfkdpha5eVTjLM0eRlJ7-yDDwBk)

## Contact
Created by **CL-m15** - free free to contact me!
- Email: chenleyong.mac@gmail.com
