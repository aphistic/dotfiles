function aws
    docker run --rm -it --network host \
        -e AWS_REGION \
        -e AWS_ACCESS_KEY_ID \
        -e AWS_SECRET_ACCESS_KEY \
        amazon/aws-cli $argv
end

function awslocal
    set ls_url {$LOCALSTACK_URL}
    if test -z "$ls_url"
        set ls_url "http://localhost:4566"
    end

    aws --endpoint-url {$ls_url} $argv
end
