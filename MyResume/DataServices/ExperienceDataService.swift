//
//  ExperienceDataService.swift
//  MyResume
//
//  Created by Chen Le on 30/03/2022.
//

import Foundation

class ExperienceDataService {
    
    @Published var exps: [Experience] = []
    @Published var details: Personal
    
    init() {
        exps = ExperienceDataService.experiences
        details = ExperienceDataService.personalDetails
    }
    
    static let personalDetails: Personal =
        Personal(
            firstName: "Chen Le",
            lastName: "Yong".uppercased(),
            email: "chenle.yong16@gmail.com",
            contactNumber: "+60125100366",
            personalImage: "personal",
            executiveSummary: "Strong communicator and presenter, proficient in identifying and solving problem. Highly adaptive in any environment. Eager and devoted to find challenges.",
            education: Experience(
                title: "Master of Mechanical Engineering",
                description: [
                    "First Class Honour - Dean's List Scholar",
                    "International Exchange Programme - UK Campus"
                ],
                type: .education,
                startDate: "Sep 2016",
                endDate: "Jul 2020",
                imageNames: [
                    "unm1",
                    "unm2",
                    "unm3"
                ],
                location: Location(
                    id: UUID(),
                    name: "University of Nottingham",
                    country: "Malaysia",
                    latitude: 2.945244785846978,
                    longitude: 101.87469085541107),
                link: "https://en.wikipedia.org/wiki/University_of_Nottingham_Malaysia"),
            language: [
                Language(name: "English", value: 10),
                Language(name: "Mandarin", value: 9),
                Language(name: "Malay", value: 8),
                Language(name: "Cantonese", value: 8)
            ],
            skills: [
                "SwiftUI",
                "Cloud Computing",
                "MS Words",
                "MS Excel",
                "MS Powerpoint"
            ],
            certificates: [
                "AWS Solution Architect",
                "ACA Cloud Computing",
                "Huawei Cloud HCIA"
            ]
        )
    
