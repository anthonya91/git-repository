#Load libraries
library(dplyr)
library(ggplot2)
library(plotly)
library(lubridate)
library(shiny)
library(shinydashboard)

#Import Data
csvpath = "./HRDataset.csv"

data = read.csv(csvpath)
data1 = data %>% select(.,Employee_Name, Position, DOB, Sex, MaritalDesc, DateofHire, DateofTermination, EmploymentStatus,PayRate, Department, ManagerName, 
                        PerformanceScore, EngagementSurvey, EmpSatisfaction, LastPerformanceReview_Date)

## DEPARTMENT VS ENGAGEMENT_SURVEY
Dept_Eng_Graph = ggplot(data1) +
  aes(x = Department, y = EngagementSurvey) +
  geom_boxplot(fill = "#00bf55") +
  labs(title = "Engagement Survey Results", subtitle = "By Department") 


## DEPARTMENT VS PerformanceScore
Dept_Per = data1 %>% count(Department,PerformanceScore,na.rm= TRUE)
Dept_Per = Dept_Per[,-3]
Dept_Per_Graph = ggplot(Dept_Per,aes(y=Department, x=n))+geom_bar(aes(fill= PerformanceScore),position = 'dodge', stat = 'identity')


## DEPARTMENT VS Employee Satisfaction

Dept_EMP = ggplot(data1) +
  aes(x = Department, y = EmpSatisfaction) +
  geom_boxplot(fill = "#00bf55") +
  labs(title = "Employee Satisfaction Results", subtitle = "By Department")



## ManagerName VS PerformanceScore
MNGR_PER = data1 %>% count(ManagerName, PerformanceScore,na.rm= TRUE)
MNGR_PER = MNGR_PER[,-3]
MNGR_PER_Graph = ggplot(MNGR_PER,aes(y=ManagerName, x=n))+geom_bar(aes(fill= PerformanceScore),position = 'dodge', stat = 'identity')
is.na(MNGR_PER$PerformanceScore)
## ManagerName VS ENGAGEMENT_SURVEY
MNGR_ENG = ggplot(data1) +
  aes(y = ManagerName, x = EngagementSurvey) +
  geom_boxplot(fill = "#00bf55") +
  labs(title = "Engagement Survey Results", subtitle = "By Manager Name") 


## ManagerName VS Employee Satisfaction
MNGR_EMP = data1 %>% filter(ManagerName == 'John Smith') %>% 
  ggplot(aes(y = ManagerName, x = EmpSatisfaction)) +
  geom_col(position = 'dodge') +
  ggtitle('Test')

ggplotly(MNGR_EMP)



## PerformanceScore VS EmpSatisfaction
PER_EMPS = data1 %>% group_by(PerformanceScore) %>% 
  summarise(Satisfaction = mean(EmpSatisfaction))


## AGE(DOB) VS ENGAGEMENT_SURVEY
data1 = data1 %>% mutate(DOB =  parse_date_time(DOB, order = c('mdy','mdY') ))
data1 = data1 %>% mutate(DOB =  as.Date(ifelse(DOB > "2012-12-31", format(DOB, "19%y-%m-%d"), format(DOB))))
data1 = data1 %>% mutate(DateofHire =  parse_date_time(DateofHire, order = c('mdy','mdY') ))
data1 = data1 %>% mutate(DateofTermination =  parse_date_time(DateofTermination, order = c('mdy','mdY') ))
data1 = data1 %>% mutate(LastPerformanceReview_Date =  parse_date_time(LastPerformanceReview_Date, order = c('mdy','mdY') ))



#Creating Age column
today = today()
data2 = data1 %>% mutate(Age = floor(decimal_date(today) - decimal_date(DOB)))
data2 = arrange(data2,desc(Age))
data2
##Pay Scale vs PerformanceScore

Pay_Per = data1 %>% count(PayRate,PerformanceScore,na.rm=TRUE)
Pay_Per = Pay_Per[,-3]
Pay_Per_Graph = ggplot(Pay_Per,aes(x=PerformanceScore, y=PayRate))+geom_bar(aes(fill= n),position = 'dodge', stat = 'identity')
