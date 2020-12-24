let text = Utility.readFile(name: "Day05")
let day = Day05(text: text)

Utility.evaluate {
    day.run02()
}
