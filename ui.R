shinyUI(pageWithSidebar(
    headerPanel("K-means behaviour investigation."),
    sidebarPanel(
        numericInput('clusterNum', 'Number of clusters to use', 1, min = 1, max = 5, step = 1),
        radioButtons("xAxisName", "X-Axis column",
                           c("Sepal.Length",
                             "Sepal.Width",
                             "Petal.Length",
                             "Petal.Width")),
        radioButtons("yAxisName", "Y-Axis column",
                      c("Sepal.Length",
                        "Sepal.Width",
                        "Petal.Length",
                        "Petal.Width"),
                     selected = "Petal.Length"),
        numericInput('pointSize', 'Size of points', 4, min = 1, max = 10, step = 1),
        actionButton("reculcKMeans", "Recalculate K-Means")
    ),
    mainPanel(
        tabsetPanel(
            tabPanel("Documentation",
                     
                     h2("Purpose."),
                     p("This shiny application allowes to investigate how well the K-means algorithm works on the Iris dataset example."),
                     p("If you will try to use multiple clusters and will recalculate k-mean clusters again and again (by pressing a button) sooner or later you will see that sometimes positions of centers are totally different."),
                     
                     h2("Interface."),
                     p("Right on top of this text there are 2 tabs. Choose \"Plot\" to see the plot with results of cluster generation algorithm."),
                     p("On the left side of this page you will find controls which allow to you to experiment with K-mean algorithm."),
                     p("Namely, there are:"),
                    h4("Number of clusters to use"),
                     p("This is the number of clusters which will be used by the algorithm. Allowable values are: 1-5 with a step = 1."),
                    h4("X-Axis column and Y-Axis column:"),
                           p("These two controls allowes you to set the columns from the iris data set which you like the most. Fill free to chose any combination."),
                     h4("Size of points:"),
                                 p("Here you can specify the size of \"dots\" on the plot. Allowable values are: 1-10 with a step = 1."),
                       h4("Recalculate K-Means:"),
                                       p("This button allowes you to rerun K-means algorithm without changing current parameters to see if the plot will change."),
                    h2("Results."),
                    p("On the plot you will see the iris data with dots colored by cluster numbers and with shape specified by true type of the data point."),
                    p("Under the plot you will see a statistics of how much times you have pushed the button.")
            ),
            tabPanel("Plot", 
                     plotOutput("IrisDataPlot"),
                     p("Number of times you clicked a button:"),
                     textOutput("clickNum"))
        )
    )
))