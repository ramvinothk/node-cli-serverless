# LS-ENERGY-MANAGEMENT

## Local Development

- install pakcages

    ```sh
    npm install
    ```
## Deploy Using SAM
###Pre Requirement

- Docker
- AWS CLI
- Install AWS SAM CLI
 [Click here](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html)

- Set up AWS Credentials [Click here](https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/setup-credentials.html)

- RUN the following command to build the image
    ```sh
  sam build
     ```
  **success message**
    ```
    Build Succeeded
    
    Built Artifacts  : .aws-sam/build
    Built Template   : .aws-sam/build/template.yaml
     ```
- RUN following command for deployment

    ```sh
    sam deploy --guided --profile <AWS profile name>
  or for default profile
    sam deply --guided
    ```
  this will take some time.
- After deployment success you can find the API end point in lambda
    ```sh 
  https://8k0px0gxp0.execute-api.us-east-1.amazonaws.com/Prod/exe/cmd
  ```
  sample request
    ```sh
  curl --location --request POST 'https://8k0px0gxp0.execute-api.us-east-1.amazonaws.com/Prod/exe/cmd' --form '=@"/Users/ramvinoth/Downloads/Cookiecad+Cutter+-+2022-05-24T015730.254.stl"'
   ```
- To delete the deployed stack
    ```sh
    sam delete --profile <AWS profile name>
  
    or for default profile
  
    sam delete
    ```
## Deploy Using Serverless
###Pre Requirements
1. AWS CLI
2. Docker
3. Set up AWS Credentials [Click here](https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/setup-credentials.html)
- Need to build the docker image manually
    ```sh 
  docker build -t node-app .
   ```
  this will take some time to generate the docker image from docker file.
- Need to Login to ECR 
    ```sh    
   aws ecr get-login-password --region <Your region> | docker login --username AWS --password-stdin <AWS accountId>.dkr.ecr.<Your region>.amazonaws.com
    ```
- Tag your image with the Amazon ECR registry, repository, and optional image tag name combination to use. The registry format is aws_account_id.dkr.ecr.region.amazonaws.com. The repository name should match the repository that you created for your image. If you omit the image tag, we assume that the tag is latest.
  The following example tags a local image with the ID e9ae3c220b23 as aws_account_id.dkr.ecr.region.amazonaws.com/my-repository:tag.
    ```sh
    docker tag e9ae3c220b23 aws_account_id.dkr.ecr.region.amazonaws.com/my-repository:tag
    ```
- Push the image using the docker push command.
    ```sh
    docker push aws_account_id.dkr.ecr.region.amazonaws.com/my-repository:tag
    ```
  [Click here for reference](https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-push-ecr-image.html)
- Add the image url in serverless.yml file
  ```
  image: 109302317414.dkr.ecr.us-east-1.amazonaws.com/node-app:latest
  ```
- Now we can deploy the serverless by the following command
    ```sh
    sls deploy
    ```
- After success you will get the endpoint
    ```
    endpoints:
    POST - https://8d845nzvvi.execute-api.us-east-1.amazonaws.com/dev/exe/cmd
    ```
  ####Note: serverless not yet completed you can use SAM instead of Serverless