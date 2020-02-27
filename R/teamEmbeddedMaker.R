#' Creates crossings for each group to upload into Qualtrics.
#' 
#' @aliases teamEmbeddedMaker
#' @author Seth Berry
#' @description This function takes a vector of student names and creates groups.
#' @usage teamEmbeddedMaker(teamAssignment)
#' @param teamAssignmentData A data frame with student names (called "name") and
#' teams (called "teams").
#' @details This is most useful for creating embedded data fields for Qualtrics. 
#' It is best to use the object returned from the groupMaker function.
#' @return This will return a data frame with the crossing of students for each
#' group.
#' @examples
#' \dontrun{
#' 
#' teamAssignment <- data.frame(name = c("Thomas", "Dirk", "John", "Brian", "Jenny", "Michael", 
#' "Bill", "Martin", "Douglas", "Hadley"), team = c(rep(1, 3), rep(2, 4), rep(3, 3)))
#' 
#' teamEmbeddedMaker(teamAssignment)
#' 
#' }
#' @importFrom dplyr mutate_at
#' @importFrom dplyr mutate
#' @importFrom dplyr lead
#' @importFrom magrittr %>%
#' @importFrom dplyr n
#' @importFrom tidyr pivot_wider
#' @importFrom data.table rbindlist
#' @export

teamEmbeddedMaker <- function(teamAssignmentData){
  
  teamAssignment <- teamAssignmentData
  
  teamLength <- max(teamAssignment$team)
  
  allMembers <- lapply(1:teamLength, function(x) {
    
    # browser()
    
    smallSample <- teamAssignment[teamAssignment$team == x, ]  
    
    smallSample <- mutate_at(smallSample, "name", as.character) %>% 
      mutate(personID = 1:n())
    
    teamLength <- nrow(smallSample)
    
    testVals <- 1:teamLength
    
    needs <- vector("list", length = teamLength)
    
    i <- 1
    
    while(i < (teamLength + 1)) {
      
      firstVal <- testVals[1]
      
      testVals <- dplyr::lead(testVals)
      
      testVals[teamLength] <- firstVal
      
      testVals <- testVals
      
      needs[[i]] <- as.vector(testVals)
      
      i <- i + 1
    }
    
    testDat <- pivot_wider(smallSample, id_cols = personID, values_from = name, 
                           names_from = personID, names_prefix = "member")
    
    testDims <- ncol(testDat)
    
    testDat[2:testDims, ] <- ""
    
    tmp <- lapply(1:ncol(testDat), function(j) {
      testDat[1, needs[[j]][1:ncol(testDat)]]
    })
    
    tmp <- rbindlist(tmp, use.names = FALSE)
    tmp[, "team"] = x
    return(tmp)
  })
  
  allMembers <- rbindlist(allMembers, fill = TRUE, use.names = TRUE)
  
  return(allMembers)
}