SELECT
   Age,
   IFNULL(ROUND(UserID, 0), '0') AS User_ID,
   IFNULL(Gender,'No_Gender') AS Gender,
   IFNULL(Race, 'No_Race') AS Race,
   IFNULL(Age, 'No_Age') AS Age_Value,
   IFNULL(Province, 'No_Province') AS Province,
   IFNULL(Channel2, 'No_Channel') AS Channel_2,
   IFNULL(RecordDate2, 'No_Recorddate') AS Record_Date2,
   IFNULL(`Duration 2`, 'No_Duration') AS Duration_2,
   RecordDate2,
   from_utc_timestamp(TRY_TO_TIMESTAMP(RecordDate2, 'yyyy-MM-dd HH:mm:ss'), 'Africa/Johannesburg') AS sast_timestamp,
   TRY_CAST(sast_timestamp AS DATE) AS date_column,
   CASE WHEN TRY_CAST(sast_timestamp AS TIMESTAMP) IS NOT NULL THEN DATE_FORMAT(TRY_CAST(sast_timestamp AS TIMESTAMP), 'HH:mm:ss') ELSE 'No_Time' END AS time_column,
   CASE
      WHEN Age IS NULL THEN 'Unknown_age'
      WHEN Age < 13 THEN 'Young_child'
      WHEN Age >= 13 AND Age <= 18 THEN 'Teenager'
      WHEN Age >= 19 AND Age <= 35 THEN 'Young_Adult'
      WHEN Age >= 36 AND Age <= 55 THEN 'Adult'
      WHEN Age >= 56 AND Age <= 65 THEN 'Older_Adult'
      WHEN Age >= 66 THEN 'Senior_Citizen'
      ELSE 'Other'
   END AS Age_Bracket,
   CASE
      WHEN Race is NULL THEN 'Unkown'
      WHEN Race = 'black' THEN 'Black'
      WHEN Race = 'white' THEN 'White'
      WHEN Race = 'coloured' THEN 'Coloured'
      WHEN Race = 'indian_asian' THEN 'Indian_Asian'
      ELSE 'Other'
   END AS Race_Bucket,
   CASE
      WHEN Gender = 'male' THEN 'Male'
      WHEN Gender = 'female' THEN 'Female'
      ELSE 'Other'
   END AS Gender_Bucket,
   CASE
      WHEN Province = 'Eastern Cape' THEN 'Eastern_Cape'
      WHEN Province = 'Gauteng' THEN 'Gauteng'
      WHEN Province = 'Mpumalanga' THEN 'Mpumalanga'
      WHEN Province = 'Limpopo' THEN 'Limpopo'
      WHEN Province = 'Kwazulu Natal' THEN 'Kwa_Zulu_Natal'
      WHEN Province = 'Western Cape' THEN 'Western_Cape'
      WHEN Province = 'Northern Cape' THEN 'Northern_Cape'
      WHEN Province = 'Free State' THEN 'Free_State'
      WHEN Province = 'North West' THEN 'North_West'
      ELSE 'Other'
   END AS Province_Bucket,
   CASE
      WHEN time_column BETWEEN '01:00:00' AND '11:59:59' THEN 'Morning'
      WHEN time_column BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
      WHEN time_column BETWEEN '17:00:00' AND '21:59:59' THEN 'Evening'
      ELSE 'Late_Night'
   END AS Viewing_Times,
   CASE
      WHEN Channel_2 = 'SuperSport Blitz' THEN 'SuperSport_Blitz'
      WHEN Channel_2 = 'Trace TV' THEN 'Trace_TV'
      WHEN Channel_2 = 'Africa Magic' THEN 'Africa_Magic'
      WHEN Channel_2 = 'Channel O' THEN 'Channel_O'
      WHEN Channel_2 = 'ICC Cricket World Cup 2011' THEN 'ICC_Cricket_World_Cup_2011'
      WHEN Channel_2 = 'Cartoon Network' THEN 'Cartoon_Network'
      WHEN Channel_2 = 'kykNET' THEN 'kykNET'
      WHEN Channel_2 = 'SuperSport Live Events' THEN 'SuperSport_Live_Events'
      WHEN Channel_2 = 'Boomerang' THEN 'Boomerang'
      WHEN Channel_2 = 'DStv Events 1' THEN 'DStv_Events1'
      WHEN Channel_2 = 'Live on SuperSport' THEN 'Live_on_SuperSport'
      WHEN Channel_2 = 'CNN' THEN 'CNN'
      WHEN Channel_2 = 'E! Entertainment' THEN 'E!_Entertainment'
      WHEN Channel_2 = 'Vuzu' THEN 'Vuzu'
      WHEN Channel_2 = 'SawSee' THEN 'SawSee'
      WHEN Channel_2 = 'M-Net' THEN 'M-Net'
      WHEN Channel_2 = 'MK' THEN 'MK'
      WHEN Channel_2 = 'Break in transmission' THEN 'Break_in_transmission'
      WHEN Channel_2 = 'Wimbledon' THEN 'Wimbledon'
      ELSE 'No_Channel'
      END AS Channels_Viewed
FROM  `workspace`.`default`.`combined_v_1`;
