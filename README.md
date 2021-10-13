# Custom apt-cacher-ng Docker Image

This repository is associated with a blog post, for more details please head to the post [here](https://razinj.dev/build-and-run-apt-cacher-ng-proxy-in-docker).

**Dockerfile features** :

- Allows binding of apt-cacher-ng cache directory with a host directory.

- Allows SSL/TLS proxying _(Keep in mind that this will not cache secured traffic because its encrypted)_.

---

## **Server setup**

### **Docker**

- Build server image :

```bash
docker build -t custom-apt-cacher-ng .
```

- Run a container based on the image built :

```bash
docker run -d -p 3142:3142 --name apt-cacher-ng custom-apt-cacher-ng
```

- Check logs (`ctrl + c` to exit) :

```bash
docker logs -f apt-cacher-ng
```

### **Docker Compose (recommended)**

- Build server image :

```bash
docker-compose build
```

- Run a container based on the image built :

```bash
docker-compose up -d
```

- Check logs (use `ctrl + c` to exit) :

```bash
docker-compose logs -f # Or docker logs -f <docker_container_name>
```

---

## Client config

- Create/Open an empty proxy file

```bash
sudo nano /etc/apt/apt.conf.d/01proxy
```

- Paste the following line there

`Acquire::http { Proxy "http://SERVER_IP:3142"; };`

- **Very important** to execute when manipulating APT proxying

```bash
sudo apt-get clean
cd /var/lib/apt
sudo mv lists lists.bak # or delete it, preferred to make a backup
sudo mkdir -p lists/partial
sudo apt-get clean
sudo apt-get update
```

And voila, You have you own apt-cacher-ng that will proxy all of your machines requests to APT repos.
