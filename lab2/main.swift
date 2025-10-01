

import Foundation



// ----------------------------------------------------
// Problem 1: FizzBuzz
// ----------------------------------------------------
func fizzBuzz() {
    for i in 1...100 {
        if i % 3 == 0 && i % 5 == 0 {
            print("FizzBuzz")
        } else if i % 3 == 0 {
            print("Fizz")
        } else if i % 5 == 0 {
            print("Buzz")
        } else {
            print(i)
        }
    }
}

// ----------------------------------------------------
// Problem 2: Prime Numbers
// ----------------------------------------------------
func isPrime(_ number: Int) -> Bool {
    if number < 2 { return false }
    for i in 2..<number {
        if number % i == 0 {
            return false
        }
    }
    return true
}

func printPrimes() {
    for i in 1...100 {
        if isPrime(i) {
            print(i)
        }
    }
}

// ----------------------------------------------------
// Problem 3: Temperature Converter
// ----------------------------------------------------
func celsiusToFahrenheit(_ c: Double) -> Double { return c * 9/5 + 32 }
func celsiusToKelvin(_ c: Double) -> Double { return c + 273.15 }
func fahrenheitToCelsius(_ f: Double) -> Double { return (f - 32) * 5/9 }
func fahrenheitToKelvin(_ f: Double) -> Double { return (f - 32) * 5/9 + 273.15 }
func kelvinToCelsius(_ k: Double) -> Double { return k - 273.15 }
func kelvinToFahrenheit(_ k: Double) -> Double { return (k - 273.15) * 9/5 + 32 }

func convertTemperature(value: Double, unit: String) {
    switch unit.uppercased() {
    case "C":
        print("Celsius: \(value), Fahrenheit: \(celsiusToFahrenheit(value)), Kelvin: \(celsiusToKelvin(value))")
    case "F":
        print("Fahrenheit: \(value), Celsius: \(fahrenheitToCelsius(value)), Kelvin: \(fahrenheitToKelvin(value))")
    case "K":
        print("Kelvin: \(value), Celsius: \(kelvinToCelsius(value)), Fahrenheit: \(kelvinToFahrenheit(value))")
    default:
        print("Unknown unit")
    }
}

// ----------------------------------------------------
// Problem 4: Shopping List Manager
// ----------------------------------------------------
func shoppingListManager() {
    var shoppingList: [String] = []
    var running = true

    while running {
        print("""
        \nShopping List Menu:
        1. Add Item
        2. Remove Item
        3. Show List
        4. Exit
        """)
        if let choice = readLine() {
            switch choice {
            case "1":
                print("Enter item to add:")
                if let item = readLine() {
                    shoppingList.append(item)
                }
            case "2":
                print("Enter item to remove:")
                if let item = readLine(), let index = shoppingList.firstIndex(of: item) {
                    shoppingList.remove(at: index)
                } else {
                    print("Item not found.")
                }
            case "3":
                print("Shopping List: \(shoppingList)")
            case "4":
                running = false
            default:
                print("Invalid option")
            }
        }
    }
}

// ----------------------------------------------------
// Problem 5: Word Frequency Counter
// ----------------------------------------------------
func wordFrequency(sentence: String) {
    let cleaned = sentence.lowercased().components(separatedBy: CharacterSet.alphanumerics.inverted).filter { !$0.isEmpty }
    var freq: [String: Int] = [:]
    for word in cleaned {
        freq[word, default: 0] += 1
    }
    print(freq)
}

// ----------------------------------------------------
// Problem 6: Fibonacci Sequence
// ----------------------------------------------------
func fibonacci(_ n: Int) -> [Int] {
    if n <= 0 { return [] }
    if n == 1 { return [0] }
    var seq = [0, 1]
    while seq.count < n {
        seq.append(seq[seq.count - 1] + seq[seq.count - 2])
    }
    return seq
}

// ----------------------------------------------------
// Problem 7: Grade Calculator
// ----------------------------------------------------
func gradeCalculator(students: [String: Int]) {
    let scores = Array(students.values)
    let average = Double(scores.reduce(0, +)) / Double(scores.count)
    if let maxScore = scores.max(), let minScore = scores.min() {
        print("Average: \(average), Highest: \(maxScore), Lowest: \(minScore)")
    }

    for (name, score) in students {
        if Double(score) >= average {
            print("\(name): \(score) (above average)")
        } else {
            print("\(name): \(score) (below average)")
        }
    }
}

// ----------------------------------------------------
// Problem 8: Palindrome Checker
// ----------------------------------------------------
func isPalindrome(_ text: String) -> Bool {
    let cleaned = text.lowercased().filter { $0.isLetter }
    return cleaned == String(cleaned.reversed())
}

// ----------------------------------------------------
// Problem 9: Simple Calculator
// ----------------------------------------------------
func add(_ a: Double, _ b: Double) -> Double { a + b }
func subtract(_ a: Double, _ b: Double) -> Double { a - b }
func multiply(_ a: Double, _ b: Double) -> Double { a * b }
func divide(_ a: Double, _ b: Double) -> Double? {
    return b == 0 ? nil : a / b
}

func calculator() {
    var running = true
    while running {
        print("Enter first number:")
        guard let a = Double(readLine() ?? "") else { continue }
        print("Enter second number:")
        guard let b = Double(readLine() ?? "") else { continue }
        print("Choose operation (+ - * /) or q to quit:")
        if let op = readLine() {
            switch op {
            case "+":
                print("Result: \(add(a, b))")
            case "-":
                print("Result: \(subtract(a, b))")
            case "*":
                print("Result: \(multiply(a, b))")
            case "/":
                if let result = divide(a, b) {
                    print("Result: \(result)")
                } else {
                    print("Error: Division by zero")
                }
            case "q":
                running = false
            default:
                print("Invalid operation")
            }
        }
    }
}

// ----------------------------------------------------
// Problem 10: Unique Characters
// ----------------------------------------------------
func hasUniqueCharacters(_ text: String) -> Bool {
    var seen: Set<Character> = []
    for ch in text {
        if seen.contains(ch) {
            return false
        }
        seen.insert(ch)
    }
    return true
}

//fizzBuzz()
//printPrimes()
// convertTemperature(value: 100, unit: "C")
// shoppingListManager()
// wordFrequency(sentence: "Hello hello world, world world!")
// print(fibonacci(10))
// gradeCalculator(students: ["Alice": 85, "Bob": 70, "Charlie": 90])
// print(isPalindrome("A man a plan a canal Panama"))
// calculator()
// print(hasUniqueCharacters("Swift"))
// print(hasUniqueCharacters("Hello"))
