#! /bin/bash
while true; do
   terraform apply --auto-approve
   if [ $? -eq 0 ]; then
       break
   fi
   terraform destroy --auto-approve
   sleep 300
done
