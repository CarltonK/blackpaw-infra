if [ -d "environments/$1/" ]; then
    cd environments/$1
    terraform init
else
    for dir in environments/*/
        do 
            cd ${dir}   
            env=${dir%*/}
            env=${env#*/}
            echo ""
            echo "*************** TERRAFORM INIT ******************"
            echo "******* Environment: ${env} ********"
            echo "*************************************************"
            terraform init || exit 1
            cd ../../
        done
fi