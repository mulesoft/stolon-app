module github.com/gravitational/stolon-app

go 1.15

require (
	github.com/coreos/prometheus-operator v0.0.0-00010101000000-000000000000 // indirect
	github.com/docker/libkv v0.2.1 // indirect
	github.com/fatih/color v1.9.0
	github.com/ghodss/yaml v1.0.0 // indirect
	github.com/gravitational/logrus v0.10.1-0.20180402202453-dcdb95d728db // indirect
	github.com/gravitational/rigging v0.0.0-20200803191640-2a0fba75cac5
	github.com/gravitational/trace v1.1.8
	github.com/gregjones/httpcache v0.0.0-20180305231024-9cad4c3443a7 // indirect
	github.com/hashicorp/consul v1.0.6 // indirect
	github.com/hashicorp/go-cleanhttp v0.0.0-20171218145408-d5fe4b57a186 // indirect
	github.com/hashicorp/go-rootcerts v0.0.0-20160503143440-6bb64b370b90 // indirect
	github.com/hashicorp/serf v0.8.1 // indirect
	github.com/inconshreveable/mousetrap v1.0.0 // indirect
	github.com/jonboulle/clockwork v0.1.0 // indirect
	github.com/mattn/go-isatty v0.0.12 // indirect
	github.com/minio/minio-go v2.0.4+incompatible // indirect
	github.com/mitchellh/copystructure v1.1.1 // indirect
	github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd // indirect
	github.com/petar/GoLLRB v0.0.0-20130427215148-53be0d36a84c // indirect
	github.com/peterbourgon/diskv v2.0.1+incompatible // indirect
	github.com/sirupsen/logrus v1.6.0
	github.com/sorintlab/stolon v0.0.0-00010101000000-000000000000
	github.com/spf13/cobra v1.0.0
	github.com/spf13/pflag v1.0.5
	gopkg.in/inf.v0 v0.9.1 // indirect
	k8s.io/api v0.15.12
	k8s.io/apiextensions-apiserver v0.0.0
	k8s.io/apimachinery v0.15.12
	k8s.io/client-go v12.0.0+incompatible
	k8s.io/kubernetes v1.15.12
)

replace (
	github.com/coreos/prometheus-operator => github.com/gravitational/prometheus-operator v0.35.2
	github.com/sirupsen/logrus => github.com/gravitational/logrus v1.4.3
	github.com/sorintlab/stolon => github.com/gravitational/stolon v0.2.1-0.20170530142652-8420cb13a635
	k8s.io/api => k8s.io/api v0.15.12
	k8s.io/apiextensions-apiserver => k8s.io/apiextensions-apiserver v0.15.12
	k8s.io/apimachinery => k8s.io/apimachinery v0.15.12
	k8s.io/apiserver => k8s.io/apiserver v0.15.12
	k8s.io/cli-runtime => k8s.io/cli-runtime v0.15.12
	k8s.io/client-go => k8s.io/client-go v0.15.12
	k8s.io/cloud-provider => k8s.io/cloud-provider v0.15.12
	k8s.io/cluster-bootstrap => k8s.io/cluster-bootstrap v0.15.12
	k8s.io/code-generator => k8s.io/code-generator v0.15.12
	k8s.io/component-base => k8s.io/component-base v0.15.12
	k8s.io/cri-api => k8s.io/cri-api v0.15.12
	k8s.io/csi-translation-lib => k8s.io/csi-translation-lib v0.15.12
	k8s.io/kube-aggregator => k8s.io/kube-aggregator v0.15.12
	k8s.io/kube-controller-manager => k8s.io/kube-controller-manager v0.15.12
	k8s.io/kube-proxy => k8s.io/kube-proxy v0.15.12
	k8s.io/kube-scheduler => k8s.io/kube-scheduler v0.15.12
	k8s.io/kubelet => k8s.io/kubelet v0.15.12
	k8s.io/legacy-cloud-providers => k8s.io/legacy-cloud-providers v0.15.12
	k8s.io/metrics => k8s.io/metrics v0.15.12
	k8s.io/sample-apiserver => k8s.io/sample-apiserver v0.15.12
)
