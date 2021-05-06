#steps to run this assignment

Clone this repo and follow below steps.

NOTE:- replace your aws credential files and aws instance access key.


![image](https://user-images.githubusercontent.com/61050480/117343249-b98ed980-aec1-11eb-9c11-0b6d29815700.png)

Step 1:-
write below command to initialize a working directory containing Terraform configuration files.

$ terraform init
![image](https://user-images.githubusercontent.com/61050480/117343613-17232600-aec2-11eb-8bae-89a780dd505f.png)


step 2:- 
Try a dry run by using below command
$  terraform plan

![image](https://user-images.githubusercontent.com/61050480/117343887-68331a00-aec2-11eb-9e02-c6ac2317d8fb.png)
![image](https://user-images.githubusercontent.com/61050480/117344093-a92b2e80-aec2-11eb-8c6e-505c713c984a.png)


step 3:-
run below command to apply changes

$ terraform apply
![image](https://user-images.githubusercontent.com/61050480/117344360-eee7f700-aec2-11eb-8571-321ddeae77b2.png)
 
 
 
 after this check aws console
 
 
 ![image](https://user-images.githubusercontent.com/61050480/117344514-14750080-aec3-11eb-95d4-8caed577e305.png)


a new ec2 instance is running.

check ssh access by using access key and public ip.

by using below command, replace accordingly

$  ssh -i key.pem  ec2-user@public-ip
