create tunnel in cloudflare gui, save token
pass token in to
cloudflared:
 token:
enable prizma
setup tunnel with prizma as endpoint in cloudflare gui
public hostname
bb-cloud-prizma.bestbytes.com
service:
type tcp
localhost:443
additional settings: connection: proxy type: socks

setup supervisor:
enable
create github provider
create federation domain
wait for supervisor to acquire loadbalancer ip
connect supervisor dns record to loadbalancer ip

setup concierge
create clusterrolebindings

start cloudflare tunnel on local machine:
cloudflared access tcp --hostname bb-cloud-prizma.bestbytes.com --url 127.0.0.1:1234

get pinniped kubeconfig using the original kubeconfig, through the tunnel:

HTTPS_PROXY=socks5://127.0.0.1:1234 pinniped get kubeconfig \
  --kubeconfig "path/to/kubeconfig/kubeconfig.yaml" > pinniped-kubeconfig.yaml

connect to the cluster:

HTTPS_PROXY=socks5://127.0.0.1:1234 kubectl get namespaces \
  --kubeconfig "path/to/kubeconfig/pinniped-kubeconfig.yaml"