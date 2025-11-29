# server.R
server <- function(input, output) {
  
  # Create a REACTIVE filtered dataset based on user input
  filtered_data <- reactive({
    datamar %>%
      filter(ocean == input$select_ocean) %>%
      filter(mp_measurement >= input$min_mp) %>%
      drop_na(mp_measurement, lat_dg, long_dg)
  })
  
  # Render the interactive PLOTLY plot
  output$mp_plot_interactive <- renderPlotly({
    ggplotly(
      ggplot(filtered_data(), aes(x = long_dg, y = lat_dg, color = mp_measurement, 
                                  text = paste("Depth:", water_smp_depth_m, "m\nMP:", mp_measurement))) +
        geom_point(alpha = 0.6) +
        labs(title = paste("MP in the", input$select_ocean), color = "MP Measure") +
        theme_minimal(),
      tooltip = "text"
    )
  })
  
  # Render the summary table (requires the 'DT' package if you want a fancy table)
  # output$summary_table <- renderDataTable({
  #   filtered_data() %>% 
  #     select(date, ocean, lat_dg, long_dg, mp_measurement) %>%
  #     head(50) # Show only the first 50 rows for simplicity
  # })
}
