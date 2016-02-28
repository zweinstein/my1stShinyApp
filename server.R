library(shiny)

shinyServer(
  function(input, output){
    
    C <- reactive({ as.numeric(input$conc) }) # Buffer Total Concentration
    V <- reactive({ input$vol }) # Total Volume in mL  
    
          
    output$single1 <- renderText({
      paste("You want", input$vol, "mL of", input$conc, "M potassium phosphate buffer
            at the pH of", input$ph, ":")
      })
    
    output$single2 <- renderText({ 
      
      pKa <- 7.2 # 25 ˚C
      pH <- as.numeric(input$ph) 
      R = 10^(pH - pKa) # ratio between the base and acid concentrations
      
      Ca = ( C() / (R+1) ) # Acid concentration
      Cb = R * Ca # Base concentration
      
      Va = round(Ca * V(), digits = 3) # Volume of 1 M stock Acid (KH2PO4) required
      Vb = round(Cb * V(), digits = 3) # Volume of 1 M stock Base (K2HPO4) required
      
      if(input$stock == "Yes") {
        paste("1. Mix", Va, "mL of 1 M KH2PO4 solution and", 
              Vb, "mL of 1 M K2HPO4 solution;")
      } else {
        A = round(Va * 136.09 / 1000, digits = 3) # Weight of anhydrous Acid (KH2PO4)
        B = round(Vb * 174.18 / 1000, digits = 3) # Weight of anhydrous Base (K2HPO4)
        paste("1. You need", A, "grams of KH2PO4 and", B, "grams of K2HPO4;") 
      }      
      
      })
    
    output$single3 <- renderText({
      paste("2. Add deionized distilled water to make the final volume", V(), "mL.")
    })
    
    output$multiple1 <- renderText({
      input$action
      isolate({
      paste("You want", input$vol, "mL of", input$conc, "M potassium phosphate buffer
            in the pH range of 5.8 - 8:") })
    })
    
    output$multiple2 <- renderText({
      input$action      
      isolate({
      paste("Mix the 1 M stock solutions according to the table, and add deionized
            distilled water to make the final volume", V(), "mL.") })
    })
    
    output$multiple3 <- renderTable({ 
      input$action
      if(input$action==0)
        return()
      else
      isolate({
        pKa <- 7.2 # 25 ˚C
        pH <- seq(5.8, 8, 0.1) 
        R = 10^(pH - pKa) # ratio between the base and acid concentrations
        
        Ca = ( C() / (R+1) ) # Acid concentration
        Cb = R * Ca # Base concentration
        
        Va = round(Ca * V(), digits = 3) # Volume of 1 M stock Acid (KH2PO4) required
        Vb = round(Cb * V(), digits = 3) # Volume of 1 M stock Base (K2HPO4) required
        
        table <- cbind(pH, Va, Vb)
        colnames(table) <- c("pH", "1 M KH2PO4 Volume (mL)", "1 M K2HPO4 Volume (mL)")
        
        table }) # , digits = 6) 
      })
    
  }  
  )