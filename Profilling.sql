-- the number of records 
SELECT count(*) NumberRecords 
FROM c4c_ext.prq_contract;

-- number distinct values 
SELECT count(DISTINCT "extension[patientid]/valuestring") as NumberDistinct 
, count(DISTINCT IsNull("extension[patientid]/valuestring", ' ')) as NumberDistinctIncludingNulls 
FROM c4c_ext.prq_contract;

-- the number of nulls
SELECT count(*) as Number_Records 
, count("extension[patientid]/valuestring") as NumberNotNullValues 
, count(*)-count("extension[patientid]/valuestring") as NumberNullValues 
, CASE  
    WHEN count(*)> 0 THEN Cast(100*Cast(count("extension[patientid]/valuestring") As decimal (18,2))/count(*) AS decimal (5,2)) 
     ELSE 0.00  
END as PercentageNotNullValues 
, CASE  
    WHEN count(*)> 0 THEN Cast(100*Cast((count(1)-count("extension[patientid]/valuestring")) As decimal (18,2))/count(1) AS decimal (5,2)) 
     ELSE 0.00  
END as PercentageNullValues  
FROM c4c_ext.prq_contract 

-- distribution of values 
SELECT "component[0]/valuequantity/unit"
, count(*) as NumberRecords 
FROM c4c_ext.prq_questionnaireresponse 
GROUP BY "component[0]/valuequantity/unit"
ORDER BY NumberRecords DESC

-- aggregate values 
 SELECT MIN(birthdate) as Min_
, MAX(birthdate) as Max_ 
, AVG(birthdate) as Average_ 
---STDEV(birthdate) SandardDev_  
FROM c4c_ext.prq_patient;

-- aggregate length values 
SELECT MIN(Len("extension[patientid]/valuestring"))as MinLength 
, MAX(Len("extension[patientid]/valuestring")) as MaxLength 
, AVG(Len("extension[patientid]/valuestring")) as AverageLength            
FROM c4c_ext.prq_contract;
