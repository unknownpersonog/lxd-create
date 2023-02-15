echo "Starting Container Creation..."
sleep 2
echo "Name the container: "
read -r container_name
echo "Creating container"
lxc launch images:debian/11 "$container_name"
lxc config set "$container_name" limits.cpu.allowance 10%
lxc config set "$container_name" limits.memory 256MB
lxc config device override "$container_name" root size=750MB
lxc exec "$container_name" -- apt update
lxc exec "$container_name" -- apt install wget openssh-server -y
echo "SSH Port: "
read -r port
lxc config device add "$container_name" ssh proxy listen=tcp:0.0.0.0:"$port" connect=tcp:127.0.0.1:22
echo "Container Creation Success! Name: "$container_name""
