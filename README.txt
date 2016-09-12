Predicted flight delays by implementing a naive bayes classifier using the US Dept of Transportation dataset

File Structure:

Prediction - > 	* src/Forest
				* src/FlightWritable
				* src/FlightModelMapper
				* src/FlightClassifyReducer
				* Evaluation

output/part-r-00000 has the expected ouput with each flight having the predicted label
Report.pdf has the implementation details, Confusion Matrix and Execution times

Instructions to Run on Local:
------------------------------

1. Extract the required attributes from the given datasets. Goto the directory which has history and test files

Rscript process.r <historyfilename> <testfilename>

2. If not already done, start the hadoop jobs

make format
make start

3. Move the output files a6history.csv, a6test.csv to data and exceute below command to copy them to hadoop file system

make copy

4. Build the program 

gradle build

5. Now the jar is created at build/libs/Prediction.jar

6. Run the program on hadoop 

make hadoop

7. This might give an error of case mismatch on Mac, So run the below command to delete LICENSE files in the jar and rerun the make hadoop command

zip -d build/libs/Prediction.jar META-INF/LICENSE
make hadoop

8. Output is saved at output/part-r-00000

9. To Evaluate, replace the path to validate file in makefile and run the below command

make evaluate

10. On successful execution, the confusion matrix and accuracy is printed


Instructions to Run on EMR:
---------------------------

1. Make sure you have executed the above steps 1,4,7. These make sure that you have the program jar perfectly running.

2. Run the below command to move the jar to EMR, run the job and get the output when done

make emr

10. On successful execution, the output is saved to emr-ouput/



