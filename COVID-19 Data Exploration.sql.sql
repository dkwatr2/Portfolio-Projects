Select *
From covid_deaths;
WHERE continent is NOT NULL
ORDER BY 3,4

#Selecting the data we need
SELECT location,date,total_cases,new_cases,total_deaths,population
FROM covid_deaths
ORDER BY 1,2

#Calculating the % of deaths by comparing with total cases
#Likelihood of contracting covid if you stay in India 
SELECT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 AS Death_Percentage
FROM covid_deaths
WHERE location='India'
ORDER BY 1,2
#Calculating the % of cases compared to population
SELECT location,date,total_cases,population,(total_cases/population)*100 AS Case_Percentage
FROM covid_deaths
ORDER BY 1,2

#Finding countries with highest infection rate
SELECT location,max(total_cases),population,max((total_cases/population))*100 AS Percent_population_infected
FROM covid_deaths
Group BY location,population
ORDER BY Percent_population_infected DESC

#Showing countries with highest death count per population
Select location,population, max(cast(total_deaths as FLOAT)) as Total_Deathcount,max((total_deaths/Population))*100 AS Deathcount_population
From covid_deaths
where continent IS NOT NULL
Group BY location,population
ORDER BY Total_Deathcount DESC

#Showing by continent
Select continent,max(cast(total_deaths as FLOAT)) as Total_Deathcount,max((total_deaths/Population))*100 AS Deathcount_population
From covid_deaths
WHERE location not in ('High income','Europe','North America','South America','Africa','Oceania','Asia','European Union') 
Group BY continent
ORDER BY Deathcount_population DESC

#Overall numbers
Select sum(new_deaths),sum(new_cases),date, (sum(new_deaths)/sum(new_cases))*100 AS deathpercentage
From covid_deaths
Group by date

#Total population vs Total vaccinations
Create Temporary Table Percentpopulationvaccinated

Select dea.date,dea.continent,dea.location,population,vac.new_vaccinations,SUM(Cast(vac.new_vaccinations AS FLOAT)) OVER (Partition by dea.location Order by dea.location,dea.date) as Rollingpeoplevaccination
From covid_vaccinations vac JOIN covid_deaths dea
ON vac.location=dea.location AND vac.date=dea.date
where dea.continent IS NOT NULL

Select *
From Percentpopulationvaccinated;

Create View Percentpopulationvaccinated
As
Select dea.date,dea.continent,dea.location,population,vac.new_vaccinations,SUM(Cast(vac.new_vaccinations AS FLOAT)) OVER (Partition by dea.location Order by dea.location,dea.date) as Rollingpeoplevaccination
From covid_vaccinations vac JOIN covid_deaths dea
ON vac.location=dea.location AND vac.date=dea.date
where dea.continent IS NOT NULL

Select *
From Percentpopulationvaccinated
