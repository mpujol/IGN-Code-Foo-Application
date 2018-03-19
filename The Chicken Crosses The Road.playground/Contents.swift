// This is the code for required challenge #3
//


import Foundation

// Classes

struct Status {
    static let valid = "Valid"
    static let unknown = "Unknown"
    static let invalid = "Invalid"
    static let visited = "Visited"
    static let goal = "Goal"
    static let blocked = "Blocked"
}

struct Direction {
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
    //    //Debugging
    //    print(newLocation.status)
    
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
    
    //    // Debugging for visited cells
    //    for row in stride(from: temporaryGrid.count-1, through: 0, by: -1) {
    //        print(temporaryGrid[row])
    //    }
    
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
    }
        
    else {
        return Status.valid
    }
    
}

// Find a single path given a single specified starting point
func findValidPathsFor(startingPoint:Location, grid: [[String]]) -> Int {
    
    print("Evaluating Starting Point:(\(startingPoint.distanceFromLeft),\(startingPoint.distanceFromBottom))")
    
    //use the starting point as the beginning of the queue
    var queue = [startingPoint]
    var arrayOfValidLocationPaths = [Location]()
    var updatedGrid = grid
    
    
    //check to see if the current location is an obstacle
    if checkLocationStatus(location: startingPoint, grid: grid) == Status.goal {
        print("Staring Location not Valid")
        return 0
    }
        //revise the grid if the inital starting point contains an obsticle and it is on the left side of the grid
    else if checkLocationStatus(location: startingPoint, grid: grid) == Status.blocked && startingPoint.distanceFromLeft == 0 {
        updatedGrid[startingPoint.distanceFromBottom][startingPoint.distanceFromLeft] = "O"
        print("Updated Starting Position to Ignore Pothole")
    }

    printOutGrid(grid: updatedGrid)
   
    //loop through the grid till you find the goal
    
    while (queue.count > 0) { //Recursion Stack
        
        //remove the first item in the queue
        let currentLocation = queue.removeFirst()
        
        //        //Debugging for queue
        //        print("\(currentLocation.description) got popped off")
        //        for row in stride(from: grid.count-1, through: 0, by: -1) {
        //            print(grid[row])
        //        }
        
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
        
        //debugging for recursion stack
        //        for item in queue {
        //            print("Queue List:\(item.description)")
        //        }
    }
    for location in arrayOfValidLocationPaths {
        print("Valid Paths:\(location.path)")
    }
    
    if arrayOfValidLocationPaths.count == 0 {
        print("No Valid Paths")
    }
    
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
}

//Grid Generation

func createGrid(numberOfRows: Int, numberOfColumns:Int) -> [[String]] {
    
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
//
var sampleGrid: [[String]] = [["O","O","O","O"],
                              ["O","O","O","O"],
                              ["O","O","O","O"],
                              ["O","O","O","O"]]

// sample grid [columns][rows] starting from lower left
sampleGrid[1][0] = "X"
sampleGrid[3][1] = "X"
sampleGrid[2][2] = "X"
sampleGrid[3][3] = "X"


//////1.1 Single selected starting point
//let startingLocation = Location(distanceFromBottom: 3, distanceFromLeft: 2, status: Status.unknown)
//
//let testForSingleStartingPoint = findValidPathsFor(startingPoint: startingLocation, grid: sampleGrid)
//print("Total Number of Valid Paths for (\(startingLocation.distanceFromLeft),\(startingLocation.distanceFromBottom)): \(testForSingleStartingPoint)")

//////1.2 Random starting point
//let testForRandomStartingPoint = findValidPathsWithARandomStartingPoint(grid: sampleGrid)
//print(testForRandomStartingPoint)

////1.3 All starting points
//let testForAllStartingPoints = findValidPathsForAllStartingPoints(grid: sampleGrid)
//print(testForAllStartingPoints)


//The following uses the created functions to evaluate a random Grid
//
//let randomGrid = createGrid(numberOfRows: 4, numberOfColumns: 4)
//
// 2.1 Random Starting point
//let randomGridTestforRandomStartingPoint = findValidPathsWithARandomStartingPoint(grid: randomGrid)
//print(randomGridTestforRandomStartingPoint)
//
// 2.2 All starting points
//let randomGridTestfForAllStartingPoints = findValidPathsForAllStartingPoints(grid: randomGrid)
//print(randomGridTestfForAllStartingPoints)


