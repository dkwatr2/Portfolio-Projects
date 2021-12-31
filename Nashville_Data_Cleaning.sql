#Cleaning the Data using SQL Queries

SET SQL_SAFE_UPDATES=0;
Update nashville_housing_data set PropertyAddress= 1
Where PropertyAddress=
(SELECT PropertyAddress
FROM Nashville_data_Analysis.T2
WHERE UniqueID=39432);
SET SQL_SAFE_UPDATES=1;

Create Table T2 as
(Select *
FROM Nashville_data_Analysis.nashville_housing_data
);

#Filling the data where Property Address was not present 
CREATE Table T3 as
(
select * from Nashville_data_Analysis.nashville_housing_data
);

SET SQL_SAFE_UPDATES=0;
Update Nashville_data_Analysis.nashville_housing_data t1 set t1.propertyaddress = (
	select distinct T3.propertyaddress from T3 where t3.uniqueid<>t1.uniqueid and t3.parcelid = t1.parcelid
)
where t1.propertyaddress =1 ;
SET SQL_SAFE_UPDATES=1;

Select PropertyAddress
From Nashville_data_Analysis.nashville_housing_data;

#Filtering the data into address,cities and state

SELECT substring(PropertyAddress,1,LOCATE(',',PropertyAddress)-1) as Address,substring(PropertyAddress,LOCATE(',',PropertyAddress)+1,LENGTH(PropertyAddress))as City
From Nashville_data_Analysis.nashville_housing_data;

ALTER TABLE Nashville_data_Analysis.nashville_housing_data
Add Splitaddress2 varchar(255);

ALTER TABLE Nashville_data_Analysis.nashville_housing_data
Add Splitcity2 varchar(255);

SET SQL_SAFE_UPDATES=0;
Update Nashville_data_Analysis.nashville_housing_data
set Splitaddress2= substring(PropertyAddress,1,LOCATE(',',PropertyAddress)-1);
SET SQL_SAFE_UPDATES=1;

SET SQL_SAFE_UPDATES=0;
Update Nashville_data_Analysis.nashville_housing_data
set Splitcity2= substring(PropertyAddress,LOCATE(',',PropertyAddress)+1,LENGTH(PropertyAddress));
SET SQL_SAFE_UPDATES=1;

#Separating the OwnerAddress

ALTER TABLE Nashville_data_Analysis.nashville_housing_data
Add OwnerSplitAddress varchar(255);

ALTER TABLE Nashville_data_Analysis.nashville_housing_data
Add OwnerSplitCity varchar(255);

ALTER TABLE Nashville_data_Analysis.nashville_housing_data
Add OwnerSplitState varchar(255);

ALTER TABLE Nashville_data_Analysis.nashville_housing_data
Add OwnerCity varchar(255);

SET SQL_SAFE_UPDATES=0;
Update Nashville_data_Analysis.nashville_housing_data
set OwnerSplitAddress= SUBSTRING_INDEX(OwnerAddress,',',1);
SET SQL_SAFE_UPDATES=1;

SET SQL_SAFE_UPDATES=0;
Update Nashville_data_Analysis.nashville_housing_data
set OwnerSplitCity = Substring(OwnerAddress,LOCATE(',',OwnerAddress)+1,LENGTH(OwnerAddress));SET SQL_SAFE_UPDATES=1;


SET SQL_SAFE_UPDATES=0;
Update Nashville_data_Analysis.nashville_housing_data
Set OwnerSplitState= Substring(Ownersplitcity,Locate(',',Ownersplitcity)+1,LENGTH(Ownersplitcity));
SET SQL_SAFE_UPDATES=1;

SET SQL_SAFE_UPDATES=0;
Update Nashville_data_Analysis.nashville_housing_data
Set OwnerCity= SUBSTRING_INDEX(Ownersplitcity,',',1);
SET SQL_SAFE_UPDATES=1;

SET SQL_SAFE_UPDATES=0;
Update Nashville_data_Analysis.nashville_housing_data
SET OwnersplitCity= SUBSTRING_INDEX(OwnerSplitCity,',',1);
SET SQL_SAFE_UPDATES=1;

#Changing Y and N to Yes and No in the SoldAsvacant column

SET SQL_SAFE_UPDATES=0;
Update Nashville_data_Analysis.nashville_housing_data
SET SoldAsVacant=
Case When SoldAsVacant='Y' THEN 'Yes'
		When SoldAsVacant='N' THEN 'No'
        ELSE SoldAsVacant 
        END;
SET SQL_SAFE_UPDATES=1;


#Delete Unused Columns
ALTER TABLE Nashville_data_Analysis.nashville_housing_data
DROP COLUMN OwnerCity;
