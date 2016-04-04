\name{importQualtricsSurvey}
\alias{importQualtricsSurvey}
\title{
importQualtricsSurvey
}
\description{
Imports a text file survey from R into Qualtrics.
}
\usage{
importQualtricsSurvey(username, token, format, surveyName, inputFormat, fileLocation)
}
\arguments{
  \item{username}{Your username from Qualtrics.  Defaults to 'username' from qualtricsAuth function (it has to be ran and loaded first).
}
  \item{token}{Your token from Qualtrics.  Defaults to 'token' from qualtricsAuth function (it has to be ran and loaded first).
}
  \item{format}{The format for importing the survey into Qualtrics. Possible values include: "XML", "JSON", or "JSONP"; "XML" is the default.
}
  \item{surveyName}{What you want your survey to be named within Qualtrics.
}
  \item{inputFormat}{The format of the file that you are importing. Possible values include: "TXT", "QSF", "DOC", or "MSQ"; "TXT" is going to be a common file type if you are creating "Advanced Format" surveys. Defaults to "TXT". 
}
  \item{fileLocation}{Where the text file is stored locally.
}
}
\details{You can find your username and token in your account settings. Alternatively, you can use the 'qualtricsAuth' function to store a file with your username and token.  
}
\value{

}
\references{
%% ~put references to the literature/web site here ~
}
\author{
Seth Berry
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{

### Not Run ###

# Establish qualtricsAuth file first #

qualtricsAuth("username", "token") # You must provide these strings from Qualtrics.

load("file/location/qualtricsAuthInfo.RData")

importQualtricsSurvey(surveyName = "yourSurveyName", 
                      fileLocation = "folder/location/yourSurveyName.txt")

# Without qualtricsAuth #
 
importQualtricsSurvey(username = "qualtricsUser@email.address#brand", 
                      token = "tokenString", format = "XML", 
                      surveyName = "yourSurveyName", inputFormat = "TXT", 
                      fileLocation = "folder/location/yourSurveyName.txt")

### End Not Run ###

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
