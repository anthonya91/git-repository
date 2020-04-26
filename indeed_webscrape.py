import urllib.request
from selenium import webdriver
import pandas as pd 
from bs4 import BeautifulSoup
import csv

csv_file = open('indeed_test.csv', 'w', encoding='utf-8',newline='')
writer = csv.writer(csv_file)

for i in range(0,5000,10):
    try:


        driver = webdriver.Chrome(r'C:\Users\Anthony\Desktop\chromedriver.exe')
        URL = "https://www.indeed.com/jobs?q=Covid+Jobs&start="+str(i)
        driver.get("https://www.indeed.com/jobs?q=Covid+Jobs&start="+str(i))
        #driver.fullscreen_window()

        soup = BeautifulSoup(urllib.request.urlopen(URL).read(), 'html.parser')

        results = soup.find_all('div', attrs={'data-tn-component': 'organicJob'})

        data = pd.DataFrame(columns=["Title","Company","Location","Salary","Summary","Requirements"])

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




    