    static let experiences: [Experience] = [
        // WORKING
        Experience(
            title: "Solution Consultant",
            description: [
                "Underwent intensive 1-Year Global Graduate Trainee programme in Hong Kong HQ.",
                "Fulfilled customer requirements commercially and technically, proposed solutions accordingly using wide range of products, such as IEPL/IPLC, IP Transit, Cloud Services, IoT products etc."
            ],
            type: .work,
            startDate: "Aug 2020",
            endDate: "Present",
            imageNames: [
                "cmi1",
                "cmi2",
                "cmi3"
            ],
            location: Location(
                id: UUID(),
                name: "China Mobile International",
                country: "Malaysia",
                latitude: 2.9227822273455186,
                longitude: 101.66132276403583),
            link: "https://www.cmi.chinamobile.com"
        ),
        
        Experience(
            title: "Business Development Intern",
            description: [
                "Researched the healthcare issues in Malaysia and the UK to identify new leads and potential new markets.",
                "Devised and implemented new marketing and sales plan in a launch of new product “Healtopedia”.",
                "Developed relationships and communicated various offerings of the company to potential partners."
            ],
            type: .work,
            startDate: "Jul 2019",
            endDate: "Sep 2019",
            imageNames: [
                "gmg1",
                "gmg2",
                "gmg3"
            ],
            location: Location(
                id: UUID(),
                name: "George Medical Gateway",
                country: "Malaysia",
                latitude: 3.1321411923598084,
                longitude: 101.63128808157448),
            link: "https://www.linkedin.com/company/george-healthcare/about/"),
        
        Experience(
            title: "Classical Guitar Tutor",
            description: [
                "Conducted tutoring sessions and witnessed improvement in tutees’ competencies from examination results.",
                "Responded to issues raised by students or parents and resolved relevant matter through communications.",
            ],
            type: .work,
            startDate: "Jun 2014",
            endDate: "May 2018",
            imageNames: [
                
            ],
            location: Location(
                id: UUID(),
                name: "YC Music",
                country: "Malaysia",
                latitude: 3.2159633527508484,
                longitude: 101.64283087641759),
            link: "https://www.ycmusic.com.my/"),
        
        
        // PROJECT
        Experience(
            title: "Global Graduate Trainee",
            description: [
                "Exposed to wide range of practical and theoretical trainings.",
                "Immersed in diversified working environment.",
                "Improved knowledge of the company's operations. "
            ],
            type: .project,
            startDate: "Nov 2020",
            endDate: "Feb 2021",
            imageNames: [
                "ggt1",
                "ggt2"
            ],
            location: Location(
                id: UUID(),
                name: "China Mobile International HQ",
                country: "Hong Kong",
                latitude: 22.36152751454351,
                longitude: 114.13259440435598),
            link: "https://www.cmi.chinamobile.com/corporate-information/who-you-can-be#CMIers"),
        
        Experience(
            title: "Smart Group Project",
            description: [
                "Researched the background and situation of company’s collaboration inefficiency across sales offices.",
                "Successfully developed an internal platform, capable of capturing and presenting info to different sales offices to help expand the enterprise business market with APAC Chinese Clients.",
            ],
            type: .project,
            startDate: "Dec 2020",
            endDate: "Jun 2021",
            imageNames: [
                "sgp1",
                "sgp2"
            ],
            location: Location(
                id: UUID(),
                name: "China Mobile International HQ",
                country: "Hong Kong",
                latitude: 22.36152751454351,
                longitude: 114.13259440435598)
        ),
        
        Experience(
            title: "Annual Celebration Emcee",
            description: [
                "Hosted the Annual Celebration 2020 of China Mobile International.",
                "Celebrated the team accomplishments and validated their contributions to the company",
            ],
            type: .project,
            startDate: "Jan 2021",
            imageNames: [
                "emc1",
                "emc2",
                "emc3",
                "emc4"
            ],
            location: Location(
                id: UUID(),
                name: "China Mobile International HQ",
                country: "Hong Kong",
                latitude: 22.36152751454351,
                longitude: 114.13259440435598)
            ),
        
        Experience(
            title: "Health Talk Host",
            description: [
                "Organized and hosted a Health Talk regarding 'OBESITY & HEALTHY LIFESTYLE'",
                "Collaborated with ALPS Medical Centre to promote newly launched product 'HEALTOPEDIA'",
            ],
            type: .project,
            startDate: "Sep 2019",
            imageNames: [
                "hlt1",
                "hlt2",
                "hlt3"
            ],
            location: Location(
                id: UUID(),
                name: "Common Ground",
                country: "Malaysia",
                latitude: 3.118475397877693,
                longitude: 101.63569685946109),
            link: "https://www.healtopedia.com"),
        
        
        // EDUCATION
        Experience(
            title: "Master of Mechanical Engineering",
            description: [
                "First Class Honour - Dean's List Scholar",
                "International Exchange Programme - UK Campus"
            ],
            type: .education,
            startDate: "Sep 2016",
            endDate: "Jul 2020",
            imageNames: [
                "unm1"
            ],
            location: Location(
                id: UUID(),
                name: "University of Nottingham",
                country: "Malaysia",
                latitude: 2.945244785846978,
                longitude: 101.87469085541107),
            link: "https://en.wikipedia.org/wiki/University_of_Nottingham_Malaysia"),
        
        Experience(
            title: "UK Exchange Programme",
            description: [
                "Designed an efficient COMPACT COOLER which involved complex numerical analysis due to difficulties in manufacturing processes",
                "Team Lead of one of the performance teams in Malaysian Festival 2019 in Nottingham, UK."
            ],
            type: .education,
            startDate: "Sep 2018",
            endDate: "Jul 2019",
            imageNames: [
                "unuk1",
                "unuk2"
            ],
            location: Location(
                id: UUID(),
                name: "University of Nottingham",
                country: "United Kingdom",
                latitude: 52.93888270274447,
                longitude: -1.1980842438253136),
            link: "https://en.wikipedia.org/wiki/University_of_Nottingham"),
        
        Experience(
            title: "Cambridge A-Levels",
            description: [
                "Mathematics (A* - 97/100), Further Mathematics (A), Physics (A*), Chemistry (A*)",
                "Scholarship Recipient with outstanding and consistent academic results"
            ],
            type: .education,
            startDate: "Jan 2015",
            endDate: "Jun 2016",
            imageNames: [
                
            ],
            location: Location(
                id: UUID(),
                name: "Methodist College Kuala Lumpur",
                country: "Malaysia",
                latitude: 3.1314451643427437,
                longitude: 101.6901106995925),
            link: "https://en.wikipedia.org/wiki/Methodist_College_Kuala_Lumpur")
    ]
    
}
