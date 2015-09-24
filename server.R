library(shiny)
library(ggplot2)

data("iris")



shinyServer(
    function(input, output) {
        
        currentClusterNum = -10
        currentNumberButtonPushed = 0
        firstStart = TRUE
        
        output$clickNum = renderText({
            input$reculcKMeans
        })
        
        output$IrisDataPlot = renderPlot({
            if (input$clusterNum != currentClusterNum 
                || input$reculcKMeans != currentNumberButtonPushed
                || firstStart) {
                km = kmeans(iris[, 1:4], centers = input$clusterNum)
                clusteredIris = cbind(iris, factor(km$cluster))
                names(clusteredIris)[6] = "ClusterNumber"
                
                rowNum = dim(km$centers)[1]
                clusterCenters = data.frame(cbind(km$centers, num = 1:rowNum))
                clusterCenters$num = factor(clusterCenters$num)
                
                currentClusterNum = input$clusterNum
                currentNumberButtonPushed = input$reculcKMeans
                
                firstStart = FALSE
            }
            ggplot() +
                geom_point(data = clusteredIris,
                           aes_string(x = input$xAxisName, y = input$yAxisName, color = "ClusterNumber", shape = "Species"),
                           size = input$pointSize) +
                scale_shape_manual(name = "Species", breaks = c("setosa", "versicolor", "virginica"), values = c(1, 2, 3)) +
                geom_point(data = clusterCenters, 
                           aes_string(x = input$xAxisName, y = input$yAxisName, color = "num"),
                           shape = 15, 
                           size = input$pointSize * 1.3)
        })
    }
)