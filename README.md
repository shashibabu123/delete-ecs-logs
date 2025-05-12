# delete-ecs-logs
1. **Set up AWS CLI**
   Ensure you have the AWS CLI installed and configured with the necessary permissions to delete CloudWatch log groups. [[offical_doc]](https://docs.aws.amazon.com/solutions/latest/video-on-demand-on-aws-foundation/deleting-the-cloudwatch-logs.html)

2. **Create the shell script**
   Create a new file with a .sh extension (e.g., delete_ecs_logs.sh) and add the following content:

   ```bash
   #!/bin/bash

   # Set your AWS region
   AWS_REGION="us-east-1"

   # Get all log groups with the /ecs prefix
   LOG_GROUPS=$(aws logs describe-log-groups --log-group-name-prefix /ecs --region $AWS_REGION --query 'logGroups[*].logGroupName' --output text)

   # Loop through each log group and delete it
   for LOG_GROUP in $LOG_GROUPS
   do
     echo "Deleting log group: $LOG_GROUP"
     aws logs delete-log-group --log-group-name $LOG_GROUP --region $AWS_REGION
   done

   echo "All ECS log groups have been deleted."
   ```

3. **Make the script executable**
   Run the following command to make the script executable:
   ```
   chmod +x delete_ecs_logs.sh
   ```

4. **Review and customize the script**
   Before running the script, review it carefully and make any necessary adjustments:
   - Update the `AWS_REGION` variable if your logs are in a different region.
   - Modify the `--log-group-name-prefix` if your ECS logs use a different prefix.

5. **Run the script**
   Execute the script using:
   ```
   ./delete_ecs_logs.sh
   ```

6. **Monitor the deletion process**
   The script will output the names of log groups as they are being deleted. Monitor the process to ensure all intended log groups are removed.

By following these steps, you'll create and run a shell script that deletes all ECS logs in CloudWatch. Remember to use this script cautiously, as it will permanently delete the specified log groups. Always ensure you have necessary backups and that you're operating in the correct AWS account and region.

It's important to note that this script assumes all ECS logs are prefixed with "/ecs". If your logs use a different naming convention, you'll need to adjust the script accordingly. Additionally, consider implementing appropriate error handling and logging mechanisms for production use.


