exportQualtricsData = function (username, token, format, surveyID, dropExtra=FALSE) {
  url = paste("https://survey.qualtrics.com//WRAPI/ControlPanel/api.php?Version=2.4&Request=getLegacyResponseData",
              "&User=",username,
              "&Token=",token,
              "&Format=",format,
              "&SurveyID=",surveyID,
              "&ExportTags=1",
              sep="")
  
  url = gsub("[@]","%40",url)
  url = gsub("[#]","%23",url)
  
  exportQualtricsData = read.csv(url)
  exportQualtricsData = exportQualtricsData[-1, ]
  
  if (dropExtra==TRUE) {
    exportQualtricsData[ -c(1:10)]
  }
    else {exportQualtricsData}
}