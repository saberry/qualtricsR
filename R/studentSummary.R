# testFile <- read.csv("C:/Users/sethb/Downloads/export(2).csv")
# 
# library(dplyr)
# 
# library(tidyr)
# 
# studentDataNames <- read.csv("C:/Users/sethb/Downloads/teamAssessmentRevised.csv", 
#                              stringsAsFactors = FALSE, nrows = 1)
# 
# studentData <- read.csv("C:/Users/sethb/Downloads/teamAssessmentRevised.csv", 
#                         stringsAsFactors = FALSE, skip = 1)
# 
# names(studentData) <- names(studentDataNames)
# 
# str(studentData)
# 
# studentData <- dplyr::select(studentData, member1:comments_4_6_TEXT, -Q8)


#' Creates an Advanced Format text file from csv.
#' 
#' @aliases studentSummary
#' @author Seth Berry
#' @description This function will summarize student scores from Qualtrics data.
#' @usage studentSummary(studentData)
#' @param completeSurveyDataFrame The complete data frame containing the survey. 
#' Can be created as a data frame or read in from a file. Should contain 
#' variables called "question" (contains the question text), "responseOptions" (
#' contains the response option for each question, separated by some delimiter), 
#' and optionally "id" (the ID used in Qualtrics).
#' @details Provides summary stats for individual students.
#' @return This function returns a data frame of student scores.
#' @examples
#' \dontrun{
#' questions = data.frame(question = c("I enjoy coding.",
#'                                     "To what extent do you hate or love R?", "Done?"),
#'                        responseOptions = c("No;Yes", 
#'                                            "Strongly hate;Hate;Neither;Love;Strongly love", 
#'                                            "No;Maybe;Yes"),
#'                        id = c("enjoyCode", "hateLoveR", "done"), 
#'                        stringsAsFactors = FALSE)
#' 
#' 
#' studentSummary(completeSurveyDataFrame = questions, roSeparator = ";", 
#'              pageBreakEvery = 2)
#' }
#' @importFrom dplyr select
#' @importFrom dplyr summarize
#' @importFrom dplyr group_by
#' @importFrom dplyr ungroup
#' @importFrom dplyr mutate_all
#' @importFrom dplyr distinct
#' @importFrom dplyr summarize_all
#' @importFrom tidyr pivot_longer
#' @importFrom tidyr pivot_wider
#' @importFrom data.table rbindlist
#' @export

studentSummary <- function(studentData){
  
  groupSize <- max(studentData$team)
  
  groupSequence <- 1:groupSize
  
  numericVariables <- lapply(groupSequence, function(x) {
    subSetted <- dplyr::select(studentData, ends_with(as.character(x)))
    
    subSetted$id <- 1:nrow(subSetted)
    
    contributionName <- paste("contribution_member", x, 
                              sep = "")
    
    overallName <- paste("overall_member", x, 
                         sep = "")
    
    pivotWiderNames <- paste("member", x, sep = "")
    
    pivot_longer(subSetted, 
                 cols = !!quo(contributionName):!!quo(overallName)) %>%  
      pivot_wider(names_from = !!quo(pivotWiderNames), values_from = value)
  })
  
  numericVariables <- data.table::rbindlist(numericVariables, fill = TRUE)  
  
  numericVariables$name <- gsub("_.*", "", numericVariables$name)
  
  numericOut <- pivot_longer(numericVariables, cols = 3:length(numericVariables), 
                             names_to = "student", names_repair = "minimal") %>%
    group_by(student, name) %>% 
    summarize(mean = mean(value, na.rm = TRUE)) %>% 
    pivot_wider(names_from = name, values_from = mean)
  
  textVariables <- lapply(groupSequence, function(x) {
    subSetted <- dplyr::select(studentData, matches(paste0("^", "member", x)),
                               ends_with(paste0(as.character(x), "_TEXT")))
    
    subSetted$id <- 1:nrow(subSetted)
    
    textName <- paste0("comments_4_", x, "_TEXT")
    
    pivotWiderNames <- paste("member", x, sep = "")
    
    pivot_longer(subSetted, 
                 cols = textName) %>%  
      pivot_wider(names_from = !!quo(pivotWiderNames), values_from = value)
  })
  
  textVariables <- data.table::rbindlist(textVariables, fill = TRUE)  
  
  textOut <- pivot_longer(textVariables, cols = 3:length(textVariables), 
                          names_to = "student", names_repair = "minimal") %>% 
    group_by(student, name) %>% 
    na.omit() %>% 
    pivot_wider(names_from = name, values_from = value) %>% 
    ungroup() %>%   
    mutate_all(~ifelse(. == "", NA, .)) %>% 
    dplyr::select(-id) %>% 
    dplyr::distinct() %>% 
    group_by(student) %>%  
    summarize_all(~gsub("NA", "", paste0(., collapse = "")))
  
  allData <- left_join(numericOut, textOut, by = "student")
  
  return(allData)
}

# studentResults <- studentSummary(6)
# 
# res <- dplyr::select(studentResults, student, overall) %>% 
#   ungroup() %>% 
#   arrange(student)