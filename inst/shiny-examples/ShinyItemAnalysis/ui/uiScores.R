uiSummary <-
  navbarMenu(
    "Scores",
    # * TOTAL SCORES ####
    tabPanel("Total scores",
      value = "tot_scores",
      h3("Total scores"),
      p("Total score, also known as raw score or sum score, is the easiest measure of latent traits being measured.
                      The total score is calculated as the sum of the item scores.
                      In binary correct/false items, the total score corresponds to the total number of correct answers."),
      h4("Summary table"),
      p(
        "The table below summarizes basic descriptive statistics for the total scores including the number of respondents \\(n\\),
                        minimum and maximum,", htmlOutput("totalscores_tooltip_mean", inline = TRUE), "median,",
        htmlOutput("totalscores_tooltip_sd", inline = TRUE), "\\(\\textrm{SD}\\), ",
        htmlOutput("totalscores_tooltip_skewness", inline = TRUE), "and",
        htmlOutput("totalscores_tooltip_kurtosis", inline = TRUE),
        "The skewness for normally distributed scores is near the value of 0 and the kurtosis is near the value of 3. "
      ),
      tableOutput("totalscores_table"),
      h4("Histogram of total score"),
      fluidPage(div(
        class = "input-slider",
        sliderInput(
          inputId = "slider_totalscores_histogram",
          label = "Cut-score",
          min = 0,
          max = 10,
          value = 1,
          step = 1
        )
      )),
      p("For a selected cut-score, the blue part of the histogram shows respondents with a total score
                        above the cut-score, the grey column shows respondents with a total score equal
                        to the cut-score and the red part of the histogram shows respondents below the cut-score."),
      plotlyOutput("totalscores_histogram"),
      downloadButton(outputId = "DB_totalscores_histogram", label = "Download figure"),
      br(),
      br(),
      h4("Selected R code"),
      div(code(HTML("library(ggplot2)<br>library(psych)<br>library(ShinyItemAnalysis)<br><br>#&nbsp;loading&nbsp;data<br>data(GMAT,&nbsp;package&nbsp;=&nbsp;\"difNLR\")<br>data&nbsp;<-&nbsp;GMAT[,&nbsp;1:20]<br><br>#&nbsp;total&nbsp;score&nbsp;calculation<br>score&nbsp;<-&nbsp;rowSums(data)<br><br>#&nbsp;summary&nbsp;of&nbsp;total&nbsp;score<br>tab&nbsp;<-&nbsp;describe(score)[,&nbsp;c(\"n\",&nbsp;\"min\",&nbsp;\"max\",&nbsp;\"mean\",&nbsp;\"median\",&nbsp;\"sd\",&nbsp;\"skew\",&nbsp;\"kurtosis\")]<br>tab$kurtosis&nbsp;<-&nbsp;tab$kurtosis&nbsp;+&nbsp;3<br>tab<br><br>#&nbsp;colors&nbsp;by&nbsp;cut-score<br>cut&nbsp;<-&nbsp;median(score)&nbsp;#&nbsp;cut-score<br>color&nbsp;<-&nbsp;c(rep(\"red\",&nbsp;cut&nbsp;-&nbsp;min(score)),&nbsp;\"gray\",&nbsp;rep(\"blue\",&nbsp;max(score)&nbsp;-&nbsp;cut))<br>df&nbsp;<-&nbsp;data.frame(score)<br><br>#&nbsp;histogram<br>ggplot(df,&nbsp;aes(score))&nbsp;+<br>&nbsp;&nbsp;geom_histogram(binwidth&nbsp;=&nbsp;1,&nbsp;fill&nbsp;=&nbsp;color,&nbsp;col&nbsp;=&nbsp;\"black\")&nbsp;+<br>&nbsp;&nbsp;xlab(\"Total&nbsp;score\")&nbsp;+<br>&nbsp;&nbsp;ylab(\"Number&nbsp;of&nbsp;respondents\")&nbsp;+<br>&nbsp;&nbsp;theme_app()<br>"))),
      br()
    ),
    # * STANDARD SCORES ####
    tabPanel("Standard scores",
      value = "stan_scores",
      h3("Standard scores"),
      withMathJax(p(
        strong("Total score"), "is calculated as the ", uiOutput("standardscores_tooltip_total", inline = TRUE), br(),
        strong("Percentile"), "indicates the value below which a percentage of observations falls, e.g., an individual
                        score at the 80th percentile means that the individual score is the same or higher than the
                        scores of 80% of all respondents. ", br(),
        strong("Success rate"), "is the percentage of scores obtained, e.g., if the maximum points of test is equal to
                        20, minimum is 0, and individual score is 12 then success rate is \\(12 / 20 = 0.6\\), i.e., 60%.", br(),
        "The ", strong("Z-score"), ", also known as the standardized score is", uiOutput("standardscores_tooltip_zscore", inline = TRUE),
        "with a mean of 0 and and a standard deviation of 1. ", br(),
        "The ", strong("T-score"), "is ", uiOutput("standardscores_tooltip_tscore", inline = TRUE), " with a mean of 50 and standard
                        deviation of 10. "
      )),
      br(),
      h4("Table by score"),
      tableOutput("standardscores_table"),
      br(),
      downloadButton(
        outputId = "DB_standardscores_table",
        label = "Download table"
      ),
      br(),
      br(),
      h4("Selected R code"),
      div(code(HTML("#&nbsp;loading&nbsp;data<br>data(GMAT,&nbsp;package&nbsp;=&nbsp;\"difNLR\")<br>data&nbsp;<-&nbsp;GMAT[,&nbsp;1:20]<br><br>#&nbsp;scores&nbsp;calculations&nbsp;(unique&nbsp;values)<br>score&nbsp;<-&nbsp;rowSums(data)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#&nbsp;Total&nbsp;score<br>tosc&nbsp;<-&nbsp;sort(unique(score))&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#&nbsp;Levels&nbsp;of&nbsp;total&nbsp;score<br>perc&nbsp;<-&nbsp;ecdf(score)(tosc)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#&nbsp;Percentiles<br>sura&nbsp;<-&nbsp;100&nbsp;*&nbsp;(tosc&nbsp;/&nbsp;max(score))&nbsp;&nbsp;&nbsp;&nbsp;#&nbsp;Success&nbsp;rate<br>zsco&nbsp;<-&nbsp;sort(unique(scale(score)))&nbsp;&nbsp;&nbsp;#&nbsp;Z-score<br>tsco&nbsp;<-&nbsp;50&nbsp;+&nbsp;10&nbsp;*&nbsp;zsco&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#&nbsp;T-score<br><br>cbind(tosc,&nbsp;perc,&nbsp;sura,&nbsp;zsco,&nbsp;tsco)"))),
      br()
    )
  )
