if [ -d "environments/$1/" ]; then
    cd environments/$1
    terraform plan -out=/workspace/plan.out
    terraform show -json /workspace/plan.out > /workspace/plan.json
else
    for dir in environments/*/
        do 
            cd ${dir}   
            env=${dir%*/}
            env=${env#*/}  
            echo ""
            echo "*************** TERRAFORM PLAN ******************"
            echo "******* Environment: ${env} ********"
            echo "*************************************************"

            terraform plan -lock=false -out=/workspace/plan.out || exit 1
            cd ../../
        done
fi