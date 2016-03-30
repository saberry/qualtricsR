surveyNamesID = function (username, token, format) {
  url = paste("https://survey.qualtrics.com//WRAPI/ControlPanel/api.php?Version=2.4&Request=getSurveys",
              "&User=",username,
              "&Token=",token,
              "&Format=",format,
              sep="")
  
  url = gsub("[@]","%40",url)
  url = gsub("[#]","%23",url)
  
  surveynames = GET(url)
  
  xmlNames = xmlParse(surveynames)
  
  namesID = data.frame(ID = xpathSApply(xmlNames, "//SurveyID", xmlValue), 
                       Name = xpathSApply(xmlNames, "//SurveyName", xmlValue))
  
  print(namesID)
}