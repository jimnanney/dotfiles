function flaky
{
    local SPEC=$1
    RET=0
    until [ $RET -ne 0 ]
    do
        bin/spring rspec $SPEC # ./spec/services/nacara_decision_service_spec.rb:376
        RET=$?
    done
}
