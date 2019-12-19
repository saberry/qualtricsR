#' Assigns students to teams with 0/1 programming.
#' 
#' @aliases groupMaker
#' @author Seth Berry
#' @description This function takes a vector of student names and creates groups.
#' @usage groupMaker(nameData, groupNumber, groupSizeMin, groupSizeMax)
#' @param nameData A vector of student names.
#' @param groupNumber How many groups you want.
#' @param groupSizeMin The minimum number of students per group.
#' @param groupSizeMax The maximum number of students per group.
#' @details The
#' @return This will return a data frame with students and team assignments.
#' @examples
#' \dontrun{
#' 
#' studentNames <- c("Thomas", "Dirk", "John", "Brian", "Jenny", "Michael", 
#' "Bill", "Martin", "Douglas", "Hadley")
#' 
#' groupMaker(nameData = studentNames, groupNumber = 3, 
#' groupSizeMin = 3, groupSizeMax = 4)
#' 
#' }
#' @importFrom dplyr filter
#' @importFrom dplyr left_join
#' @importFrom dplyr select
#' @importFrom dplyr arrange
#' @importFrom dplyr rename
#' @importFrom dplyr %>%
#' @importFrom ompr MILPModel
#' @importFrom ompr set_objective
#' @importFrom ompr add_constraint
#' @importFrom ompr solve_model
#' @importFrom ompr get_solution
#' @importFrom ompr sum_expr
#' @importFrom ompr.roi with_ROI
#' @import ROI.plugin.glpk
#' @export

groupMaker <- function(nameData, groupNumber, groupSizeMin, groupSizeMax) {
  
  n <- length(nameData)
  
  m <- groupNumber
  
  minSize <- rep.int(groupSizeMin, m)
  
  capacity <- rep.int(groupSizeMax, m)
  
  groupData <- data.frame(name = nameData, rowID = 1:n)
  
  studentTranspose <- matrix(1, ncol =  n)
  
  model <- MILPModel() %>%
    add_variable(x[i, j], i = 1:m, j = 1:n, type = "binary") %>%
    set_objective(sum_expr(studentTranspose[j] * x[i, j], i = 1:m, j = 1:n), sense = "max") %>%
    add_constraint(sum_expr(x[i, j], j = 1:n) <= capacity[i], i = 1:m) %>%
    add_constraint(sum_expr(x[i, j], j = 1:n) >= minSize[i], i = 1:m) %>%
    add_constraint(sum_expr(x[i, j], i = 1:m) == 1, j = 1:n)
  
  result <- solve_model(model, with_ROI(solver = "glpk", verbose = FALSE))
  
  matching <- result %>% 
    get_solution(x[i,j]) %>%
    filter(value > .9) %>% 
    left_join(., groupData, by = c("j" = "rowID")) %>% 
    select(i, name) %>% 
    arrange(i) %>% 
    rename(team = i)
  
  return(matching)
}
