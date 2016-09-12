
format: 
	hdfs namenode -format

start:
	start-dfs.sh
	start-yarn.sh
	mr-jobhistory-daemon.sh start historyserver

stop:
	mr-jobhistory-daemon.sh stop historyserver
	stop-yarn.sh
	stop-dfs.sh

sudeep:
	hadoop fs -mkdir -p /user/Sudeep
	hadoop fs -mkdir -p /user/Sudeep/input

copy:
	hadoop fs -put data/* input/


clean:
	rm -r output


hadoop:
	rm -r output
	hadoop fs -rm -r output
	hadoop jar build/libs/Prediction.jar input output
	hadoop fs -get output

evaluate:
	javac Evaluation.java
	java Evaluation output/part-r-00000 <path/to/validate/file>

emr:
	./emr.sh


	

