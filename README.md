# capstone-project

# TERRAFORM
Initialize and Apply Terraform Configuration:
Initialize Terraform: terraform init

Apply the configuration: terraform apply
![terraform apply output](<images/terraform ss.png>)

 # JENKINS

Launch an ec2 instance on aws 
![ec2-instance](<images/EC2 INSTANCE jenkins.png>)

In your security group ensure to open these ports 443, 8080, 22, 80
![security group](<images/security group inbound rule opened.png>)

ssh into your ec2 instance (in this case i will be using EC2 instance connect)
![ssh-into-ec2-instance](<images/ssh into ec2.png>)

sudo apt update
![ec2 instance update](<images/sudo update.png>)

sudo apt install openjdk-11-jre
![openjdk installation begins](<images/opendjk install before typing Yes.png>)
![openjdk completed](<images/open jdk installation completed.png>)

Now;
visit this site on your browser

pkg.jenkins.io
![jenkins package website](images/pkg.jenkins.io.png)

Click debian-stable/
![debian-stable page](<images/pkg.jenkins.io debian-stable.png>)

Then copy the copy one by one and paste in your ec2 instance

wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
![jenkins show ok](<images/jenkins ok.png>)

sudo apt update
![ec2 update again](<images/apt update again.png>)

sudo apt-get install fontconfig openjdk-17-jre
![font config](<images/install fontconfig openjdk-17-jre .png>)
![font config completed](<images/config 2.png>)

sudo apt-get install jenkins
![installing jenkins](<images/install jenkins.png>)
![jenkins installed](<images/jenkins finally installed.png>)

Access your jenkins in you browser with your ec2 public ipv4 address include :8080 at the end of the public ipv4 address
![jenkins page](<images/unlock jenkins page.png>)

To get Administrator Password
on the jenkins admin page
![jenkins admin page](<images/Jenkins admin first page.png>)

cat the the directory shown there in your ec2 server you already ssh into
sudo cat /var/lib/jenkins/secrets/initialAdminPassword (you will see on your jenkins page), this command will help you get your admin password
![cat to see the admin password](<images/cat to see password.png>)

Create an Admin user 
![admin user sample page](<images/admin user sample.png>)

Then you will be taken to another page to customize jenkins
![customize jenkins](<images/homepage to customize jenkins.png>)

Install all plugins or specific depending on your used case (here i will be installing all recommendded plugins)
![install plugins](<images/install jenkins.png>)

You will see Jenkins path Url
![jenkins path](<images/jenkins url.png>)

Then you will receive a prompt noting that Jenkins is Ready
![Jenkins is Ready](<images/Jenkins admin first page.png>)

# CICD with Jenkins

Create New Job with Pipeline
Under pipeline 
* select pipeline script
* select hello world as sample
![hello world script on pipeline script](<images/CICD with Jenkins/select pipeline script.png>)

Run Sample Code
![build hello world sample code](<images/CICD with Jenkins/build hello world sample code.png>)

Do Check-out Using Declarative Format


click configure, then click pipeline syntax
![click pipeline syntax](<images/CICD with Jenkins/click pipeline syntax.png>)


From the Sample step
* select checkout: Check out from version control

* provide your git repository url (copy that by clicking code on your git repository)
![copy git repo url](<images/CICD with Jenkins/copy git repository link.png>)

* click on Add Jenkins, then add your username and password
username: your github account username
password: you need to generate the password from your github by generating a token for Authentication
How to generate password
* go to github
* go to setting (ensure you access the setting from clicking the placeholder for your github profile picture, that's where you can see develpoer settings)
* click developer settings
   - go to personal access tokens
   - click generate new token drop down
   - click generate new token (classic)
   - give any name in the tab called "Note" provided
   - select expiration time from the Expiration* drop down
   - Check all boxes in the Select Scopes 
   - Click generate token


Authentication

Configure Webhook in Github and Jenkins
