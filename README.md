# NHS

This project was done during Kubrick Group Business Data Analyst training.

The purpose was to preprocess NHS data, showing data profiling and data cleansing techniques, as-well as creating new tables that consolidate the post-processed data.

**DATA MODELLING**

Creatley was used as a software to model all the different entity relationships within the NHS dataset.
The foreign key tables around the main table, HES_Wide, were joined and displayed via crow feet notation. 
The most common pairings are many-to-many apart from Sex_T which is one-to-many, i.e. a patient can only have one gender.
The foreign key tables around the main table, HES_Wide, were joined and displayed via crow feet notation. 
The most common pairings are many-to-many apart from Sex_T which is one-to-many, i.e. a patient can only have one gender.
The foreign tables only contained the code, which was the primary key, and the corresponding descriptions.
Many of the code keys were locked to a specific number of characters as provided by the data dictionary. 
The purpose of the modelling is to show how the foreign key tables are used when a search query is executed.

**TABLEAU DESCRIPTION**
My dashboard produces three interactive breakdowns of the NHS data. 
The Ethnicity Split chart is the main switch which when selected, produces an output of both the most common diagnosis for that ethnic category by gender,
The Ethnicity Split chart is the main switch which when selected, produces an output of both the most common diagnosis for that ethnic category by gender, as-well as a proportionate distribution of NHS/Private/Category II patients. 
All three sheets were linked within the dashboard in order to produce a range of scenarios from the user. All null values were also removed from the dashboard too.

Attached below is my Tableau Dashboard

[here](https://public.tableau.com/profile/deven.darshane#!/vizhome/Book1_15568946461090/Dashboard1?publish=yes)
