Data Cleaning Course April 2014 -Human Activity Recognition Dataset
========================
##The dataset comes from the Human Activity Recognition Using Smartphones data set. The ultimate objectives are 1) concatenate both the test and train datasets to create one large dataset, 2)obtain means and standard deviations of the features measured during the experiment, and 3) create a second tidy dataset that contains the means of all the features for each subject, for each activity he or she was engaged in during the experiment.  Additionally, a Codebook that describes all of the variables in the dataset(s) was created as well as a 'READ ME' file, the contents of which you are currently reading at the moment.

##The downloaded zip file contains observations from experiments carried out on 30 volunteers who ranged in age from 19 to 48 years. Six different activities were performed by each person: walking, walking up (the stairs), walking down (the stairs), sitting, standing and laying.  While performing each activity, the volunteer wore a Samsung Galaxy S II Smartphone on their waist. The phones contained embedded accelerometers and gyroscopes, which captured 3-axial linear acceleration and 3-axial angular velocity at a rate of 50Hz.  

##The downloaded zip file contains the following that were used to achieve the aforementioned objectives:
  *'features_info.txt': Shows information about the variables used on the feature     vector.
  * 'features.txt': Lists of all features.
  * 'activity_labels.txt': Links the class labels with their activity name.
  * 'train/X_train.txt': Training set.
  * 'train/y_train.txt': Training labels.
  * 'test/X_test.txt': Test set.
  * 'test/y_test.txt': Test labels.

##The R script called run_analysis.R does the following:
  * 1. Merges the training and the test sets to create one data set. 
  (samsungData)
  * 2. Creates a tidy data set (labels the variables of the dataset and applies the appropriate labels to the associated activities for all observations). 	
  (samsungData)
  * 3. Extracts the mean and standard deviations for all feature measurements. (samsungData.summ)
  * 4. Creates another dataset with the average of each variable for each activity and each subject. (samsungDatameans.rda)



