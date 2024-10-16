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


![copy git repo url](<images/CICD with Jenkins/copy git repository link.png>)

click configure, then click pipeline syntax

![click pipeline syntax](<images/CICD with Jenkins/click pipeline syntax.png>)

From the Sample step
* select checkout: Check out from version control

![select checkout from git version control](<images/CICD with Jenkins/pick checkout from git version control.jpg>)

* provide your git repository url (copy that by clicking code on your git repository)

![provide git url in jenkins](<images/CICD with Jenkins/provide git repo url inside jenkins.png>)

Now, we need to provide some Aunthentication

*click on Add Jenkins

![click Add](<images/CICD with Jenkins/provide git repo url inside jenkins.png>)

![select Jenkins](<images/CICD with Jenkins/jenkins pops up, then select it.jpg>)


* you should see username with password then add your username and password, username: your github account username

![type your github username](<images/CICD with Jenkins/Screenshot 2024-10-10 050412.png>)


password: you need to generate the password from your github by generating a token for Authentication

How to generate password

* go to github
* go to setting (ensure you access the setting from clicking the placeholder for your github profile picture, that's where you can see develpoer settings)

![go to settings but from the profile placeholder](<images/CICD with Jenkins/Access setting from profile picture placeholder.png>)

* click developer settings

![developer setting shown](<images/CICD with Jenkins/click developer settings.png>)

   - go to personal access tokens

![Personal Token under developer setting](<images/CICD with Jenkins/Click Personal Access Tokens, select token classic.png>)

   - click generate new token drop down,  click generate new token (classic)

![generate new token image shown](<images/CICD with Jenkins/generate new token classic.png>)

   - give any name in the tab called "Note" provided

   - select expiration time from the Expiration* drop down

   - Check all boxes in the Select Scopes 

   - Click generate token

![image showing the action listed above](<images/CICD with Jenkins/give a name then check all boxes.png>)

![image showing the action listed above](<images/CICD with Jenkins/give a name then check all boxes 2.png>)

![image showing the action listed above](<images/CICD with Jenkins/give a name then check all boxes 3.png>)

![token generated](<images/CICD with Jenkins/token generated.png>)

Copy the token from github then paste in the password column on Jenkins, give it an ID then Add

![copy and paste token generated](<images/CICD with Jenkins/paste token, add any name, click add.png>)

In the credentials, select your credential at the far end of the list

![select the newly added credential](<images/CICD with Jenkins/pick the newly added credential.png>)

Ensure you are on Either Master or Main branch, confirm that from your github

![be sure you typed in the correct branch nanme](<images/CICD with Jenkins/master must be chaged to main (check github to be sure it's main if not leave it as master.png>)

Generate pipeline script, then copy

![generate pipeline script](<images/CICD with Jenkins/generate pipeline script.png>)

Paste the generated script replacing Hello World

![paste the generated script](<images/CICD with Jenkins/paste generated script and save.png>)

Now run build again to comfirm no build error

![build 2](<images/CICD with Jenkins/run BuIld now again to be sure there's no error.png>)

TO Configure Webhook in Github and Jenkins

Go to github setting, click webhook

![click webhook](<images/CICD with Jenkins/webhook, copy and paste jenkins url in it.png>)

Paste Jenkins url, ensure to add this to the jenkins url /github-webhook/ then click add webhook

![paste jenkins url](<images/CICD with Jenkins/Screenshot 2024-10-10 053048.png>)

Check if  you get green tick icon

![webhook Successful](<images/CICD with Jenkins/webhook sucessful.png>)

Now Let's configure github in JENKINS

- go to Jenkins pipeling, tick configure

Github hook trigger for GitScm polling, then save

![tick the box](<images/CICD with Jenkins/GitSCM.png>)

Jenkins Github integration is then fully completed

![build incrasing](<images/CICD with Jenkins/Build keeps increasing as you push to the main branch.png>)
