# Custom `apt-cacher-ng` Docker Image

This repository is associated with a blog post, for more details please head to the post from [here](https://short.razinj.com/uV0JRD).

**Dockerfile features**:

- Allows binding of apt-cacher-ng cache directory with a host directory.
- Allows SSL/TLS proxying _(Keep in mind that this will not cache secured traffic because its encrypted)_.

## **Server setup**

### **Docker**

- Build server image

```bash
docker build -t custom-apt-cacher-ng .
```

- Run a container based on the image built

```bash
docker run -d \
    -p 127.0.0.1:3142:3142 \
    -v /path/to/cache:/var/cache/apt-cacher-ng
    --name apt-cacher-ng \
    custom-apt-cacher-ng
```

- Check logs (`ctrl + c` to exit)

```bash
docker logs -f apt-cacher-ng
```

### **Docker Compose (recommended)**

- Build server image

```bash
docker-compose build
```

- Run a container based on the image we just built

```bash
docker-compose up -d
```

- Check logs (use `ctrl + c` to exit)

```bash
docker-compose logs -f
```

## Client config

- Create an empty proxy file

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

Let's verify that the setup is working via a simple sudo apt-get update, then head to `http://localhost:3142/acng-report.html` and we should see some content being downloaded and cached for the next requests.

We just set up the apt proxy using either Docker or Docker Compose with ease and we tested the setup using the local host.

---

Consider buying us a coffee ❤️
<div style="text-align: center">
  <a href="https://www.buymeacoffee.com/razinj.dev" target="_blank">
    <img
      src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png"
      alt="Buy Us A Coffee"
      style="height: 60px !important; width: 217px !important"
    />
  </a>
</div>
