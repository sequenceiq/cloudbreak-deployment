### Automated deployment of Cloudbreak on premise

We have automated the process of installing/deploying Cloudbreak on a local/on prem Linux environment. In case you'd like to host Cloudbreak please follow the instructions below. In a few minutes you will have all the containers started with all the components installed (Cloudbreak, Sultans, Uluwatu, UAA, PostgreSQL).

##### Required variables for the host
In order to launch the deployemy fill the `start.sh` script with the appropriate values:
   
  * HOST_ADDRESS - the bind address of Cloudbreak (e.g. http://localhost if you deploy it on your laptop)
  * CLOUDBREAK_PUBLIC_HOST_ADDRESS - the external IP address for sending back notifications

##### Required variables for Cloudbreak
Rename the `env_props.sh.sample` to `env_props.sh` and fill with appropriate values:

  * CB_SMTP_SENDER_USERNAME - the username to the used SMTP server
  * CB_SMTP_SENDER_PASSWORD - the password to the used SMTP server
  * CB_SMTP_SENDER_HOST - the SMTP server host
  * CB_SMTP_SENDER_PORT - the SMTP server port
  * CB_SMTP_SENDER_FROM - The value of the from field in emails sent by the system
  * AWS_ACCESS_KEY_ID - your AWS access key
  * AWS_SECRET_KEY - your AWS secret key
  * UAA_DEFAULT_USER_EMAIL - default Cloudbreak user in UAA
  * UAA_DEFAULT_USER_PW - default Cloudbreak password in UAA
  * UAA_DEFAULT_USER_FIRSTNAME - default Cloudbreak user's firstname
  * UAA_DEFAULT_USER_LASTNAME - default Cloudbreak user's firstname

### Deploy Cloudbreak
If all the required variables are set you can start the deployment by invoking `start.sh`. 
