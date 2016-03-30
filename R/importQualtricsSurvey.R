importQualtricsSurvey = function (username, token, format, surveyName, inputFormat, fileLocation) {
  url = paste("https://survey.qualtrics.com//WRAPI/ControlPanel/api.php?Version=2.4&Request=importSurvey",
              "&User=",username,
              "&Token=",token,
              "&Format=",format,
              "&Name=",surveyName,
              "&ImportFormat=",inputFormat,
              sep="")

  url = gsub("[@]","%40",url)
  
  url = gsub("[#]", "%23", url)
  POST(url, encode="multipart", body=upload_file(paste(fileLocation)))
}