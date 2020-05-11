
library(shiny)
library(shinydashboard)
library(rsconnect)




ui <- shinyUI(
  dashboardPage(skin = "blue",
    dashboardHeader(title = "HR Dataset Analysis"),
                dashboardSidebar(sidebarMenu(menuItem("HR Analysis", tabName = "HR", 
                                                      menuSubItem("Managers", tabName = "Manager", icon = icon('briefcase')), 
                                                      menuSubItem("Department", tabName = "Department", icon = icon('chart-bar')),
                                                      menuSubItem("Pay-Rate", tabName = "PayRate", icon = icon('dollar-sign')),
                                                      menuSubItem("Age", tabName = "Age", icon = icon('birthday-cake'))
                                                       
                                                      ))),
    dashboardBody(
      tags$head(
        tags$style(
          HTML(
            '.main-header .logo {
                                font-family: "Century Gothic", Century, "Century Gothic", Century;
                                font-weight: bold;
                                font-size: 17px;
                                                    }'
          )
        )
      ),
            
      tabItems(
       
        
        tabItem(
          tabName = "Manager", h2("Manager Analysis"),
                fluidRow(box(
                    h3('Pick a Manager to see how their employees performed'),
                    selectizeInput(inputId = 'ManagerA',
                                   label = 'Select a Manager',
                                   choices = unique(MNGR_PER$ManagerName), width = 500),box(
                                     plotlyOutput('Manager1'), width = 1000))),
                                   
                
                fluidRow(splitLayout(cellWidths= c('50%','50%'),
                                     plotlyOutput('Manager2'),
                                     plotlyOutput('Manager3'))),
                fluidRow(plotlyOutput('Manager4')),height = 1000),
                
        
                  
                    
                    
              
        tabItem(
          tabName = "Department", h2("Department Analysis"),
                fluidRow(box(
                  h3('Pick a Department to see how it performed'),
                  
                  selectizeInput(inputId = 'DepartmentA',
                                 label = 'Select a Department',
                                 choices = unique(Dept_Per$Department), width = 500),box(
                                   plotlyOutput('Department1'), width = 1000))),
          
                fluidRow(splitLayout(cellWidths= c('50%','50%'),
                               plotlyOutput('Department2'),
                               plotlyOutput('Department3') )),
                 fluidRow(plotlyOutput('Department4')),height = 1000),
                
        
                
        tabItem(
          tabName = "PayRate", h2("Pay-Rate Analysis"),
          fluidRow(box(
            h3('Pick a Pay-Rate to see the analysis'),
            
            selectizeInput(inputId = 'PayRateA',
                           label = 'Select a Department',
                           choices = unique(Pay_Per$PayRate,rm.na=TRUE), width = 500),box(
                             plotlyOutput('PayRate1'), width = 1000))),
          
          fluidRow(splitLayout(cellWidths= c('50%','50%'),
                               plotlyOutput('PayRate2'),
                               plotlyOutput('PayRate3') )),
          fluidRow(plotlyOutput('PayRate4')),height = 1000),
                
                
        tabItem(
          tabName = "Age", h2("Age Analysis"),
          fluidRow(box(
            h3('Pick an age to see the analysis'),
            
            selectizeInput(inputId = 'AgeA',
                           label = 'Select an Age',
                           choices = unique(data2$Age,rm.na=TRUE), width = 500),box(
                             plotlyOutput('Age1'), width = 1000))),
          
          fluidRow(splitLayout(cellWidths= c('50%','50%'),
                               plotlyOutput('Age2'),
                               plotlyOutput('Age3') )),
          fluidRow(plotlyOutput('Age4')),height = 1000)
        )))
           
      )




