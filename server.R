function(input,output,session){
  
  
  ############ Managers Data ###########
  
  output$Manager1 = renderPlotly({
    g = MNGR_PER %>% filter(ManagerName == input$ManagerA) %>% 
      ggplot(aes(y=ManagerName, x=n, fill= PerformanceScore))+geom_bar(position = 'dodge', stat = 'identity')+
      ggtitle("Performance Score by Manager")+xlab('number of employees')
    ggplotly(g)
    })
    
 output$Manager2 = renderPlotly({
   g = data1 %>% filter(ManagerName == input$ManagerA) %>% 
     ggplot(aes(x = ManagerName, y = EmpSatisfaction)) +
     geom_count(color = 'blue') +
     labs(title = "Employee Satisfaction Results", subtitle = "By Manager")
   ggplotly(g)
 })   
 
 output$Manager3 = renderPlotly({
   g = data1 %>% filter(ManagerName == input$ManagerA) %>% 
     ggplot(aes(x = ManagerName, y = EngagementSurvey)) +
     geom_count(color = 'green') +
     labs(title = "Engagement Survey Results", subtitle = "By Manager")
   ggplotly(g)
 })
 
 output$Manager4 = renderPlotly({
    g = MNGR_PER %>% ggplot(aes(y=ManagerName, x=n, fill= PerformanceScore))+
       geom_bar(position = 'dodge', stat = 'identity')+
       ggtitle("Performance Score by all Managers")+xlab('number of employees')
      ggplotly(g)

 })
 
 output$Department1 = renderPlotly({
   g = Dept_Per %>% filter(Department == input$DepartmentA) %>% 
     ggplot(aes(y=Department, x=n, fill= PerformanceScore))+geom_bar(position = 'dodge', stat = 'identity')+
     ggtitle("Performance Score by Department")+xlab('number of employees')
   ggplotly(g)
 })
 
 output$Department2 = renderPlotly({
   g = data1 %>% filter(Department == input$DepartmentA) %>% 
     ggplot(aes(x = Department, y = EmpSatisfaction)) +
     geom_count(color = 'blue') +
     labs(title = "Employee Satisfaction Results", subtitle = "By Department")
   ggplotly(g)
 })   
 
 output$Department3 = renderPlotly({
   g = data1 %>% filter(Department == input$DepartmentA) %>% 
     ggplot(aes(x = Department, y = EngagementSurvey)) +
     geom_count(color = 'green') +
     labs(title = "Engagement Survey Results", subtitle = "By Department")
   ggplotly(g)
 })   
 
 output$Department4 = renderPlotly({
    g = data1 %>%  
       ggplot(aes(x = Department, y = EngagementSurvey)) +
       geom_bar(position = 'dodge', stat = 'identity') +
       labs(title = "Employee Satisfaction Results", subtitle = "By all Department")
    ggplotly(g)
 })   
 
 
 output$PayRate1 = renderPlotly({
   g = Pay_Per %>% filter(PayRate == input$PayRateA) %>% 
     ggplot(aes(x=PayRate, y=n, fill= PerformanceScore))+geom_bar(position = 'dodge', stat = 'identity')+
     ggtitle("Performance Score by Pay Rate")+xlab('Performance Score')+ylab('Performance Score Count')
   ggplotly(g)
 })
 
 output$PayRate3 = renderPlotly({
   g = data1 %>% filter(PayRate == input$PayRateA) %>% 
     ggplot(aes(x = PayRate, y = EngagementSurvey)) +
     geom_count(color = 'green') +
     labs(title = "Engagement Survey Results", subtitle = "By Pay-Rate")
   ggplotly(g)
 })
 
 output$PayRate2 = renderPlotly({
   g = data1 %>% filter(PayRate == input$PayRateA) %>% 
     ggplot(aes(x = PayRate, y = EmpSatisfaction)) +
     geom_count(color = 'blue') +
     labs(title = "Employee Satisfaction Results", subtitle = "By Pay-Rate")
   ggplotly(g)
 })   
 
 output$PayRate4 = renderPlotly({
    g = data1 %>%  
       ggplot(aes(x = PayRate, y = EngagementSurvey)) +
       geom_point(position = 'dodge', stat = 'identity') +
       labs(title = "Employee Survey Results", subtitle = "By all Department")
    ggplotly(g)
 })
 today = today()
 data2 = data1 %>% mutate(Age = floor(decimal_date(today) - decimal_date(DOB)))
 data3 = arrange(data2,desc(Age))

 output$Age1 = renderPlotly({
   g = data2 %>% count(Age,PerformanceScore,na.rm=TRUE) %>%
     filter(Age==input$AgeA) %>% 
     ggplot(aes(x=Age, y=n, fill= PerformanceScore))+geom_bar(position = 'dodge', stat = 'identity')+
     ggtitle("Performance Score by Age")+xlab('Performance Score')+ylab('Performance Score Count')
   ggplotly(g)
 })
 
 output$Age2 = renderPlotly({
    g = data2 %>% filter(Age == input$AgeA) %>% 
       ggplot(aes(x = Age, y = EmpSatisfaction)) +
       geom_count(color = 'blue') +
       labs(title = "Employee Satisfaction Results", subtitle = "By Age")
    ggplotly(g)
 })
 
 output$Age3 = renderPlotly({
    g = data2 %>% filter(Age == input$AgeA) %>% 
       ggplot(aes(x = Age, y = EngagementSurvey)) +
       geom_count(color = 'green') +
       labs(title = "Engagement Survey Results", subtitle = "By Age")+ylab('Engagement Count')
    ggplotly(g)
 })
 
 output$Age4 = renderPlotly({
    g = data2 %>%  
       ggplot(aes(x = Age, y = EngagementSurvey)) +
       geom_point(position = 'dodge', stat = 'identity') +
       labs(title = "Employee Survey Results", subtitle = "By all ages")
    ggplotly(g)
 })
  
}