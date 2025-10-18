//
//  main.swift
//  lab1
//
//  Created by Baisal Kenesbek on 18.10.2025.
//


let firstName: String = "Baisal"
let lastName: String = "Kenesbek"
let birthYear: Int = 2004
let currentYear: Int = 2025
let age: Int = currentYear - birthYear
let isStudent: Bool = true
let height: Double = 1.80
let country: String = "Kazakhstan"
let favoriteFood: String = "🍣 Sushi"

// Step 2: Hobbies and Interests
let hobby: String = "🎮 Playing video games"
let numberOfHobbies: Int = 4
let favoriteNumber: Int = 7
let isHobbyCreative: Bool = false
let favoriteSport: String = "⚽ Football"
let favoriteMusic: String = "🎧 Lo-fi"

// Step 3: Future Goals (Bonus)
let futureGoals: String = "🚀 In the future, I want to create my own startup and travel the world."

// Step 4: Combine Everything into a Life Story
let lifeStory = """
My name is \(firstName) \(lastName). I am \(age) years old, born in \(birthYear), and currently living in \(country).
I am \(isStudent ? "currently a student" : "not a student"). My height is \(height)m.
My favorite food is \(favoriteFood).

My favorite hobby is \(hobby), which is \(isHobbyCreative ? "a creative hobby" : "not very creative").
I have \(numberOfHobbies) hobbies in total, and my favorite number is \(favoriteNumber).
I also enjoy \(favoriteSport) and listening to \(favoriteMusic).

\(futureGoals)
"""


print(lifeStory)
