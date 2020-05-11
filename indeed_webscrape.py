import urllib.request
from selenium import webdriver
import pandas as pd 
from bs4 import BeautifulSoup
import csv

## Create a .csv file to import data from the scraping to un utf-8 format 
csv_file = open('indeed_test.csv', 'w', encoding='utf-8',newline='')
writer = csv.writer(csv_file)


## create a for loop to go through the range of pages. Indeed website pages increases by 10 per pages,
## so setting the increment to 10. This should go through 500 pages. 
for i in range(0,5000,10):
    try:
## Using Selenium requires the webdriver directory as well as the URL for the website. Appended "+str(i)" so that it increases. 

        driver = webdriver.Chrome(r'C:\Users\Anthony\Desktop\chromedriver.exe')
        URL = "https://www.indeed.com/jobs?q=Covid+Jobs&start="+str(i)
        driver.get("https://www.indeed.com/jobs?q=Covid+Jobs&start="+str(i))


        soup = BeautifulSoup(urllib.request.urlopen(URL).read(), 'html.parser')

        results = soup.find_all('div', attrs={'data-tn-component': 'organicJob'})
## initialize Beautiful soup to go through the all of the jobs - results and scrape the title, company, location, salary,
## summary, and requirements from each job.

        for x in results:

                indeed_dict = {}

                title = x.find('a', attrs={'data-tn-element': "jobTitle"})
                if title:
                    title = title.text.strip()
                    print('title:', title)

                company = x.find('span', attrs={"class":"company"})
                if company:
                    company = company.text.strip()
                    print('company:', company)

                location = x.find('span', attrs={"class":"location accessible-contrast-color-location"})
                if location:
                    location = location.text.strip()
                    print('location:', location )

                salary = x.find('span',attrs={"class": "salaryText"})
                if salary:
                    salary = salary.text.strip()
                    print('salary:', salary )

                summary = x.find('div', attrs={"class": "summary"})
                if summary:
                    summary = summary.text.strip()
                    print('summary:', summary)

                requirement = x.find('div', attrs={"class": "jobCardReqContainer"})
                if requirement:
                    requirement = requirement.text.strip()
                    print('requirement:', requirement)
## adding the text from the scrape for each category to the empty dictionary created "indeed_dict" under their Category
## also added print statement in order to see which page the scrape was currently on, to monitor it through the process.
           
                indeed_dict['Title'] = title
                indeed_dict['Company'] = company
                indeed_dict['Location'] = location
                indeed_dict['Salary'] = salary
                indeed_dict['Summary'] = summary
                indeed_dict['Requirement'] = requirement
                writer.writerow(indeed_dict.values())
        print ('----------'+'Scraping Page'+str(i) + '----------')

            
    except Exception as e:
        print(e)
        csv_file.close()
        driver.close()
        break




    
