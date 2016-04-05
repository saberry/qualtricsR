#' @export
getSurveyNamesID = function (username = username, token = token, format = "XML") {
  url = paste("https://survey.qualtrics.com//WRAPI/ControlPanel/api.php?Version=2.5&Request=getSurveys",
              "&User=", username,
              "&Token=", token,
              "&Format=", format,
              sep = "")
  
  url = gsub("[@]", "%40", url)
  url = gsub("[#]", "%23", url)
  
  surveynames = GET(url)
  
  xmlNames = xmlParse(surveynames)
  
  namesID = data.frame(ID = xpathSApply(xmlNames, "//SurveyID", xmlValue), 
                       Name = xpathSApply(xmlNames, "//SurveyName", xmlValue))
  
  print(namesID)
}