
job "nginx-app" {
  datacenters = ["dc1"]
  type        = "service"

  group "web" {
    count = 1

    update {
      max_parallel      = 1
      min_healthy_time  = "10s"
      healthy_deadline  = "3m"
      progress_deadline = "5m"
      auto_revert       = true
    }

    network {
      port "http" {
        to = 8080
      }
    }

    service {
      name     = "nginx-app"
      provider = "consul"
      port     = "http"

      tags = [
        "web",
        "nginx",
        "devops-command-hub"
      ]

      check {
        name     = "nginx-http-health"
        type     = "http"
        port     = "http"
        path     = "/healthz"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "nginx" {
      driver = "docker"

      config {
        image      = "ghcr.io/tunecci/devops-command-hub:latest"
        ports      = ["http"]
        force_pull = true
      }

      resources {
        cpu    = 100
        memory = 64
      }
    }
  }
}
