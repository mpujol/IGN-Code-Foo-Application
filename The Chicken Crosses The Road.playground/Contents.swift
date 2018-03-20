// The Chicken Crosses The Road
//
// Hi Team IGN,
//
// I hope the following code meets your requirments for challenge #3.
//
// General notes: the description for the cells in the grid follow the (row,column) format
//
// There are 2 major functions that will be used for the program. They are uncommented and should show some information in the console upon running the program.
// 1. (line 225) func createRandomGrid(numberOfRows: Int, numberOfColumns:Int) -> [[String]] - This creates a grid that can have a random number of "potholes" from 1 to the total amount of cells
// 2. (line 193) func findValidPathsWithARandomStartingPoint(grid:[[String]]) -> Int - This solves for the number of unique paths for a random valid starting point.
//
// (Bonus Functions)
// (Line 129) func findValidPathsFor(startingPoint:Location, grid: [[String]]) - This solves for a unique paths of a specified starting point.
// (Line 180) func findValidPathsForAllStartingPoints(grid: [[String]]) -> [String:Int] - This returns a dictionary of all starting points and their respective amount of valid paths.
//
// The function calls currently being printed to the console are made on lines 294 and 295
// I've included commented out code as well to go through the original sample & bonus functions.
//
// Edge cases:
// If the random grid doesn't contain any starting points, the function will state "No valid staring points" in the console and return a value of 0

import Foundation

// Classes & Constants

enum Status {
    static let valid = "Valid"
    static let unknown = "Unknown"
    static let invalid = "Invalid"
    static let visited = "Visited"
    static let goal = "Goal"
    static let blocked = "Blocked"
}

enum Direction {
    static let right = "Right"
    static let down = "Down"
    static let up = "Up"
}

class Location: NSObject {
    var distanceFromBottom:Int
    var distanceFromLeft:Int
    var path:String
    var status:String
    var locationOfVisitedCells: [[Int]]
    
    override var description: String {
        return "Current location:(\(distanceFromLeft),\(distanceFromBottom)); Path: \(path); Status: \(status); Visted:\(locationOfVisitedCells)"
    }
    
    init(distanceFromBottom: Int, distanceFromLeft:Int,path:String, status:String, locationOfVisitedCells: [[Int]]) {
        self.distanceFromBottom = distanceFromBottom
        self.distanceFromLeft = distanceFromLeft
        self.path = path
        self.status = status
        self.locationOfVisitedCells = locationOfVisitedCells
    }
    
    init(distanceFromBottom: Int, distanceFromLeft:Int, status:String) {
        self.distanceFromBottom = distanceFromBottom
        self.distanceFromLeft = distanceFromLeft
        self.path = "(\(distanceFromLeft),\(distanceFromBottom))"
        self.status = status
        self.locationOfVisitedCells = [[distanceFromLeft,distanceFromBottom]]
    }
}

//Pathfinding Functions

// Given a location move in a certain direction, evaluate whether it is a valid move, and return a new location if it is.
func exploreInDirection(currentLocation:Location, direction: String, grid: [[String]]) -> Location {
    
    //create a new location
    
    var newDistanceFromBottom = currentLocation.distanceFromBottom
    var newDistanceFromLeft = currentLocation.distanceFromLeft
    
    switch direction {
    case Direction.down:
        newDistanceFromBottom -= 1
    case Direction.right:
        newDistanceFromLeft += 1
    case Direction.up:
        newDistanceFromBottom += 1
    default:
        break
    }
    
    // Append the path with the new cell
    let newPath:String = currentLocation.path + "->(\(newDistanceFromLeft),\(newDistanceFromBottom))"
    let newStatus = Status.unknown
    let newLocation = Location(distanceFromBottom: newDistanceFromBottom, distanceFromLeft: newDistanceFromLeft, path: newPath, status: newStatus, locationOfVisitedCells: currentLocation.locationOfVisitedCells)
    
    //Evaluate the new location
    newLocation.status = checkLocationStatus(location: newLocation, grid: grid)
    
    if newLocation.status == Status.valid {
        newLocation.locationOfVisitedCells.append([newDistanceFromLeft,newDistanceFromBottom])
    }
    return newLocation
}

