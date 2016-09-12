#!/bin/bash

# EMR results

aws s3 mb s3://A7bucket
aws s3 cp build/libs/Prediction.jar s3://A7bucket/code/
aws s3 cp data/ s3://A7bucket/data --recursive

# Create Cluster

aws emr create-default-roles
aws emr create-cluster --name "PredictionCluster" --release-label emr-4.3.0 --instance-groups InstanceGroupType=MASTER,InstanceCount=1,InstanceType=m3.xlarge InstanceGroupType=CORE,InstanceCount=2,InstanceType=m3.xlarge --steps Type=CUSTOM_JAR,Name="Custom JAR Step",ActionOnFailure=CONTINUE,Jar=s3://A7bucket/code/Prediction.jar,MainClass=Forest,Args=["s3://A7bucket/data","s3://A7bucket/output"] --auto-terminate --log-uri s3://A7bucket/logs --service-role EMR_DefaultRole --ec2-attributes InstanceProfile=EMR_EC2_DefaultRole,AvailabilityZone=us-east-1a --enable-debugging >> cluster.txt

aws emr describe-cluster --cluster-id  $(cat cluster.txt| jq -r .ClusterId)| jq -r .Cluster.Status.State
echo 'Creating the cluster...';
while [[ "$(aws emr describe-cluster --cluster-id $(cat cluster.txt| jq -r '.ClusterId') | jq '.Cluster.Status.State')" != "\"TERMINATED\""  &&  "$(aws emr describe-cluster --cluster-id $(cat cluster.txt| jq -r '.ClusterId') | jq '.Cluster.Status.State')" != "\"TERMINATING\"" ]]
do
	echo "Waiting for the cluster to terminate...";
done 

echo "Cluster terminated";

mkdir emr-output
aws s3 sync s3://A7bucket/output/ emr-output/ 
