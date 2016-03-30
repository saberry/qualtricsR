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
  \item{username}{Your username from Qualtrics.
}
  \item{token}{Your token from Qualtrics.
}
  \item{format}{The format for importing the survey into Qualtrics. Possible values include: "XML", "JSON", or "JSONP"; "XML" is generally acceptable for most circumstances.
}
  \item{surveyName}{What you want your survey to be named within Qualtrics.
}
  \item{inputFormat}{The format of the file that you are importing. Possible values include: "TXT", "QSF", "DOC", or "MSQ"; "TXT" is going to be a common file type if you are creating "Advanced Format" surveys.
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

importQualtricsSurvey("qualtricsUser@email.address#brand", "tokenString", "XML", 
                      "yourSurveyName", "TXT", "folder/location/yourSurveyName.txt")

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
