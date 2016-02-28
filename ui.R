
library(shiny)

shinyUI(fluidPage(
  
  titlePanel(title="Making a Biological Buffer Using Potassium Phosphate"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      helpText("Please enter the volume in milliliters (mL):"),
      helpText("Use the up/down arrow keys or directly type in"),
      numericInput("vol", "What's the volume of your buffer (mL)?",
                   value=1000
      ),      
      
      helpText("Please select the concentration in mol/L (M):"),
      helpText("Use the mouse or left/right arrow keys on your keyboard"),
      sliderInput("conc", "What's the concentration of your buffer (0-1 M)?",
                  min=0, max=1, value=0.1, step=0.001
      ),
      
      actionButton("action", "Generate pH Table!"),
      
      helpText("Or calculate buffer composition for a single pH:"),     
      sliderInput("ph", "What pH do you want?", 
                  min=5.8, max=8, value=7, step=0.1
      ),
      
      radioButtons("stock", "Do you have 1 M stock solutions for both KH2PO4 and K2HPO4?",
                   choices=list("Yes", "No")
      )
      
    ),
    
    mainPanel(
      
      tabsetPanel(type="tab",
                  tabPanel(h3("Introduction"), 
                           h4("Biological reactions are sensitive to the acidity of the solution, which is
          scientifically measured by \"pH\" (negative log of hydrogen ion concentration). Phosphate buffer
      is widely used in biological experiments to maintain certain pH of the solution. A desired pH in the
      range of 5.8 - 8 can be achieved by mixing potassium phosphate monobasic (KH2PO4) and dibasic (K2HPO4)
       salts in proper ratios. This app helps you conveniently determine the amount of both
         salts, either in anhydrous form or in 1 M stock solutions, required to make your
         buffer solution."),
                           br(),
                           h3("Use Tab 2 - \"Single pH Buffer\" if you need to make a single pH buffer: "),
                           h4("Type in or select the desired volume (mL), concentration (M), pH of your buffer,
        and whether you have 1 M stock solutions. The results are shown instantaneously as inputs change."),
                           br(),
                           h3("Use Tab 3 - \"A Series of pH Buffers\" if you need to make a series of buffers
                             with different pH values:"),
                           h4("Type in or select the desired volume (mL) and concentration (M), and hit 
        \"Generate pH table!\". You need to have 1 M stock solutions of KH2PO4 and K2HPO4 ready to use this table.")                           
                  ),
                  
                  tabPanel(h3("Single pH Buffer"), 
                           h3(textOutput("single1")),
                           br(),
                           h3(textOutput("single2")),
                           br(),
                           h3(textOutput("single3"))
                  ),
                  
                  tabPanel(h3("A Series of pH Buffers"), 
                           h4("Click \"Generate pH Table\" to refresh."),
                           textOutput("multiple1"),
                           textOutput("multiple2"),
                           tableOutput("multiple3"))
      ),
      br(),
      h4("Powered by:", 
         tags$img(src='RStudio-Ball.png', heigth=60, width=60),
         align ="right"),
      h4("Developed by:", 
         tags$img(src='ZW.jpg', heigth=60, width=50),
         align="right"),
      h4("Source codes available on my Github repository:",
         tags$a(href="https://github.com/zweinstein/my1stShinyApp", "Click here!"))
      
      
      
    )
  )
)
)