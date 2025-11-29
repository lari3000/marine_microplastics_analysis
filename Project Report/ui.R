# ui.R
fluidPage(
  # Application title
  titlePanel("Microplastic Dashboard (MP_Dashboard_App)"),
  
  # Sidebar layout with controls (inputs)
  sidebarLayout(
    sidebarPanel(
      h4("Filter Data"),
      
      # Input: Selector for the Ocean/Region
      selectInput("select_ocean", 
                  label = "Choose an Ocean:",
                  choices = unique(datamar$ocean), # Uses your data to populate choices
                  selected = "Atlantic Ocean"),
      
      # Input: Slider for minimum MP Measurement
      sliderInput("min_mp",
                  label = "Minimum MP Measurement:",
                  min = min(datamar$mp_measurement, na.rm = TRUE),
                  max = max(datamar$mp_measurement, na.rm = TRUE),
                  value = 0,
                  step = 0.01)
    ),
    
    # Main panel for displaying outputs (plots)
    mainPanel(
      # Output: A plot showing the data
      plotlyOutput("mp_plot_interactive"),
      
      # Output: A table summary
      dataTableOutput("summary_table")
    )
  )
)