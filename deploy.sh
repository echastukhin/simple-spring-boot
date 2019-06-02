#!/bin/bash


function main() {

   check_minikube_status
   local action=$(get_action "$@")
   local new_version=$(get_new_version "$@")

   if [[ "$action" == "update" ]]; then
       deployment_update $new_version
   elif [[ "$action" == "initial" ]]; then
       initial_deploy
   else
       echo "Wrong action type"
   fi

   echo "Done..."
}

function initial_deploy() {

   build_application_and_docker_image
   prepare_k8s_manifest
   apply_k8s_manifest
   print_result_note

}
function check_minikube_status() {
    local catched_lines_count=$(minikube status | grep "Running\|Correctly Configured" | wc -l)
    if [[ $catched_lines_count -lt 4 ]]; then
        echo "It seems minikube is not running, please run it first"
	exit 1;
    fi
}

function build_application_and_docker_image() {
   eval $(minikube docker-env)
   mvn clean package
}

function prepare_k8s_manifest() {
    local auto_generated_manifest="target/classes/META-INF/fabric8/kubernetes.yml"
    local manifest="target/kubernetes.yml"
    if [[ -f $auto_generated_manifest ]]; then
        head -n $(($(grep -n "^\s\+- env:" $auto_generated_manifest | cut -d":" -f1) - 1)) $auto_generated_manifest > $manifest
    else
        echo "Can not construct k8s manifest file"
        return 1
    fi
}
function apply_k8s_manifest() {
    kubectl create -f target/kubernetes.yml || exit
}

function deployment_update() {
    local new_version=$1
    if [[ -n $new_version ]]; then
        kubectl --record deployment.apps/ping-pong set image deployment.v1.apps/ping-pong ping-pong=ping-pong:$new_version
    else
        echo "Wrong version argument"
    fi

}

function print_result_note() {
    local cluster_ip=$(minikube ip)
    echo -e "application avaliable on following address:\nhttp://${cluster_ip}:30001 "
}

function get_action() {
    if [[ ${#@} -ge 1 ]]; then
        echo "$1"
    else
        echo
    fi
}

function get_new_version() {
    if [[ ${#@} -ge 2 ]]; then
        echo "$2"
    else
        echo
    fi
}

main "$@"
