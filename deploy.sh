#!/bin/bash


function main() {
   check_minikube_status
   build_application
   build_docker_image
   run_k8s_deploymint
   run_k8s_service
   print_result_note
   echo "OK"
}

function check_minikube_status() {
    local catched_lines_count=$(minikube status | grep "Running\|Correctly Configured" | wc -l)
    if [[ $catched_lines_count -lt 4 ]]; then
        echo "It seems minikube is not running, please run it first"
	exit 1;
    fi
}

function build_application() {
   mvn clean install
}

function build_docker_image() {
   eval $(minikube docker-env)
   docker build -t ping-pong:0.0.1 target/ -f src/main/docker/Dockerfile
}

function run_k8s_deploymint() {
    kubectl create -f k8s/deployment
}

function run_k8s_service() {
    kubectl create -f k8s/service
}

function print_result_note() {
    local cluster_ip=$(minikube ip)
    echo -e "application avaliable on following address:\nhttp://${cluster_ip}:30001 "
}

main