// Checks the status of a given location
func checkLocationStatus(location: Location, grid: [[String]]) -> String {
    let gridHeight = grid.count
    let gridWidth = grid[0].count
    var temporaryGrid = grid
    for cell in location.locationOfVisitedCells {
        temporaryGrid[cell[1]][cell[0]] = Status.visited
    }
    // check to make sure the current location isn't out of bounds
    if location.distanceFromBottom < 0 || location.distanceFromBottom > gridHeight - 1 || location.distanceFromLeft < 0 || location.distanceFromLeft > gridWidth - 1 {
        return Status.invalid
    }
        //Check to see if there is an obstacle in the way
    else if grid[location.distanceFromBottom][location.distanceFromLeft] == "X" {
        return Status.blocked
    }
        // check to see if it has reached the right side of the grid
    else if location.distanceFromLeft == gridWidth - 1 {
        return Status.goal
    }
        //Check to see if it has been visited previously
    else if temporaryGrid[location.distanceFromBottom][location.distanceFromLeft] == Status.visited {
        return Status.visited
    } else {
        return Status.valid
    }
}

// Find a single path given a single specified starting point
func findValidPathsFor(startingPoint:Location, grid: [[String]]) -> Int {
    
    print("Evaluating Starting Point:(\(startingPoint.distanceFromLeft),\(startingPoint.distanceFromBottom))")
    printOutGrid(grid: grid)
    
    //use the starting point as the beginning of the queue
    var queue = [startingPoint]
    var arrayOfValidLocationPaths = [Location]()
    
    //check to see if the current location is on the goal
    if checkLocationStatus(location: startingPoint, grid: grid) == Status.goal {
        print("Staring Location is on the goal. No Valid path")
        print("Total Number of Valid Paths for (\(startingPoint.distanceFromLeft),\(startingPoint.distanceFromBottom)): \(arrayOfValidLocationPaths.count)")
        return 0
    }
        //check to see if the current location is obstructed
    else if checkLocationStatus(location: startingPoint, grid: grid) == Status.blocked && startingPoint.distanceFromLeft == 0 {
        print("Starting Location is obstructed")
        print("Total Number of Valid Paths for (\(startingPoint.distanceFromLeft),\(startingPoint.distanceFromBottom)): \(arrayOfValidLocationPaths.count)")
        return 0
    }
    
    //loop through the grid till you find the goal
    while (queue.count > 0) { //Pops off first location in queue and explores valid locations. if found, adds to queue until goal is reached or no additional valid locations are found
        
        //remove the first item in the queue
        let currentLocation = queue.removeFirst()
        
        //Eplore in each valid direction Up, Right, & Down
        let directionArray = [Direction.up,Direction.right,Direction.down]
        
        for direction in directionArray {
            let newLocation = exploreInDirection(currentLocation: currentLocation, direction: direction, grid: grid)
            if newLocation.status == Status.goal {
                arrayOfValidLocationPaths.append(newLocation)
            } else if newLocation.status == Status.valid {
                queue.append(newLocation)
            }
        }
        
    }
    for location in arrayOfValidLocationPaths {
        print("Valid Paths:\(location.path)")
    }
    if arrayOfValidLocationPaths.count == 0 {
        print("No Valid Paths")
    }
    print("Total Number of Valid Paths for (\(startingPoint.distanceFromLeft),\(startingPoint.distanceFromBottom)): \(arrayOfValidLocationPaths.count)")
    return arrayOfValidLocationPaths.count
}

// Find all valid paths on a grid for all staring points (left side of the grid)
func findValidPathsForAllStartingPoints(grid: [[String]]) -> [String:Int] {
    
    let numberStartingPoints = grid.count
    var temporaryDictionary = [String:Int]()
    for columnIndex in 0..<numberStartingPoints {
        let currentStartingPoint = Location(distanceFromBottom: columnIndex, distanceFromLeft: 0, status: Status.unknown)
        let currentPathCount = findValidPathsFor(startingPoint: currentStartingPoint, grid: grid)
        temporaryDictionary["(\(currentStartingPoint.distanceFromLeft),\(currentStartingPoint.distanceFromBottom))"] = currentPathCount
    }
    return temporaryDictionary
}

