# MyResume - Experience Showcase
> A simple app that created with Swift language to showcase my own experiences in details including Working, Project as well as some other interesting experiences. This is a simple [_demo video_](https://www.youtube.com/watch?v=6_QWFacEjL4&t=8s) for your reference!

## Table of contents
* [Objective](#objective)
* [Deployment](#deployment)
  - [Pre-requisite](#pre-requisite)
  - [Setup](#setup)
  - [Modify](#modify)
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

## Deployment
#### Pre-requisite
1. Xcode version - **13.0 & above**
2. OS System - **iOS 15.0 & above**
3. Device - **iPhone**

----
#### Setup
1. Download the repo using **Download ZIP**, or clone it directly to your GitHub Desktop if you have one.
2. Open up the project using Xcode by clicking the **.xcodeproj** file.
3. Once the project is launched in Xcode, you can first choose your preferred iOS simulator device to run the app.
   - Go to Xcode menu bar, look for **Product**.
   - From the list, click **Destination**, you are able to choose your preferred device to run the simulation from there, for example: iPhone 13 Pro.
4. After choosing the destination, press **CMD+Shift+K** to clean build folder.
5. Once they are all done, press **CMD+R** to run the simulator, or click the play button at the top left corner of Xcode.

---
#### Modify
There are two different models created, which are _Personal_ and _Experience_. _Personal_ mainly consists of the personal details such as name, email, education and others, while _Experience_ contains the details of the experience.

1. Navigate to the file named _ExperienceDataService_ in the _DataService_ folder.
2. There is a static variable called **personalDetails**, which holds the personal details. 
   ```
   struct Personal {
        let firstName: String
        let lastName: String
        var fullName: String { firstName + ", " + lastName }
        let email: String
        let contactNumber: String
        let personalImage: String?
        var executiveSummary: String
        var education: Experience
        var language: [Language]
        var skills: [String]
        var certificates: [String]?
   }
   ```
   - You can modify it accordingly.
   - The display pic can be changed by replacing the image named personal with your own picture.
3. Another static variable called **experiences** contains all the experiences that I put in the app.
   ```
   struct Experience: Identifiable, Equatable, Comparable {
        var id = UUID()
        var title: String
        var description: [String]
        var type: ExperienceType
        var startDate: String // eg: Jan 2022
        var endDate: String?
        let imageNames: [String]
        var location: Location
        var link: String?
   }
   ```
   - You can edit by replacing them with your own experiences.
   - Some data is optional like _endDate_ or _link_, which means that you can ignore them.

## Description
<!-- Images Section -->
<img src="/Images/lightmode.png" width="20%"> <img src="/Images/darkmode.png" width="20%">

- This app is built using Xcode 13.2, and the iOS 15 is used.
- The architecture used in this app is **MVVM** (Model-View-ViewModel).
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
- There are three main types of experiences that I have separated into, which are **Work**, **Project** and **Education**.
- The details that can be found includes title, location, time, descriptions, and photos.
- The experiences are all listed in the code. 

---
#### Section 1 - Map Tab
This tab mainly consists of a map, preview stack of the experience selected, and a header text of the current selected experience.

<!-- Images Section -->
<img src="/Images/maptab1.png" width="20%"> <img src="/Images/maptab2.png" width="20%"> <img src="/Images/maptab3.png" width="20%">

- The header can be tapped to show the list of experiences. Once tapped, it will bring you to the tapped experience.
- There are few types that can be selected in order to sort the experience type, and it will reflect the whole view as well.
- As for the preview stack, there is a _Details_ button, it will present a _DetailView_ of the current experience.

---
#### Section 2 - List Tab
This tab consists of all the experience cards, a search bar and filtering picker.

<!-- Images Section -->
<img src="/Images/listtab1.png" width="20%"> <img src="/Images/listtab2.png" width="20%"> <img src="/Images/listtab3.png" width="20%">

- The filtering picker helps sort the experience type accordingly.
- The search bar allows user to filter the list using **Title**, **Location** or **Country**.
- The experience cards can be tapped to show the _DetailView_ as well.

---
#### Section 3 - Personal Tab
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
