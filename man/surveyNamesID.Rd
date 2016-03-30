\name{surveyNamesID}
\alias{surveyNamesID}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
surveyNamesID
}
\description{
Provides a list of survey names and IDs for using in other functions.
}
\usage{
surveyNamesID(username, token, format)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{username}{
%%     ~~Describe \code{username} here~~
}
  \item{token}{
%%     ~~Describe \code{token} here~~
}
  \item{format}{
%%     ~~Describe \code{format} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (username, token, format) 
{
    url = paste("https://survey.qualtrics.com//WRAPI/ControlPanel/api.php?Version=2.4&Request=getSurveys", 
        "&User=", username, "&Token=", token, "&Format=", format, 
        sep = "")
    url = gsub("[@]", "\%40", url)
    url = gsub("[#]", "\%23", url)
    surveynames = GET(url)
    xmlNames = xmlParse(surveynames)
    namesID = data.frame(ID = xpathSApply(xmlNames, "//SurveyID", 
        xmlValue), Name = xpathSApply(xmlNames, "//SurveyName", 
        xmlValue))
    print(namesID)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
