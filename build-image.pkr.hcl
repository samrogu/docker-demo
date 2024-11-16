packer {
  required_plugins {
    docker = {
      version = ">= 1.0.8"
      source = "github.com/hashicorp/docker"
    }
  }
}


source "docker" "python39" {
    image = "python:3.9-slim"
    commit = true
}


build {
    sources = ["source.docker.python39"]

    provisioner "file" {
        source      = "./app"
        destination = "/app"
    }

    provisioner "file" {
        source      = "./requirements.txt"
        destination = "/app/requirements.txt"
    }

    provisioner "shell" {
        inline = [
        "pip install --upgrade pip"
        ]
    }

    provisioner "shell" {
        inline = [
        "pip install --no-cache-dir -r /app/requirements.txt"
        ]
    }

    provisioner "shell" {
        inline = [
        "echo 'EXPOSE 5200' >> /app/Dockerfile",
        "echo 'CMD [\"python\", \"/app/app.py\"]' >> /app/Dockerfile"
        ]
    }

      post-processors {
        post-processor "docker-tag" {
            repository =  "imgdockerpy"
            tags = ["0.1"]
        }
    }

}