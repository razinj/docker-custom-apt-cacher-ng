# Custom apt-cacher-ng Docker image

## Code from the blog post hosted on RAZINJ Dev

**Dockerfile features :**

- Allow binding of apt-cacher-ng cache directory

- Allow SSL/TLS proxying (pay attention that this will not cache secured traffic because its encrypted)

---

## Server setup and client config

## **Server setup**

### _Docker_

- Build server image : `docker build -t custom-apt-cacher-ng .`
- Run a container based on the image built : `docker run -d -p 3142:3142 --name apt-cacher-ng apt-cacher-ng`
- Check logs (`ctrl + c` to exit) : `docker logs -f apt-cacher-ng`

### _Docker Compose (preferred)_

- Build server image : `docker-compose build`

- Run a container based on the image built : `docker-compose up -d`

- Check logs (`ctrl + c` to exit) : `docker-compose logs -f`

---

## Client config

- Create/open an empty proxy file

```bash
sudo nano /etc/apt/apt.conf.d/01proxy
```

- Paste the following line there

`Acquire::http { Proxy "http://SERVER_IP:3142"; };`

- **Very important** to execute when manipulating apt proxy

```bash
sudo apt-get clean
cd /var/lib/apt
sudo mv lists lists.bak # or delete it, preferred to make a backup
sudo mkdir -p lists/partial
sudo apt-get clean
sudo apt-get update
```

And voila, You have you own apt-cacher-ng that will proxy all of your machines requests to apt repos