// Find all valid paths on a grid for a single random valid starting point.
func findValidPathsWithARandomStartingPoint(grid:[[String]]) -> Int {
    
    var validStartingPointSelected:Bool = false
    // check to see if there is at least 1 valid starting point
    var numberOfValidStartingPoints = 0
    for  columnIndex in 0..<grid.count {
        if grid[columnIndex][0] == "O" {
            numberOfValidStartingPoints += 1
        }
    }
    if numberOfValidStartingPoints > 0 {
        while validStartingPointSelected == false {
            let randomStartingPoint = Int(arc4random_uniform(UInt32(grid.count)))
            if grid[randomStartingPoint][0] == "O" {
                // Solve!
                let currentStartingPoint = Location(distanceFromBottom: randomStartingPoint, distanceFromLeft: 0, status: Status.unknown)
                let numberOfValidPaths = findValidPathsFor(startingPoint: currentStartingPoint, grid: grid)
                // Update status
                validStartingPointSelected = true
                return numberOfValidPaths
            }
        }
    } else {
        printOutGrid(grid: grid)
        print("No Valid Starting Point")
        return 0
    }
    

}

//Grid Generation
func createRandomGrid(numberOfRows: Int, numberOfColumns:Int) -> [[String]] {
    var grid = [[String]]()
    for _ in 0..<numberOfColumns {
        var rowArray = [String]()
        for _ in 0..<numberOfRows {
            rowArray.append("O")
        }
        grid.append(rowArray)
    }
    let totalNumberOfCells = numberOfColumns * numberOfRows
    var amountOfObstacles = (arc4random_uniform(UInt32(totalNumberOfCells-1))+1) // This ensures that at least 1 pothole is included
    while amountOfObstacles > 0 {
        // assign a random cell with an "X" value
        let randomRow = Int(arc4random_uniform(UInt32(numberOfRows)))
        let randomColumn = Int(arc4random_uniform(UInt32(numberOfColumns)))
        let currentCell = grid[randomColumn][randomRow]
        if currentCell == "O" {
            grid[randomColumn][randomRow] = "X"
            amountOfObstacles -= 1
        }
    }
    return grid
}

func printOutGrid(grid: [[String]]) {
    for row in stride(from: grid.count-1, through: 0, by: -1) {
        print(grid[row])
    }
}

// Tests
// I'll have a group of 2 tests that use the sample date and the randomly generated data for the folloiwng functions

////The following uses the function to solve for the example highlighted in the application webpage
var sampleGrid: [[String]] = [["O","O","O","O"],
                              ["O","O","O","O"],
                              ["O","O","O","O"],
                              ["O","O","O","O"]]

// sample grid [columns][rows] starting from lower left
sampleGrid[1][0] = "X"
sampleGrid[3][1] = "X"
sampleGrid[2][2] = "X"
sampleGrid[3][3] = "X"


////1.1 Single selected starting point
//let testForSingleStartingPoint = findValidPathsFor(startingPoint: Location(distanceFromBottom: 3, distanceFromLeft: 0, status: Status.unknown), grid: sampleGrid)
//print(testForSingleStartingPoint)

////1.2 Random starting point
//let testForRandomStartingPoint = findValidPathsWithARandomStartingPoint(grid: sampleGrid)
//print(testForRandomStartingPoint)

////1.3 All starting points
//let testForAllStartingPoints = findValidPathsForAllStartingPoints(grid: sampleGrid)
//print(testForAllStartingPoints)


//The following uses the created functions to evaluate a random Grid

// 2.1 Random Starting point
let randomGridTestforRandomStartingPoint = findValidPathsWithARandomStartingPoint(grid: createRandomGrid(numberOfRows: 4, numberOfColumns: 4))
print(randomGridTestforRandomStartingPoint)

// 2.2 All starting points
//let randomGridTestfForAllStartingPoints = findValidPathsForAllStartingPoints(grid: createRandomGrid(numberOfRows: 4, numberOfColumns: 4))
//print(randomGridTestfForAllStartingPoints)


