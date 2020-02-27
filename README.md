qualtricsR
================

Package Description
-------------------

The **qualtricsR** package is intended to offer the most up-to-date version of the Qualtrics REST API and provide easy to use functions for interacting with the API. Several of these functions are very similar to the work that Jason Bryer was doing. However, these functions have been updated and can better deal with different brand affiliations. In addition to functions for interacting with the API, there are a few addins that make creating Advanced Format .txt files much easier.

The goal with this package is to be able to create a survey without having to leave RStudio (it is important to note that you will need to go to Qualtrics to handle your logic, JS, etc.). I find the Qualtrics editor to be slow and I try to minimize copy and paste as much as possible. Creating surveys in RStudio offers massive time savings compared to clicking around in Qualtrics.

Unfortunately, Qualtrics does not just give away access to their API, so your account will need to have access to it. If you do not already have it, try to get your institution/organization to spring for it (just tell them how much more efficient you will be). I really cannot understate how much time a person can save by using the API (especially with the recent change to the "Insight Platform").

### Future Goals

My ultimate goal is to have as many API functions as possible; I am just starting out with the ones I frequently use. The [website](https://survey.qualtrics.com/WRAPI/ControlPanel/docs.php) for the control panel API has all of the functions. Personally, I would not have much use for some of them; therefore, I plan to focus my efforts on the *Panel Requests* and the *Survey Requests*.

In addition to creating more functions, I plan to create more addins. The [list](http://www.qualtrics.com/university/researchsuite/advanced-building/advanced-options-drop-down/import-and-export-surveys/#PreparingATXTFileInAdvancedFormatForImporting) of possible tags for the Advanced Format is not terribly long, so I will likely get something for all of them soon.

Installation
------------

If there is anything useful for you here, I would be thrilled if you can make some use of it. You will need the **devtools** package.

``` r
devtools::install_github('saberry/qualtricsR')
```

REST API Functions
------------------

This package contains a few functions for interacting with the Qualtrics REST API. The main point is to be able to create a survey and then get your data without ever needing to go into Qualtrics. There will be more functions added over time, but this is just a start.

### qualtricsAuth

This function stores an RData file (named *qualtricsAuthInfo*) that contains your username and token -- you will need to go into Qualtrics to grab this stuff.

``` r
qualtricsAuth("yourUserName@email.com#brand", "randomTokenCharacters")

# Check your account to verify that you have the correct username; you may or
# may not have a brand affiliation.
```

After running this function once, it will save the file into your project. You can then load the file, at which point you will have "username" and "token" available as objects within your environment.

### importQualtricsSurvey

This will import an Advanced Format .txt file into Qualtrics.

``` r
importQualtricsSurvey("username", "token", "surveyName", 
                      "survey/location/file.txt")
```

Here is a very brief example of an Advanced Format survey:

    [[AdvancedFormat]]

    [[Question:MC]]
    [[ID:multipleChoiceEx]]
    This is an example of a multiple choice question.
    [[Choices]]
    No
    Yes

    [[PageBreak]]

    [[Question:Matrix]]
    [[ID:matrixExample]]
    This is an example of a matrix question.
    [[Choices]]
    R
    Python
    SAS
    Stata
    [[Answers]]
    Lame
    Okay
    Awesome

### surveyNamesID

This function is a helpful precusor to the exportQualtricsData function. That function requires a survey ID and this function will generate a data frame of survey names and IDs.

``` r
surveyNamesID("username", "token")
```

### importQualtricsDataV3

This function will import data from Qualtrics into your session. It comes in as a data table from the data.table package.

``` r
dataTest <- importQualtricsDataV3(token = "yourAPIToken",
                                  dataCenter = "ca1", surveyID = "yourSurveyID")
```

### qualtricsSurveyWriter

This function takes a data frame and converts it to an Advanced Format text file for directly importing into Qualtrics. You can write the survey in a csv, Excel, or even a data frame directly. It needs to have a "question" column and a "responseOption" column (the "id" column is optional).

``` r
questions <- data.frame(question = c("I enjoy coding.",
                                    "To what extent do you hate or love R?", "Done?"),
                       responseOptions = c("No;Yes", 
                                           "Strongly hate;Hate;Neither;Love;Strongly love", 
                                           "No;Maybe;Yes"),
                       id = c("enjoyCode", "hateLoveR", "done"), 
                       stringsAsFactors = FALSE)


qualtricsSurveyWriter(completeSurveyDataFrame = questions, roSeparator = ";", 
             pageBreakEvery = 2)
```

RStudio Addins
--------------

In addition to regular functions, this package also contains addins that will make creating Advanced Format surveys much quicker. Be aware that addins are only available for recent RStudio versions (v0.99.878 or later). If we remember our goal of leaving RStudio as little as possible, then we need to make the .txt file formatting quicker. The text editor in RStudio is already fast, but this just makes it that much more efficient -- I give a big fist pump to automatically closing brackets and the like, even if it has ruined my ability to remember to close them in other editors. There are currently addins for the following: insert **page breaks**, insert **text entry questions**, insert **multiple choice questions**, and insert **matrix question**.

When you use an addin, something like the following will be inserted in your text file:

    [[Question:Matrix]]
    [[ID: ]]

    [[Choices]]

    [[Answers]]

All you need to do now is to fill in the information.


Group Work Functions
--------------------

Everything below will eventually move into its own package. For now, though, they live here in qualtricsR